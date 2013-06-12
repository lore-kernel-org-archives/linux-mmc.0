From: Scott Wood <scottwood@freescale.com>
Subject: Re: lockdep dump on devtree_lock (involving esdhc)
Date: Wed, 12 Jun 2013 11:56:34 -0500
Message-ID: <1371056194.18413.34@snotra>
References: <20130611233330.GA15342@home.buserror.net>
	<51B89723.7090808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:25655
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754494Ab3FLQ4p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Jun 2013 12:56:45 -0400
In-Reply-To: <51B89723.7090808@wwwdotorg.org> (from swarren@wwwdotorg.org on
	Wed Jun 12 10:43:31 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree-discuss@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-mmc@vger.kernel.org

On 06/12/2013 10:43:31 AM, Stephen Warren wrote:
> On 06/11/2013 05:33 PM, Scott Wood wrote:
> > I get the following lockdump output on p2020rdb using
> > v3.10-rc5-43-g34376a5.  While it's not particularly polite for the
> > esdhc driver to be calling OF functions while holding another lock  
> which
> > can be acquired from interrupt context, why is devtree_lock usually
> > acquired in an irqsafe manner but sometimes not?
> >
> > Both types of usage were added by the same commit:
> >
> > commit d6d3c4e656513dcea61ce900f0ecb9ca820ee7cd
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Wed Feb 6 15:30:56 2013 -0500
> >
> >     OF: convert devtree lock from rw_lock to raw spinlock
> >
> > Stephen, you asked about this here:
> > http://lkml.indiana.edu/hypermail/linux/kernel/1302.1/01383.html
> >
> > Did you ever get an answer?
> 
> I believe that was fixed by c31a0c0 "of: fix recursive locking in
> of_get_next_available_child()".

That may have fixed the hang that prompted that thread, but it didn't  
answer the question you raised about mixing irqsafe and non-irqsafe  
devtree_lock uses.

-Scott
