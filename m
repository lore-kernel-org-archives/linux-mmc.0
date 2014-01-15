From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
Date: Wed, 15 Jan 2014 16:44:03 +0800
Message-ID: <CAA+hA=TdWSFX7phF-HdL6aYreuTBQdmhvP1f1W_CoT0j5G1rag@mail.gmail.com>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
	<CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
	<20140113120435.GQ31570@twins.programming.kicks-ass.net>
	<CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
	<20140115084653.4f6aece8@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:48767 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaAOIoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 03:44:04 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so684365qcq.22
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 00:44:03 -0800 (PST)
In-Reply-To: <20140115084653.4f6aece8@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 15, 2014 at 3:46 PM, Lothar Wa=DFmann <LW@karo-electronics.=
de> wrote:
> Hi,
>
> Dong Aisheng wrote:
>> On Mon, Jan 13, 2014 at 8:04 PM, Peter Zijlstra <peterz@infradead.or=
g> wrote:
>> > On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
>> >> > It's strange that this issue did not happen on kernel 3.10.17 w=
ith the same
>> >> > code. And looking at the code, before call spin_lock we already=
 disable the mmc
>> >> > controller irq, per on my understanding, the deadlock given by =
lockdep may not
>> >> > be able to happen(pls fix me if wrong).
>> >> > May the lockdep not track the specific irq disable?
>> >> > Copy lockdep guy to comment.
>> >
>> > No, lockdep also doesn't know only that one line can take this loc=
k.
>> > Lockdep only knows a lock is taken from IRQ context, and disabling=
 one
>> > line still allows IRQs to happen and therefore it yells.
>>
>> Okay, thanks for the information.
>> If that, kernel 3.10.17 has the same code, do you know why it does n=
ot trigger
>> such lockdep error?
>>
> compiled with CONFIG_LOCKDEP disabled?
>

I did compile with LOCKDEP enabled.
See below for a part of my .config
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_LOCKDEP=3Dy
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=3Dy
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy

That's why i think it's strange.

Regards
Dong Aisheng

>
> Lothar Wa=DFmann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch=E4ftsf=FChrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info@karo-electronics.de
> ___________________________________________________________
