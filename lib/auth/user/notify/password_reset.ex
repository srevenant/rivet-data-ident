defmodule Rivet.Data.Auth.User.Notify.PasswordReset do
  alias Rivet.Data.Auth
  use Rivet.Email.Template

  ##############################################################################
  # preload to send to all and not filter verified
  def send(%Auth.User{} = user, %Auth.UserEmail{} = email, %Auth.UserCode{} = code) do
    with {:ok, user} <- Auth.User.preload(user, :emails) do
      @sender.send(user.emails, __MODULE__, reqaddr: email.address, code: code)
    end
  end

  @impl Rivet.Email.Template
  def generate(%Auth.UserEmail{address: eaddr}, attr) do
    encoded = Regex.replace(~r/\s+/, eaddr, "+")

    {:ok, "#{attr.org} Password Reset",
     """
     <p/>
     We recently received a request to a password on an email associated with your account (#{attr.reqaddr}).
     If you initiated this request, you can reset your password with this one-time-use code by clicking
     the Reset Password link:
     <p/>
     <a href="#{attr.link_front}/#/pwreset?code=#{attr.code}&email=#{eaddr}">Reset Password</a>
     <p/>
     If you are unable to view or click the link in this message, copy the following URL and paste it in your browser:
     <p/><code>#{attr.link_front}/#/pwreset?code=#{attr.code}&email=#{encoded}</code>
     <p/>
     This reset code will expire in 1 hour.
     <p/>
     If you did not request this change, you can ignore this email and your password will not be changed.
     <p/>
     #{attr.email_sig}
     """}
  end
end
