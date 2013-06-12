From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lockdep dump on devtree_lock (involving esdhc)
Date: Wed, 12 Jun 2013 09:49:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1306120948430.22970@ionos>
References: <20130611233330.GA15342@home.buserror.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41893 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3FLHtx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 03:49:53 -0400
In-Reply-To: <20130611233330.GA15342@home.buserror.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@wwwdotorg.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-mmc@vger.kernel.org

On Tue, 11 Jun 2013, Scott Wood wrote:

> I get the following lockdump output on p2020rdb using
> v3.10-rc5-43-g34376a5.  While it's not particularly polite for the
> esdhc driver to be calling OF functions while holding another lock which
> can be acquired from interrupt context, why is devtree_lock usually
> acquired in an irqsafe manner but sometimes not?
> 
> Both types of usage were added by the same commit:
> 
> commit d6d3c4e656513dcea61ce900f0ecb9ca820ee7cd
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Feb 6 15:30:56 2013 -0500
> 
>     OF: convert devtree lock from rw_lock to raw spinlock
> 
> Stephen, you asked about this here:
> http://lkml.indiana.edu/hypermail/linux/kernel/1302.1/01383.html
> 
> Did you ever get an answer?

https://patchwork.kernel.org/patch/2470731/
 
> I'm also curious why devtree_lock was made raw to begin with... 
> Iterating over a device tree doesn't seem like something you'd want to
> trust to be low-latency.

The reason is that it's taken in low level cpu bringup code and I did
not find a different solution. :(

Thanks,

	tglx
