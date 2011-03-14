class Notifier < ActionMailer::Base
  def signup(user, password)
    @subject = 'OneVote: Registration Successul'
    @from  = 'OneVote <onevote@onevote>'
    @recipients = user.email
    
    @body[:email] = user.email
    @body[:password] = password
  end
  
  def election_warning(user, election)
    @subject = 'OneVote: New election available'
    @from  = 'OneVote <onevote@onevote>'
    @recipients = user.email
    
    @body[:email] = user.email
    @body[:title] = election.title
    @body[:begin] = election.start_date.to_s
    @body[:end] = election.end_date.to_s
  end
  
  def election_end(user, name)
    @subject = 'OneVote: End of election'
    @from  = 'OneVote <onevote@onevote>'
    @recipients = user.email
    
    @body[:email] = user.email
    @body[:name] = name
  end
  
  def election_vote(user, vote)
    @subject = 'OneVote: Vote successfuly cast'
    @from  = 'OneVote <onevote@onevote>'
    @recipients = user.email
    
    @body[:email] = user.email
    @body[:vote] = vote
  end
  
  def reset_password(email, password)
    @subject = 'OneVote: New password request'
    @from  = 'OneVote <onevote@onevote>'
    @recipients = email
    
    @body[:email] = email
    @body[:password] = password
  end
end
