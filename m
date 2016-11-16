From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Wed, 16 Nov 2016 13:57:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611161351520.29400@cbobk.fhfr.pm>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org> <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, 16 Nov 2016, Rafael J. Wysocki wrote:

> > The MMC/SD block core request processing thread is taking a
> > semaphore in the request processing section and the same
> > semaphore is taken around suspend/resume operations.
> >
> > The purpose of the semaphore is to block any request from being
> > issued to the MMC/SD host controllers when the system is
> > suspended. A semaphore is used in place of a mutex since the
> > calls are coming from different threads.
> >
> > This construction predates the kernel thread freezer mechanism:
> > we can easily replace the semaphore by instead activating the
> > freezer with set_freezable() and call try_to_freeze() instead
> > of the up(); schedule(); down(); construction that is devised
> > to let the suspend/resume calls get in and grab the semaphore.
> >
> > Tested with a few suspend/resume to memory cycles on the Ux500
> > when doing intense dd operations in the background: the
> > thread thaws and resumes operation after resume.
> 
> Well, we had a session at the KS regarding usage of the freezer on
> kernel threads and the conclusion was to get rid of that (as opposed
> to freezing user space, which is necessary IMO).  So this change would
> go in the opposite direction. :-)

[ thanks for CCing me, Rafael ]

Agreed. You already have PM callbacks handled properly, so the way this 
should be done is once you're in the PM-callback due to system going 
through power management change, you just stop generation of any new I/O, 
and tell the kthread that it should schedule itself out.

Plus the schedule() has to stay there anyway, as try_to_freeze() is not 
going to provide you with the schedule() semantics unless the system is 
actually undergoing a PM transition towards suspend.

So either semaphore, or some kind of atomic flag, is exactly the 
information that should be passed from the PM callback to the kthread.

(now, I agree, that this is one of the very rare cases where the kthread 
freezer is actually being used properly -- IOW to pause a kthread that is 
actually generating new I/O ... but given the fact that this is so rare, 
and the API is so heavily abused, I really tend to heavily prefer a 
semaphore / flag based aproach).

Thanks,

-- 
Jiri Kosina
SUSE Labs

