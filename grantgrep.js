'use strict'

const exec = require('child_process').execSync

const lines = exec('grep -rn csgrant\. .').toString().split('\n')

const ignored = []
const locals = []
const modules = {}
const calls ={}


function extractRepos(lines) {
  const repos = new Set()
  for (let i in lines) {
    const l = lines[i]
    const line = l.split('\n')[1]
    const sub = line.substring(line.indexOf('./cloudsim-'))
    const head = sub.split('/')[1]
//    console.log('DEBUG', sub, head)
    repos.add(head)
  }

  const r = Array.from(repos)
  return r.sort()
}

function splitGrant(grant, log) {
  // cut the left of first csgrant
  const grant1 = grant.substring(grant.indexOf('csgrant.'))
  const toks = grant1.split('csgrant.')
  const res = []
  for (let i in toks) {
    const grant2 = toks[i]
    if (grant2.indexOf(' ') == 0)
      continue
    if (grant2.indexOf("'") == 0)
      continue
    const grant3 = grant2.split('(')[0]
    const grant4 = grant3.trim()
    const grant5 = grant4.replace(')', '')
    const grant6 = grant5.replace(',', '')
    if (grant6.length > 0)
      res.push(grant6)
    if (log)
      log(grant, '|', grant1, '|', grant2, '|', grant3, '|', grant4, '|', grant5, '|', grant6)
  }

  return res
}

for (let i in lines) {
  const line = lines[i]
  if (line.indexOf('require') != -1 ) {
    ignored.push(line)
    continue
  }
  const toks = line.split(':')
  if (toks.length < 3 ) {
    ignored.push(line)
    continue
  }

  const file = toks[0]
  const nb = toks[1]
  const grant = toks[2]

  if (file.indexOf('cloudsim-grant') != -1) {
    locals.push(line)
    continue
  }
  if (file.indexOf('/.hg/cache/') != -1) {
    ignored.push(line)
    continue
  }

  if (file.indexOf('.js.orig') != -1) {
    ignored.push(line)
    continue
  }
  if (file.indexOf('coverage_server') != -1) {
    ignored.push(line)
    continue
  }

  if (file.indexOf('coverage/lcov-report') != -1) {
    ignored.push(line)
    continue
  }

  if (file.indexOf('grantgrep.js') != -1) {
    ignored.push(line)
    continue
  }

  const gtoks = splitGrant(grant)
  if (gtoks.length ==0){
    ignored.push(line)
    continue
  }
  for (let i in gtoks) {
    const g = gtoks[i]
    if (g.indexOf('//') == 0) {
      ignored.push(line)
      continue
    }
    if(!modules[file]){
      modules[file] = {}
    }
    if(!modules[file][g]){
      modules[file][g] = 0
    }
    let count = modules[file][g]
    if(typeof(count) == 'undefined')
      console.log('count',file,g ,count)
    modules[file][g] += 1

    if (!calls[g])
      calls[g] = []
    let s =''

    s += '\x1b[36m' +  grant + '\x1b[0m'
    s += '\n'
    s += 'vi ' + file +' +' + nb

    calls[g].push(s)
  }
}
console.log('grep -rn csgrant\. .')
console.log('\nignored')
console.log(ignored)
console.log('=====')
console.log('\nlocals')
console.log(locals)
console.log('=====')
//console.log(modules)
//console.log(calls)

const sortedCalls = Object.keys(calls).sort()

for (let c in sortedCalls) {
  const call = sortedCalls[c]
  console.log()
  const lines = calls[call].sort()
  console.log()
  console.log(call, '(' + lines.length + ' calls )')
  console.log('==============================')
  for (let i in lines) {
    const line = lines[i]
    console.log( i+')',line)
    console.log()
  }
}

console.log()
// compact
for (let c in sortedCalls) {
  const call = sortedCalls[c]
  const lines = calls[call].sort()
  const repos = extractRepos(lines)
  console.log(call, '(' + lines.length + ' calls )')
//  console.log(repos)
}

const tests = [
  '                   csgrant.grantPermission(req.user, resourceData.golduser, r.id, true,',
  "app.delete('/permissions',csgrant.authenticate, csgrant.revoke)",
  "console.log('grep -rn csgrant\. .')"

]
if (false) {
  var l = tests[2]
  var r = splitGrant(l, console.log)
  console.log('RESULT', r)
}
