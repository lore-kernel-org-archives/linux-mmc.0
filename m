From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Tue, 22 Nov 2016 10:16:09 +0100
Message-ID: <2495798.NCupJYMGV1@wuerfel>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org> <17679227.zg8zl3jhbr@wuerfel> <CACRpkdagS-7kaYCd2Sq0vLR8+19Mmckx=CuCqPv+HheRk8Cm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdagS-7kaYCd2Sq0vLR8+19Mmckx=CuCqPv+HheRk8Cm7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Binoy Jayan <binoy.jayan@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday, November 22, 2016 9:54:18 AM CET Linus Walleij wrote:
> On Wed, Nov 16, 2016 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday, November 16, 2016 4:20:47 PM CET Linus Walleij wrote:
> >> On Wed, Nov 16, 2016 at 1:46 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> > Well, we had a session at the KS regarding usage of the freezer on
> >> > kernel threads and the conclusion was to get rid of that (as opposed
> >> > to freezing user space, which is necessary IMO).  So this change would
> >> > go in the opposite direction.
> >>
> >> Aha so I should not make this thread look like everyone else, instead
> >> everyone else should look like this thread, haha
> >>
> >> Ah well, I'll just drop it.
> >
> > It would still be good to remove the semaphore and do something else,
> > as we also want to remove all semaphores. 
> >
> > We could check "mq->flags & MMC_QUEUE_SUSPENDED" in the kthread to see
> > if the queue is currently suspended, and otherwise go to sleep there,
> > and then call wake_up() in the resume function.
> 
> Hm... so simply:
> 
> if (mq->flags & MMC_QUEUE_SUSPENDED)
>   schedule();
> 
> ?

Something like that.

> This whole kthread business is pretty messy. I would prefer if I could
> just convert it to a workqueue. Just that it's not very simple the way
> it speculates around in the request queue from the block layer.

I don't see how that would work, but might be worth trying.
After doing that, a simple flush_workqueue() might be enough
to take care of the suspend operation.

> > While looking at that code, I just noticed that access to
> > mq->flags is racy and should be fixed as well.
> 
> I guess we should take the queue lock &q->lock around accessing
> the flags.

Yes, either that, or use set_bit/test_bit/test_and_set_bit for
atomic access. For instance, this one

        if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
                mq->flags &= ~MMC_QUEUE_NEW_REQUEST;

Could be

	if (test_and_clear(MMC_QUEUE_NEW_REQUEST_BIT, &mq->flags))
			...


	Arnd

