From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lockdep dump on devtree_lock (involving esdhc)
Date: Tue, 3 Jun 2014 17:00:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1406031638330.3319@nanos>
References: <20130611233330.GA15342@home.buserror.net> <alpine.LFD.2.02.1306120948430.22970@ionos> <CACxGe6ufSLJUnsM9emkDUeGHojmb37JeY8_OFMnSdrB_oMeScg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55779 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbaFCPBB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 11:01:01 -0400
In-Reply-To: <CACxGe6ufSLJUnsM9emkDUeGHojmb37JeY8_OFMnSdrB_oMeScg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 3 Jun 2014, Grant Likely wrote:
> On Wed, Jun 12, 2013 at 8:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 11 Jun 2013, Scott Wood wrote:
> >
> >> I get the following lockdump output on p2020rdb using
> >> v3.10-rc5-43-g34376a5.  While it's not particularly polite for the
> >> esdhc driver to be calling OF functions while holding another lock which
> >> can be acquired from interrupt context, why is devtree_lock usually
> >> acquired in an irqsafe manner but sometimes not?
> >>
> >> Both types of usage were added by the same commit:
> >>
> >> commit d6d3c4e656513dcea61ce900f0ecb9ca820ee7cd
> >> Author: Thomas Gleixner <tglx@linutronix.de>
> >> Date:   Wed Feb 6 15:30:56 2013 -0500
> >>
> >>     OF: convert devtree lock from rw_lock to raw spinlock
> >>
> >> Stephen, you asked about this here:
> >> http://lkml.indiana.edu/hypermail/linux/kernel/1302.1/01383.html
> >>
> >> Did you ever get an answer?
> >
> > https://patchwork.kernel.org/patch/2470731/
> >
> >> I'm also curious why devtree_lock was made raw to begin with...
> >> Iterating over a device tree doesn't seem like something you'd want to
> >> trust to be low-latency.
> >
> > The reason is that it's taken in low level cpu bringup code and I did
> > not find a different solution. :(
> 
> Hey, Thomas,
> 
> Do you remember where the offending code is? I'm looking at completely
> refactoring FDT locking so I'd like to take a crack and solving the
> cpu bringup problem.

Hmm, can't remember. All I found is where it got introduced:

     https://lkml.org/lkml/2007/11/9/114

without comments of course :)

Ask someone with a pseries to grab RT and make the lock non
raw. Enable debugging (mightsleep, lockdep ...)

Boot with maxcpus=1 and then online cores from user space. Splat
should come right away. I remember that I saw some of them in a
pastebin.

Thanks,

	tglx

