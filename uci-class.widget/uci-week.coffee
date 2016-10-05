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
    slack: "https://tableauautomation.slack.com/messages/@slackbot/"
    gdrive: "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwVkRVZlRvRkxFZWc"
    asana: "https://app.asana.com/0/190576529875988/list"
    instagantt: "https://instagantt.com/app/#"
    when2meet: "http://www.when2meet.com/?5645971-37uAg"
    tableau: "http://tableau.ics.uci.edu/"
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
iconMap:
  www: 'www.jpg'
  gdrive: 'gdrive.png'
  groupme: 'groupme.jpg'
  slack: 'slack.jpg'
  instagantt: 'instagantt.png'
  asana: 'asana.png'
  canvas: 'canvas.ico'
  tableau: 'tableau.jpg'
  when2meet: 'when2meet.jpg'
  discord: "discord.png"
img: (key) -> """
  <img class="img_icon" src="uci-class.widget/img/#{@iconMap[key]}" />
  """
resource: (c) -> (key) =>
  url = c[key]
  if (url)
    """<a href="#{url}">#{@img(key)}</a>"""
  else
    ""
renderIcons: (gen) ->
  out = ""
  for key,v of @iconMap
    out += gen(key)
  out
renderRows: ->
  out = ""
  for key of @courses
    c = @courses[key]
    r = @resource(c)
    out+="""
      <tr>
        <td>
          #{@renderIcons(r)}
        </td>
        <td>
          <a href="#{c.url}">#{c.name}</a>
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
          <a href="https://eee.uci.edu/myeee/">EEE</a> |
          </a>
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
  left: 0%
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
  .img_icon
    max-height: 28px;
"""
