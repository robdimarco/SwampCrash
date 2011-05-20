class QuizStatusChangeMailer < ActionMailer::Base
  default :from =>[%w(swampcrash notifier).join("+"), %w(416software com).join(".")].join(64.chr)
  
  def crash_published(user, quiz)
    @user, @quiz = user, quiz
    raise "No Email found for user #{user.id}...no create notification sent" if user.email.blank?
    mail( :subject =>"New SwampCrash Released!...#{quiz.name}", :to=>user.email)    
  end
  def crash_completed(quiz)
  end
end
