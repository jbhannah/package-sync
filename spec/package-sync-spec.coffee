os = require 'os'

PackageSync = require '../lib/package-sync'

h = require './helpers'

describe 'PackageSync', ->
  beforeEach ->
    @sync = new PackageSync()

  afterEach ->
    h.deletePackages()

  describe 'getMissingPackages', ->
    it 'gets a list of missing packages', ->
      h.createPackages({'packages': ['foo', 'bar', 'baz']})
      spyOn(atom, 'getConfigDirPath').andReturn(os.tmpdir())

      expect(@sync.getMissingPackages()).toEqual(['foo', 'bar', 'baz'])

    it 'gets a list of missing packages, excluding ones that are not missing', ->
      h.createPackages({'packages': ['foo', 'bar', 'baz']})
      spyOn(atom, 'getConfigDirPath').andReturn(os.tmpdir())
      spyOn(atom.packages, 'getAvailablePackageNames').andReturn(['foo'])

      expect(@sync.getMissingPackages(false)).toEqual(['bar', 'baz'])

    it 'gets a list of installed packages, excluding ones that are in the list', ->
      h.createPackages({'packages': ['foo', 'bar']})
      spyOn(atom, 'getConfigDirPath').andReturn(os.tmpdir())
      spyOn(atom.packages, 'getAvailablePackageNames').andReturn(['foo', 'bar', 'baz'])

      expect(@sync.getMissingPackages(true)).toEqual(['baz'])
