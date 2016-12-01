'use strict'

const exec = require('child_process').execSync

const lines = exec('grep -rn csgrant\. .').toString().split('\n')

const ignored = []
const locals = []
const modules = {}
const calls ={}

for (let i in lines) {
  const line = lines[i]
  if (line.indexOf('require') != -1 ) {
    ignored.push(line)
    continue
  }
  const toks = line.split(':')
  if (toks.length >=3 ) {
    const file = toks[0]
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

    if (file.indexOf('coverage/lcov-report') != -1) {
      ignored.push(line)
      continue
    }


    const nb = toks[1]
    const grant = toks[2]
    const grant1 = grant.substring(grant.indexOf('cloudsim-grant.'))
    const grant2 = grant1.replace('csgrant.','')
    const grant3 = grant2.split('(')[0]
    const grant4 = grant3.trim()
    const grant5 = grant4.replace(')', '')
    const grant6 = grant5.replace(',', '')
    const g = grant6
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
    console.log( line, '(' + i + ')\n')
  }
}

