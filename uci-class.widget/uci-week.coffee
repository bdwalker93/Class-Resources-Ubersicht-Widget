courses: [
    name: "INF 115: SW Q&A"
    www: "http://www.ics.uci.edu/~jajones/Informatics115-Fall2016.html"
  ,
    name: "INF 161: Social Analysis of Computerization"
    www: "https://eee.uci.edu/16f/37090"
  ,
    name: "INF 191: Project Course"
    www: "https://canvas.eee.uci.edu/courses/2966"
    groupme: "https://web.groupme.com/chats"
]
command: "echo $(date +'%V')"
refreshFrequency: 86400 * 1000 # 24 hours
weekSliceMap:
  spring: 12
  fall: 38
session: (wk, numWeeks) -> (name) =>
  sliceAt = @weekSliceMap[name]
  weekNo = parseInt(wk) - sliceAt
  if weekNo <= numWeeks && weekNo >= 0
    "UCI Week #{weekNo} of 10"
weekString: (wk) ->
  q = @session(wk, 10)
  q('spring') || q('fall') || ''
slack: (url) ->
  return "" if (!url)
  """
  <a href="#{url}">
    <img class="link_icon" src="uci-class.widget/icon_images/slack.jpg" alt="Slack image missing"/>
  </a>
  """
groupme: (url) ->
  return "" if (!url)
  """
  <a href="#{url}">
    <img class="link_icon" src="uci-class.widget/icon_images/groupme.jpg" alt="Groupme image missing"/>
  </a>
  """
gdrive: (url) ->
  return "" if (!url)
  """
  <a href="#{url}">
    <img class="link_icon" src="uci-class.widget/icon_images/gdrive.png" alt="GDrive image missing"/>
  </a>
  """
www: (url) ->
  return "" if (!url)
  """
  <a href="#{url}">
    <img class="link_icon" src="uci-class.widget/icon_images/www.jpg" alt="WWW image missing"/>
  </a>
  """
class: (name, url) ->
  return "#{name}" if (!url)
  """
  <a href="#{url}">
    #{name}
  </a>
  """
renderRows: ->
  out = ""
  for key of @courses
    c = @courses[key]
    out+="""
      <tr>
        <td>
          #{@www(c.www)}
          #{@gdrive(c.gdrive)}
          #{@slack(c.slack)}
          #{@groupme(c.groupme)}
        </td>
        <td>
          #{@class(c.name, c.url)}
        </td>
      </tr>
    """
  out
render: (wk) -> """
  <h1>Week #{wk} of 52</h1>
  <h2>#{@weekString(wk)}</h2>
  <table>
    <tbody>
      <tr>
        <td class="eee" colspan=2>
          <a href="https://www.reg.uci.edu/calendars/quarterly/2016-2017/quarterly16-17.html">Calendar</a> |
          <a href="https://eee.uci.edu/myeee/">EEE</a>
        </td>
      </tr>
      #{@renderRows()}
    </tbody>
  </table>
  """
style: """
  background: white no-repeat 50% 20px
  box-sizing: border-box
  color: #141f33
  font-family: Helvetica Neue
  font-weight: 300
  left: 10%
  line-height: 1.5
  padding: 20px
  top: 10%

  a
    text-decoration: none

  h1
    font-size: 20px
    font-weight: 300
    margin: 16px 0 8px

  h2
    font-size: 16px
    font-weight: 200
    margin: 16px 0 8px

  .eee
    border-bottom: 1px solid #ccc

  .link_icon
    max-height: 30px;
"""
