const path = require('path')
const { program } = require('commander')
program
  .version('0.1.0')
  .argument('<json>', 'The JSON file to upload to firebase')
  .action((json) => {
    const entries = Object.entries(require(path.join(process.cwd(), json)))
    const half = Math.ceil(entries.length / 2)
    const part1 = Object.fromEntries(entries.slice(0, half))
    const part2 = Object.fromEntries(entries.slice(-half))
    console.log(JSON.stringify(part1, null, 2))
    console.error(JSON.stringify(part2, null, 2))
  })

program.parse()
