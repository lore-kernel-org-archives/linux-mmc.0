From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 12:31:28 -0700
Message-ID: <CAD=FV=XFZ+4o_QyOdkNZyZ6ZmyXNH1Fbn458oeAxAMLOB=fLkg@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
	<CAL_JsqKOADU1hyLj+3cHjTJ7wgkOi-z-iWvFD3Bx5dvB12j+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKOADU1hyLj+3cHjTJ7wgkOi-z-iWvFD3Bx5dvB12j+KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Rob,

On Fri, Apr 29, 2016 at 11:12 AM, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Apr 29, 2016 at 12:32 PM, Douglas Anderson
> <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> This series picks patches from various different places to produce what
>> I consider the best solution to getting consistent mmc and mmcblk
>> ordering.
>>
>> Why consistent ordering and why not just use UUIDs?  IMHO consistent
>> ordering solves a few different problems:
>>
>> 1. For poor, feeble-minded humans like me, have sane numbering for
>>    devices helps a lot.  When grepping through dmesg it's terribly handy
>>    if a given SDMMC device has a consistent number.  I know that I can
>>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
>>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
>>    about the SD card slot.  I don't want it to matter which one probed
>>    first, I don't want it to matter if I'm working on a variant of the
>>    hardware that has the SD card slot disabled, and I don't want to care
>>    what my boot device was.  Worrying about what device number I got
>>    increases my cognitive load.
>>
>> 2. There are cases where it's not trivially easy during development to
>>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
>>    as a BIOS.  When configured properly, that BIOS has a nice feature to
>>    allow you to fetch the kernel and kernel command line from TFTP by
>>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
>>    know which disk I'd like for my root filesystem, so it's not so easy
>>    for it to put the right UUID into the command line.  For this
>>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
>
> Why don't you use labels? This works whether your rootfs is on
> /dev/vdXy, /dev/sdXy or /dev/mmcblkXpy.

I've never used labels.  I can take a look at them.  I presume I'll
have to do a little extra work to tag my "emmc" filesystem properly
when I install to eMMC, but that wouldn't be too bad.  Thanks for the
suggestion.

That solves point #2, but not point #1.  It still adds an extra step
of mapping number to device when looking at logs / sysfs files.

IMHO:

* this patch set is very small.

* this patch set doesn't hurt anyone.

* I believe lots of people feel that this patch set would be useful.

* this patch set is very small and shouldn't be too hard to maintain.

* the MMC maintainer, who would be responsible for dealing with the
code in the future if any problems come up, seem to be OK with it.

> I can feel your pain as I've
> been looking at the per device crap that is Android fstab files which
> labels solve beautifully and worked without Android changes.
>
> Sorry, I'm not keen to add something that is both MMC and DT specific.

It would be quite easy to adjust this to other systems if they
provided similar functionality.  Nearly 100% of this code is just
calling helper functions, so the code would be easy to find and change
if/when there was a generic (non-DT) method for this.

As far as it being MMC specific: it's not.  Do a "git grep" for
of_alias_get_id().  It's used in many, many places.


> If consistent numbering for devices is a goal in the kernel, then I'd
> feel otherwise. But I'm pretty sure that is a non-goal.

Can you provide documentation that this is a non-goal?  I can submit
some patches upstream to make ID allocation behave more randomly if
that would be helpful to upstream.  I'd probably want to disable it
locally, but if you think folks would really like it...  ;)

In all seriousness, though, I'm not sure why randomness in IDs would
be considered a worthwhile goal.  Is it because:

* You're trying to discourage people from building systems where they
hardcode "/dev/mmcblk0" as the eMMC?  Maybe it would be better to
throw a big WARN_ON in the boot log for this?

* You think that numbering like this doesn't scale somehow?  Note that
for a given piece of hardware it's quite likely to have a small number
of MMC slots and it's quite likely that users of this SoC can agree on
the numbering (emmc = 0, SD slots start at 1).

* Some other reason?


-Doug
