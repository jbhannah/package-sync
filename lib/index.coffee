PackageSync = require './package-sync'
packageSync = new PackageSync()

module.exports =
  activate: ->
    packageSync.sync()

    atom.commands.add 'atom-workspace', 'package-sync:create-package-list', packageSync.createPackageList
    atom.commands.add 'atom-workspace', 'package-sync:open-package-list', packageSync.openPackageList
    atom.commands.add 'atom-workspace', 'package-sync:sync', packageSync.sync

    atom.packages.onDidLoadPackage packageSync.createPackageList
    atom.packages.onDidUnloadPackage packageSync.createPackageList

  config:
    forceOverwrite:
      title: 'Overwrite packages.cson'
      description: 'Overwrite packages.cson even when it is present.'
      type: 'boolean'
      default: false
