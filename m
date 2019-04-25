From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
Date: Thu, 25 Apr 2019 14:24:56 -0700
Message-ID: <CAD=FV=UW6d2QHzxx-Vtr+WwC1dkpUfCjxCLnfaP5S2UQxRh1oQ@mail.gmail.com>
References: <20190410221237.160856-1-dianders@chromium.org> <CANBLGcwmNowj9GSmE3bbo1t1o6EF8q-RiJftfdOQnJB9_8aSKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANBLGcwmNowj9GSmE3bbo1t1o6EF8q-RiJftfdOQnJB9_8aSKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emil Renner Berthing <emil.renner.berthing-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ryan Case <ryandcase-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 24, 2019 at 1:19 AM Emil Renner Berthing
<emil.renner.berthing-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Douglas,
>
> Unfortunately this seems to beak resume on my rk3399-gru-kevin. I have
> a semi-complicated setup with my rootfs as a btrfs on dmcrypt on
> mmcblk0 which is the dw_mmc, so I'm guessing something goes wrong when
> waking up the dm_mmc which probably wasn't suspended before this
> patch. It's not 100% consistent though. Sometimes I see it resume the
> first time I try suspending, but then 2nd time I suspend it won't come
> back.

Thanks for testing!

Can you give me more details about your kernel version?  Any local
patches?  What config are you using?

I tried booting up my rk3388-gru-kevin on the Chrome OS 4.19 kernel (I
know, not quite fully upstream, but linuxnext just crashed upon boot
for me when I tried it).  I have this patch in place and I booted from
SD card.  I ran a Chrome OS tool which will test 20 cycles of
suspend/resume (uses the RTC to schedule a wakeup):

suspend_stress_test -c20 --suspend_min=15 --suspend_max=20

...and I didn't see failures.

...so I'm pretty baffled.  On rk3399-gru-kevin you should have no SDIO
devices unless you've managed to cram an SDIO card into your micro SD
slot.  Specifically WiFi is connected via PCIE.

As I wrote Shawn, I'm pretty sure my patch is a effectively a no-op in
these cases.  "client_sdio_enb" should always be 0 and thus runtime
suspend and resume should just be:

spin_lock_irqsave(&host->irq_lock, irqflags);
int_mask = mci_readl(host, INTMASK);
mci_writel(host, INTMASK, int_mask);
spin_unlock_irqrestore(&host->irq_lock, irqflags);

...other than changing the timing slightly that shouldn't do anything at all.


My first guess is that this patch is your (un)lucky shirt, as in
"every time I wear my lucky shirt I win at slots in Las Vegas".  Since
the problem you're seeing doesn't happen every time I'm going to guess
that you got lucky in that it seemed to go away when you reverted my
patch.


> Let me know if I can do something to help debug this.

Assuming the failure and this patch aren't just correlated by luck...

Logs would be a start.  If you don't have serial console then
hopefully you've got console-ramoops working?  Then if it's wedged you
can do the warmest reset you can (Alt-topRowVolUp-R) and hopefully the
ramoops will give you some logs.

Presumably you could also add some logs to double-check that all my
assertions are true.  That is:

1. host->client_sdio_enb should always be false in __dw_mci_enable_sdio_irq()

2. In __dw_mci_enable_sdio_irq() confirm that the int_mask we are
writing is the same as the one we're reading.  AKA the "if (enb) ...
else ..." makes no change to the value of int_mask.


Assuming my assertions are correct then pretty much everything is
_supposed_ to be a no-op on your system, so you can start gutting
things one at a time and see when the problem goes away:

a) Delete the call from suspend.  Does it fix it?

b) Delete the call from resume.  Does it fix it?

c) Delete parts of __dw_mci_enable_sdio_irq().  Get rid of the
mci_wirtel().  Does it fix it?  What about if you get rid of the read
and the write and just have the spinlock?

===

If I can help with real-time debugging let me know.  I'm in California
time zone and can be found as dianders in the #linux-rockchip channel
on freenode.



-Doug
