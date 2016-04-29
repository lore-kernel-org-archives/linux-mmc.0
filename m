From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 13:12:30 -0500
Message-ID: <CAL_JsqKOADU1hyLj+3cHjTJ7wgkOi-z-iWvFD3Bx5dvB12j+KQ@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461951139-6109-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>dev
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 29, 2016 at 12:32 PM, Douglas Anderson
<dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> This series picks patches from various different places to produce what
> I consider the best solution to getting consistent mmc and mmcblk
> ordering.
>
> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> ordering solves a few different problems:
>
> 1. For poor, feeble-minded humans like me, have sane numbering for
>    devices helps a lot.  When grepping through dmesg it's terribly handy
>    if a given SDMMC device has a consistent number.  I know that I can
>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
>    about the SD card slot.  I don't want it to matter which one probed
>    first, I don't want it to matter if I'm working on a variant of the
>    hardware that has the SD card slot disabled, and I don't want to care
>    what my boot device was.  Worrying about what device number I got
>    increases my cognitive load.
>
> 2. There are cases where it's not trivially easy during development to
>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
>    as a BIOS.  When configured properly, that BIOS has a nice feature to
>    allow you to fetch the kernel and kernel command line from TFTP by
>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
>    know which disk I'd like for my root filesystem, so it's not so easy
>    for it to put the right UUID into the command line.  For this
>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.

Why don't you use labels? This works whether your rootfs is on
/dev/vdXy, /dev/sdXy or /dev/mmcblkXpy. I can feel your pain as I've
been looking at the per device crap that is Android fstab files which
labels solve beautifully and worked without Android changes.

Sorry, I'm not keen to add something that is both MMC and DT specific.
If consistent numbering for devices is a goal in the kernel, then I'd
feel otherwise. But I'm pretty sure that is a non-goal.

Aliases were largely intended for backwards compatibility in cases
where the numbering was already consistent (IOW consoles).

Rob
