crypto = require "crypto"

Shred = require("shred")

hmacSha1 = (key,string) ->
  crypto.createHmac('sha1', key).update(string).digest('base64')

md5 = (string) ->
  crypto.createHash("md5").update(string).digest("base64")

class S3
  constructor: (options) ->
    {@bucket,@awsAccessKey,@awsSecretAccessKey} = options
    @http = new Shred()
    
  get: (path,headers,events) ->
    options = 
      verb: "GET"
      path: path
      date: (new Date).toUTCString()
      amazonHeaders: headers
    @http.get
      url: @url(path)
      headers:
        "date": options.date
        authorization: @authorization(options)
      on:
        success: (response) -> events.success(response)
        error: (response) -> events.error(response)
        request_error: (error) -> events.request_error(error)
    
  
  put: (path, content, headers, events) ->
    content.md5 = md5(content.body)
    options = 
      verb: "PUT"
      path: path
      content: content
      date: (new Date).toUTCString()
      amazonHeaders: headers
    @http.put
      url: @url(path)
      content: content.body
      headers:
        "content-type": content.type
        "content-md5": content.md5
        "date": options.date
        authorization: @authorization(options)
      on:
        success: (response) -> events.success(response)
        error: (response) -> events.error(response)
        request_error: (error) -> events.request_error(error)
  
  delete: (path,headers,events) ->
    options = 
      verb: "DELETE"
      path: path
      date: (new Date).toUTCString()
      amazonHeaders: headers
    @http.delete
      url: @url(path)
      headers:
        "date": options.date
        authorization: @authorization(options)
      on:
        success: (response) -> events.success(response)
        error: (response) -> events.error(response)
        request_error: (error) -> events.request_error(error)
    
  url: (path) -> "http://#{@bucket}.s3.amazonaws.com#{path}"
  
  authorization: (options)-> "AWS #{@awsAccessKey}:#{@signature(options)}"
  
  signature: (options) ->
    hmacSha1(@awsSecretAccessKey,@stringToSign(options))
    
  stringToSign: (options) ->
    "#{options.verb}\n#{options.content?.md5||""}\n#{options.content?.type||""}\n#{options.date}\n"+
      "#{@canonicalizeAmazonHeaders(options.amazonHeaders)}#{@canonicalizeResource(options.path)}"

  canonicalizeAmazonHeaders: (headers) -> ""

  canonicalizeResource: (path) -> "/#{@bucket}#{path}"
  
module.exports = S3