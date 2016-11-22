From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Tue, 22 Nov 2016 09:10:23 +0000
Message-ID: <20161122091023.GS1041@n2100.armlinux.org.uk>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
 <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
 <CACRpkdY+jdU4ETuMJsY-efSkjwE0fWWRZoyCyrYAs_GxUo-DhQ@mail.gmail.com>
 <17679227.zg8zl3jhbr@wuerfel>
 <CACRpkdagS-7kaYCd2Sq0vLR8+19Mmckx=CuCqPv+HheRk8Cm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdagS-7kaYCd2Sq0vLR8+19Mmckx=CuCqPv+HheRk8Cm7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Binoy Jayan <binoy.jayan@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 22, 2016 at 09:54:18AM +0100, Linus Walleij wrote:
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
> > as we also want to remove all semaphores. ;-)
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

No, the schedule() is required when there are no more requests to
process, so the thread doesn't spin waiting for the next request to
appear.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
