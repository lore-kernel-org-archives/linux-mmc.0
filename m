From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 13:42:46 -0500
Message-ID: <20150127134246.297aae46@gandalf.local.home>
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
	<20150127132148.365ef397@gandalf.local.home>
	<54C7DA10.3040209@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C7DA10.3040209@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Jan 2015 19:33:52 +0100
Alexander Holler <holler@ahsoftware.de> wrote:

> Am 27.01.2015 um 19:21 schrieb Steven Rostedt:
> 
> > You want to add a way to tell a property of a device. That is *exactly*
> > what sysfs was made for. Not dmesg.
> 
> Err, dmesg existed long before sysfs.

Yep, and dmesg shows you what is happening in the kernel. sysfs shows
you the state and properties of the kernel (or devices). That's what it
was created for, because dmesg wasn't the place to put it.

> 
> Anyway, it's ok. You're all right and I should request project 
> sponsoring for offering a simple piece of (imho) interesting information.

I'm sure if it's interesting enough, someone will eventually add it.

Hey, if you end up doing it, it could help with your resume.

> 
> Happy frameworking and sorry for disturbing.

No problem. Enjoy,

-- Steve
