From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: lockdep dump on devtree_lock (involving esdhc)
Date: Wed, 12 Jun 2013 09:43:31 -0600
Message-ID: <51B89723.7090808@wwwdotorg.org>
References: <20130611233330.GA15342@home.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43584 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab3FLPne (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 11:43:34 -0400
In-Reply-To: <20130611233330.GA15342@home.buserror.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-mmc@vger.kernel.org

On 06/11/2013 05:33 PM, Scott Wood wrote:
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

I believe that was fixed by c31a0c0 "of: fix recursive locking in
of_get_next_available_child()".
