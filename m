From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on
 rescan - card removal detection regression
Date: Fri, 04 Mar 2011 04:52:57 +0200
Message-ID: <1299207177.4999.10.camel@maxim-laptop>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	 <1290921690-6133-2-git-send-email-ohad@wizery.com>
	 <20101217005123.GD17239@void.printf.net>
	 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
	 <1299205366.4999.3.camel@maxim-laptop> <m3mxlbobz0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41421 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758213Ab1CDCxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 21:53:04 -0500
Received: by ewy6 with SMTP id 6so569124ewy.19
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2011 18:53:02 -0800 (PST)
In-Reply-To: <m3mxlbobz0.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org

On Thu, 2011-03-03 at 21:28 -0500, Chris Ball wrote:
> Hi,
> 
> On Thu, Mar 03 2011, Maxim Levitsky wrote:
> > This patch breaks the CONFIG_MMC_UNSAFE_RESUME, because it sets fake
> > non-removeable flag, but the intended use of this option is to assume
> > that card is not removed _during_ suspend,  and it can still be removed
> > during normal use.
> > With this commit, card removal isn't detected.
> 
> I guess we disagree about the semantics of CONFIG_MMC_UNSAFE_RESUME.
> The Kconfig text says:
> 
> config MMC_UNSAFE_RESUME
>         bool "Assume MMC/SD cards are non-removable (DANGEROUS)"
> 
> which I interpret as meaning that you should set MMC_UNSAFE_RESUME
> *if you're using a card that cannot be removed*.  If your card *can* be
> removed, then it would be extremely foolish to turn on MMC_UNSAFE_RESUME,
> because then if someone removed your removable card during suspend and
> modified it in another machine before resuming, you'd get massive
> filesystem corruption.
That is assuming that someone kindly inserted the card back, while
system still was suspended, which is really unlikely, and besides, I
know who uses my computer (me mostly) and I know what I am doing.


The description also says:

"If you say Y here, the MMC layer will assume that all cards
stayed in their respective slots during the suspend. The
normal behaviour is to remove them at suspend and
redetecting them at resume. Breaking this assumption will
in most cases result in data corruption."


I own my computer, and I don't need the OS to take the decisions for me.

I don't want to have FS corruption if I accidentally suspend the system
with the card in the slot which could happen if that option is disabled.


Best regards,
	Maxim Levitsky



