_ = require 'lodash'
RejectYourAs = require '../'

describe 'RejectYourAs', ->
  beforeEach ->
    @sut = new RejectYourAs {}

  describe '->do', ->
    context 'when no as', ->
      beforeEach (done) ->
        request =
          metadata:
            auth:
              uuid: 'a-uuid'
              token: 'a-token'
            responseId: 'its-electric'
          rawData: '{}'

        @sut.do request, (error, @response) => done error

      it 'should return a 204', ->
        expectedResponse =
          metadata:
            responseId: 'its-electric'
            code: 204
            status: 'No Content'

        expect(@response).to.deep.equal expectedResponse

    context 'when as', ->
      beforeEach (done) ->
        request =
          metadata:
            auth:
              uuid: 'a-uuid'
              token: 'a-token'
              as: 'someone-else'
            responseId: 'its-electric'
          rawData: '{}'

        @sut.do request, (error, @response) => done error

      it 'should return a 403', ->
        expectedResponse =
          metadata:
            responseId: 'its-electric'
            code: 403
            status: 'Forbidden'

        expect(@response).to.deep.equal expectedResponse
