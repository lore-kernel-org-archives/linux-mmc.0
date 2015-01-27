From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 19:04:13 +0100
Message-ID: <54C7D31D.6090109@ahsoftware.de>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de> <CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com> <54C77E69.7050600@ahsoftware.de> <20150127120855.GA9254@pd.tnic> <54C7816A.8050800@ahsoftware.de> <54C78524.3070901@nod.at> <54C7881F.6020501@ahsoftware.de> <20150127142120.GA3351@pd.tnic> <54C7C2EC.7010605@ahsoftware.de> <20150127172415.GC25043@home.goodmis.org> <54C7CD1C.1060601@ahsoftware.de> <54C7D08E.8030309@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C7D08E.8030309@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Am 27.01.2015 um 18:53 schrieb Arend van Spriel:

> Ever used rgrep or grep -R. Anyway, if this is you use-case what about
> the gazillion other pieces of info in the kernel. When moving in that
> direction you can be sure dmesg will flush out.

Sorry, never heard about that -R and wasn't aware that the kernel does a 
lot of things. ;)

I don't want that ftrace stuff appears in dmesg, but I like to do

dmesg | grep -i mmc (or whatever is of interest)

instead of

grep -Rsi mmc /sys/<a hundred tabs to search a matching direcory> or 
something like

find /sys -iname '*mmc*' -exec <more silly complications> \;

Alexander Holler
