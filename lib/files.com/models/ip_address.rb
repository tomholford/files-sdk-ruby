# frozen_string_literal: true

module Files
  class IpAddress
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Unique label for list; used by Zapier and other integrations.
    def id
      @attributes[:id]
    end

    # string - The object that this public IP address list is associated with.
    def associated_with
      @attributes[:associated_with]
    end

    # int64 - Group ID
    def group_id
      @attributes[:group_id]
    end

    # array - A list of IP addresses.
    def ip_addresses
      @attributes[:ip_addresses]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/ip_addresses", :get, params, options)
      response.data.map { |object| IpAddress.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
