# Helper methods defined here can be accessed in any controller or view in the application

Creeper.helpers do
  def gh_client
    return Octokit::Client.new({
      :auto_traversal => true,
      :login => session[:user],
      :oauth_token => session[:token],
    })
  end

  def get_repos
   begin
     return gh_client.repos
   rescue Octokit::Unauthorized
     logger.push("Caught Octokit::Unauthorized for #{session.inspect}", :info)
     return []
   end
  end
end
