From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 21 Apr 2016 15:19:31 +0200
Message-ID: <4611130.vJzBsRp8Hx@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <4647014.anjrLICQKc@wuerfel> <CAPDyKFpM4P8LrAnVB5kRxWrgEfPS7iTtF=YBeKuyvSM=O-KF8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64510 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcDUNUD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 09:20:03 -0400
In-Reply-To: <CAPDyKFpM4P8LrAnVB5kRxWrgEfPS7iTtF=YBeKuyvSM=O-KF8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Matt Redfearn <matt.redfearn@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On Thursday 21 April 2016 14:44:08 Ulf Hansson wrote:
> [...]
> 
> >> So the question I have is *why* do you have to be in IRQ context when
> >> using the semaphore...
> >>
> >> I would rather see that you use a threaded IRQ handler, perhaps in
> >> conjunction with a hard IRQ handler if that is needed.
> >
> > That does not solve the problem though: it is not allowed for a mutex
> > to be taken in the request function but released in the interrupt,
> > both have to be in the same thread.
> >
> > Using a threaded IRQ handler would help by avoiding the spinlock
> > inside of it (it could be replaced with a mutex there), but it
> > doesn't solve the problem of serializing between the slots.
> 
> My point is, the may not need to be released in the IRQ handler, but
> instead in the threaded IRQ handler.

That doesn't change anything.

> >> Although to clarify a bit more, the mmc core invokes *all* mmc host
> >> ops callbacks from non-atomic context.
> >
> > Oh, so you mean the .request() function must not sleep and cannot
> > call mutex_lock() or down() or wait_event()?
> 
> No.
> 
> *non-atomic* context. :-)
> 
> I should probably said thread/process context instead.
> 

My mistake, you were being clear enough here, I just misread.

> >> In the ->request() callback:
> >> ....
> >> mutex_lock()

> >> In the threaded IRQ handler:
> >> ...
> >> mutex_unlock()
> >>
> >> Do you think something along these lines should work for your case?
> >
> > This is the case I described above, it is against the rules for mutexes()
> > and you will get a lockdep warning if you attempt this.
> 
> No.
> 
> Considering my comments in this reply, can you please re-think and see
> if my solution could make sense?

The problem is not that mutex_unlock() has to be called from non-atomic
context (it doesn't, you are allowed  to call mutex_unlock while holding
a spinlock), but instead the problem is that it has to be done from the
same thread that called mutex_lock(), and the threaded IRQ handler
is never the same thread that is currently holding the mutex.

My suggestion with using

	wait_event(host->wq, !cmpxchg(host->current_req, NULL, mrq));

should sufficiently solve the problem, but the suggestion of using
a kthread (even though not needed for taking a mutex) would still
have some advantages and one disadvantage:

+ We never need to spin in the irq context (also achievable using
  a threaded handler)
+ The request callback always returns immediately after queuing up
  the request to the kthread, rather than blocking for a potentially
  long time while waiting for an operation in another slot to complete
+ it very easily avoids the problem of serialization between
  the slots, and ensures that each slot gets an equal chance to
  send the next request.
- you get a slightly higher latency for waking up the kthread in
  oder to do a simple request (comparable amount of latency that
  is introduced by an irq thread).

	Arnd
