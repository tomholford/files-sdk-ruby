# frozen_string_literal: true

module Files
  class Lock
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - Lock timeout
    def timeout
      @attributes[:timeout]
    end

    def timeout=(value)
      @attributes[:timeout] = value
    end

    # string - Lock depth (0 or infinity)
    def depth
      @attributes[:depth]
    end

    def depth=(value)
      @attributes[:depth] = value
    end

    # string - Owner of lock.  This can be any arbitrary string.
    def owner
      @attributes[:owner]
    end

    def owner=(value)
      @attributes[:owner] = value
    end

    # string - Lock scope(shared or exclusive)
    def scope
      @attributes[:scope]
    end

    def scope=(value)
      @attributes[:scope] = value
    end

    # string - Lock token.  Use to release lock.
    def token
      @attributes[:token]
    end

    def token=(value)
      @attributes[:token] = value
    end

    # string - Lock type
    def type
      @attributes[:type]
    end

    def type=(value)
      @attributes[:type] = value
    end

    # int64 - Lock creator user ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Lock creator username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # Create Lock
    #
    # Parameters:
    #   timeout - integer - Lock timeout length
    def create(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if params.dig(:timeout) and !params.dig(:timeout).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/locks/#{URI.encode_www_form_component(@attributes[:path])}", :post, params, @options)
    end

    # Parameters:
    #   token (required) - string - Lock token
    def delete(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params.dig(:token) and !params.dig(:token).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: token") unless params.dig(:token)

      Api.send_request("/locks/#{URI.encode_www_form_component(@attributes[:path])}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:path]
        raise NotImplementedError.new("The Lock object doesn't support updates.")
      else
        new_obj = Lock.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   path (required) - string - Path to operate on.
    #   include_children - boolean - Include locks from children objects?
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/locks/#{URI.encode_www_form_component(params[:path])}", :get, params, options)
      response.data.map { |object| Lock.new(object, options) }
    end

    # Create Lock
    #
    # Parameters:
    #   timeout - integer - Lock timeout length
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if params.dig(:timeout) and !params.dig(:timeout).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/locks/#{URI.encode_www_form_component(params[:path])}", :post, params, options)
      Lock.new(response.data, options)
    end

    # Parameters:
    #   token (required) - string - Lock token
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params.dig(:token) and !params.dig(:token).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: token") unless params.dig(:token)

      response, _options = Api.send_request("/locks/#{URI.encode_www_form_component(params[:path])}", :delete, params, options)
      response.data
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
    end
  end
end
