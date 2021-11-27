const assert = require('assert');
const algosdk = require('algosdk')
const util = require('util');
const child_process = require('child_process')
const exec = util.promisify(child_process.exec)
const spawn = child_process.spawn
const debug = require('debug')('algon:test')


describe('Connection to internal service', () => {

  let portForwardChildProcess

  before(async () => {
    await cmd('kubectl create namespace algon || true')
    await cmd('helm upgrade --install algon charts/algon --namespace algon')
    portForwardChildProcess = await cmd('kubectl port-forward service/algon 8080:8080', true)
    await sleep(20000000)
  }) 

  after(async () => {
    await cmd(`kill -9 ${childProcess.pid}`)
    await cmd('helm delete algon --namespace algon')
  })

  describe('with access token', () => {
    it('should connect', async () => {
      const token = 'Your algod API token'
      const server = 'http://localhost'
      const port = 8080
      const client = new algosdk.Algodv2(token, server, port)
      
      const res = await client.healthCheck().do()

      

    });
  });
});

// Shell command with stdout/stderr logging
async function cmd(cmdString, daemon=false) {
  let childProcess 
  if(daemon) {
    childProcess = await spawn(cmdString, {
      detached: true
    })
  } else {
    childProcess = await exec(cmdString)
  }
  debug(`${cmdString} : stderr`, childProcess.stderr)
  debug(`${cmdString} : stdout`, childProcess.stdout)
  return childProcess
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
