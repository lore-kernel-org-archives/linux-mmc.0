From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan - card removal detection regression
Date: Thu, 03 Mar 2011 21:28:51 -0500
Message-ID: <m3mxlbobz0.fsf@pullcord.laptop.org>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	<1290921690-6133-2-git-send-email-ohad@wizery.com>
	<20101217005123.GD17239@void.printf.net>
	<AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
	<1299205366.4999.3.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37071 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759195Ab1CDCan (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2011 21:30:43 -0500
In-Reply-To: <1299205366.4999.3.camel@maxim-laptop> (Maxim Levitsky's message
	of "Fri, 04 Mar 2011 04:22:46 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 03 2011, Maxim Levitsky wrote:
> This patch breaks the CONFIG_MMC_UNSAFE_RESUME, because it sets fake
> non-removeable flag, but the intended use of this option is to assume
> that card is not removed _during_ suspend,  and it can still be removed
> during normal use.
> With this commit, card removal isn't detected.

I guess we disagree about the semantics of CONFIG_MMC_UNSAFE_RESUME.
The Kconfig text says:

config MMC_UNSAFE_RESUME
        bool "Assume MMC/SD cards are non-removable (DANGEROUS)"

which I interpret as meaning that you should set MMC_UNSAFE_RESUME
*if you're using a card that cannot be removed*.  If your card *can* be
removed, then it would be extremely foolish to turn on MMC_UNSAFE_RESUME,
because then if someone removed your removable card during suspend and
modified it in another machine before resuming, you'd get massive
filesystem corruption.

What am I missing?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
