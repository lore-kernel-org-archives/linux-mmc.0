From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 17:31:31 -0700
Message-ID: <5723FCE3.9070308@hurleysoftware.com>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
 <20160429224407.GF19428@n2100.arm.linux.org.uk>
 <CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
 <5723F514.4@hurleysoftware.com>
 <CAD=FV=V_YyfBOSs7BLkyhv=_5HBmf3djUWACbL6d-bwnrueDjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=V_YyfBOSs7BLkyhv=_5HBmf3djUWACbL6d-bwnrueDjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29Tb/PtFMR13I2A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 04/29/2016 05:03 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 29, 2016 at 4:58 PM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
> 
>     On 04/29/2016 04:01 PM, Doug Anderson wrote:
>     > * serial allows numbering devices by alias.
> 
>     Which is in fact a total nightmare.
> 
>     While stable device order is mandatory in serial because of
>     console command line parameters and existing userspace expectations,
>     it is the number one barrier to providing a shared ttyS namespace
>     for mixed uart platforms.
> 
>     Stable device order has a very real (and often unforeseen) maintenance
>     burden.
> 
> 
> Interesting. I wonder if these burdens are unique to serial or shared
> by all the other subsystems that allow ordering? Maybe this is all
> because of legacy reasons?

Well, the specific issue is certainly unique to serial.
But what I was suggesting is that 5 years from now, these patches
could be the "legacy reasons" in mmc.

FWIW, there is already a defacto expectation by boot configurations in the
field that a given mmc block device is stable across boots. The reality
is that 100000's of kernel command lines look like:

	root=/dev/mmcblk0p2

This was a recent regression fixed by Ulf in commit 9aaf3437aa72
("mmc: block: Use the mmc host device index as the mmcblk device index")


> Note that for MMC devices we wouldn't be asserting that _every_
> device has a stable order. Only those known at boot.
> 
> 
>     For example, I noticed these patches are strictly for DT.
>     I'm assuming that's because guaranteeing stable device order for
>     mmc in general is more difficult; eg., by performing minimal scan
>     serially and more expensive portion of the probe async.
> 
> 
> Presumably if there were another system similar to DT where we knew
> all the possible built-in devices right at boot then we could
> extend.
> 
> ...but yes, obviously this wouldn't be a sane thing to do for
> anything probable like PCI or USB.

SCSI does. Here's what Linus said:

"So the *simple* model is to just scan the devices minimally serially,
and allocate the names at that point (so the names are reliable
between boots for the same hardware configuration). And then do the
more expensive device setup asynchronously (ie querying device
information, spinning up disks, whatever - things that can take
anything from milliseonds to several seconds, because they are doing
actual IO). So you'd do some very basic (and _often_ fairly quick)
operations serially, but then try to do the expensive parts
concurrently.

The SCSI layer actually goes a bit further than that: it has a fairly
asynchronous scanning thing, but it does allocate the actual host
device nodes serially, and then it even has an ordered list of
"scanning_hosts" that is used to complete the scanning in-order, so
that the sysfs devices show up in the right order even if things
actually got scanned out-of-order. So scans that finished early will
wait for other scans that are for "earlier" devices, and you end up
with what *looks* ordered to the outside, even if internally it was
all done out-of-order.
"

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
