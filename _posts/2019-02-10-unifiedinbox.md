---
layout: post
title: Unified Inbox in Outlook
date: 2019-02-10T10:24:37.000Z
categories: code
synopsis: using a macro to create a unified inbox in Outlook
last-modified-date: '2021-06-12T16:39:49+01:00'

---

# Unified Inbox in Outlook O365

Whilst I happily use [Sylpheed](https://sylpheed.sraoss.jp/en/) and [K9](https://k9mail.github.io/) at home, at work I'm stuck using Outlook. In lots of ways, Outlook is excellent.  For one thing, the app hits the sweet-spot of task, diary and email management.  One glaring omission that I find with Outlook is the lack of a [unified inbox](https://smallbusiness.chron.com/unified-email-mean-36970.html).

Looking on the [forums](https://answers.microsoft.com/en-us/search/search?SearchTerm=unified+inbox&IsSuggestedTerm=false&tab=&isFilterExpanded=false&searchFormBtn=&CurrentScope.ForumName=&CurrentScope.Filter=&ContentTypeScope=#////1), this seems to be something that users want, but still hasn't appeared.  One of the suggested work-arounds that have come from users was to use a macro, so that's what I did.

The below script will filter all mail in all inboxes.  It's incredibly simple, but that works well for me, in my efforts to maintain a [zero inbox](https://www.fastcompany.com/40507663/the-7-step-guide-to-achieving-inbox-zero-and-staying-there-in-2018).

```vb
Sub UnifiedInbox()
Dim myOlApp As New Outlook.Application
txtSearch = "folder:Inbox"
myOlApp.ActiveExplorer.Search txtSearch, olSearchScopeAllFolders
Set myOlApp = Nothing
End Sub
```

Similarly, setting the macro up is a simple case of enabling the [developer tab](https://www.easytweaks.com/add-macros-outlook-2016/) and following the breadcrumbs until you get to the Macro editor:

![image of Macro editor](/images/unifiedInbox_2.png)

Once you've got the macro set up, and running, you can add a new button to the new [Quick Access Toolbar](https://support.microsoft.com/en-gb/office/customize-the-quick-access-toolbar-43fff1c9-ebc4-4963-bdbd-c2b6b0739e52?ui=en-us&rs=en-gb&ad=gb) The easiest way I found to do this was to right click on the ribbon, and select `Customise the Ribbon...`.  In the resulting screen, you can click the link to edit the QAT, and select the macro you want to use, and modify the icon used.

![dialogue box](/images/unifiedInbox_3.png)

The good thing about this approach is that you can run the macro using a simple button that is permanently visible.

![Visible in the quick access toolbar](/images/unifiedInbox_4.png)
