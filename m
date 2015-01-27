From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 19:13:29 +0100
Message-ID: <54C7D549.3070705@ahsoftware.de>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>	<CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com>	<54C77E69.7050600@ahsoftware.de>	<20150127120855.GA9254@pd.tnic>	<54C7816A.8050800@ahsoftware.de>	<54C78524.3070901@nod.at>	<54C7881F.6020501@ahsoftware.de>	<20150127142120.GA3351@pd.tnic>	<54C7C2EC.7010605@ahsoftware.de>	<20150127172415.GC25043@home.goodmis.org>	<54C7CD1C.1060601@ahsoftware.de> <20150127124817.608db508@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:41555 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbbA0SNi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 13:13:38 -0500
In-Reply-To: <20150127124817.608db508@gandalf.local.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Am 27.01.2015 um 18:48 schrieb Steven Rostedt:
> On Tue, 27 Jan 2015 18:38:36 +0100
> Alexander Holler <holler@ahsoftware.de> wrote:
>
>> Anyway, I like(d) Linux because it didn't had a splash screen and used
>> to spit out all types of information on the screen where it could be
>> easily seen or found (in contrast other OS which try to hide all
>> technical details from users).
>
> Yes, I like those days too, but as you say, times are changing, and we
> must adapt.
>
>>
>> Of course, times are changing, including the amount of stuff printed on
>> screen. But I still find it much much easier to grep on the output of
>> dmesg than to search through thousands files in sysfs. Even if that can
>> be done with grep too (kind of). But it's much more complicated because
>> grep doesn't connect the file name with the content, so you need more
>> complicated stuff to combine both in order to search for and find
>> something in sysfs.
>
> Come on, it's not that more complex. If you know the name of the file,
> just do:
>
> find /sys -print -name <name> -exec cat {} \;
>
> And you'll get the data you want.
>
> Basically, what you are saying is "printk is more convenient for me and
> I do not care about the other cases that make much more sense with
> sysfs". The kernel does not work that way.

No. First I don't know the name of one of the thousands file in sysfs, 
just like I don't know all the possible kernel messages.

And second I still believe that KISS is the right way and frameworks 
aren't the right choice for everything.

But because I still don't refuse to learn, I will attach the output of

find /sys -type f -print -exec cat {} \;

to future bug reports instead of the output of dmesg.

Alexander Holler

