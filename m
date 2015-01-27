From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 12:48:17 -0500
Message-ID: <20150127124817.608db508@gandalf.local.home>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C7CD1C.1060601@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Jan 2015 18:38:36 +0100
Alexander Holler <holler@ahsoftware.de> wrote:

> Anyway, I like(d) Linux because it didn't had a splash screen and used 
> to spit out all types of information on the screen where it could be 
> easily seen or found (in contrast other OS which try to hide all 
> technical details from users).

Yes, I like those days too, but as you say, times are changing, and we
must adapt.

> 
> Of course, times are changing, including the amount of stuff printed on 
> screen. But I still find it much much easier to grep on the output of 
> dmesg than to search through thousands files in sysfs. Even if that can 
> be done with grep too (kind of). But it's much more complicated because 
> grep doesn't connect the file name with the content, so you need more 
> complicated stuff to combine both in order to search for and find 
> something in sysfs.

Come on, it's not that more complex. If you know the name of the file,
just do:

find /sys -print -name <name> -exec cat {} \;

And you'll get the data you want.

Basically, what you are saying is "printk is more convenient for me and
I do not care about the other cases that make much more sense with
sysfs". The kernel does not work that way.

-- Steve
