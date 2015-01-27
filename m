From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 13:21:48 -0500
Message-ID: <20150127132148.365ef397@gandalf.local.home>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>
	<CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com>
	<54C77E69.7050600@ahsoftware.de>
	<20150127120855.GA9254@pd.tnic>
	<54C7816A.8050800@ahsoftware.de>
	<54C78524.3070901@nod.at>
	<54C7881F.6020501@ahsoftware.de>
	<20150127142120.GA3351@pd.tnic>
	<54C7C2EC.7010605@ahsoftware.de>
	<20150127172415.GC25043@home.goodmis.org>
	<54C7CD1C.1060601@ahsoftware.de>
	<20150127124817.608db508@gandalf.local.home>
	<54C7D549.3070705@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:35210 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759080AbbA0SVw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 13:21:52 -0500
In-Reply-To: <54C7D549.3070705@ahsoftware.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, 27 Jan 2015 19:13:29 +0100
Alexander Holler <holler@ahsoftware.de> wrote:

> > Basically, what you are saying is "printk is more convenient for me and
> > I do not care about the other cases that make much more sense with
> > sysfs". The kernel does not work that way.
> 
> No. First I don't know the name of one of the thousands file in sysfs, 
> just like I don't know all the possible kernel messages.

But as Richard mentioned, it should be documented in Documentation/ABI,
and the information you want should be right there. Once you know it,
you will know it for good.

> 
> And second I still believe that KISS is the right way and frameworks 
> aren't the right choice for everything.

But having tools parse dmesg is not KISS. It's backwards. /sys
filesystem is really simple to use. It's not that difficult. And it was
created for just this purpose!

> 
> But because I still don't refuse to learn, I will attach the output of
> 
> find /sys -type f -print -exec cat {} \;
> 
> to future bug reports instead of the output of dmesg.
> 

That is completely different. dmesg will contain back traces which are
not in /sys filesystem, nor do they belong there. dmesg also shows
order of events, which may be needed in debugging, again, sysfs is
about properties and states of devices. How would sysfs be used for
debugging?

You want to add a way to tell a property of a device. That is *exactly*
what sysfs was made for. Not dmesg.

-- Steve

