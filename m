From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Fri, 29 Apr 2016 20:50:08 +0100
Message-ID: <20160429195007.GX19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <CAL_JsqKOADU1hyLj+3cHjTJ7wgkOi-z-iWvFD3Bx5dvB12j+KQ@mail.gmail.com>
 <CAD=FV=XFZ+4o_QyOdkNZyZ6ZmyXNH1Fbn458oeAxAMLOB=fLkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=XFZ+4o_QyOdkNZyZ6ZmyXNH1Fbn458oeAxAMLOB=fLkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>d
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 29, 2016 at 12:31:28PM -0700, Doug Anderson wrote:
> Rob,
> 
> On Fri, Apr 29, 2016 at 11:12 AM, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Apr 29, 2016 at 12:32 PM, Douglas Anderson
> > <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> >> This series picks patches from various different places to produce what
> >> I consider the best solution to getting consistent mmc and mmcblk
> >> ordering.
> >>
> >> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> >> ordering solves a few different problems:
> >>
> >> 1. For poor, feeble-minded humans like me, have sane numbering for
> >>    devices helps a lot.  When grepping through dmesg it's terribly handy
> >>    if a given SDMMC device has a consistent number.  I know that I can
> >>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
> >>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
> >>    about the SD card slot.  I don't want it to matter which one probed
> >>    first, I don't want it to matter if I'm working on a variant of the
> >>    hardware that has the SD card slot disabled, and I don't want to care
> >>    what my boot device was.  Worrying about what device number I got
> >>    increases my cognitive load.
> >>
> >> 2. There are cases where it's not trivially easy during development to
> >>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
> >>    as a BIOS.  When configured properly, that BIOS has a nice feature to
> >>    allow you to fetch the kernel and kernel command line from TFTP by
> >>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
> >>    know which disk I'd like for my root filesystem, so it's not so easy
> >>    for it to put the right UUID into the command line.  For this
> >>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
> >
> > Why don't you use labels? This works whether your rootfs is on
> > /dev/vdXy, /dev/sdXy or /dev/mmcblkXpy.
> 
> I've never used labels.  I can take a look at them.  I presume I'll
> have to do a little extra work to tag my "emmc" filesystem properly
> when I install to eMMC, but that wouldn't be too bad.  Thanks for the
> suggestion.
> 
> That solves point #2, but not point #1.  It still adds an extra step
> of mapping number to device when looking at logs / sysfs files.

Your original two arguments don't really stand up.

Let's take #2 to start with.

You claim that coreboot doesn't have support to provide the correct UUID.
Why is that a problem?  Distros on x86 don't have support to provide the
correct UUID either.  That's done by the distro when setting the system
up - it provides the kernel loader (eg, grub) with an appropriate
configuration, which includes a root specifier with the correct UUID,
eg:

 root=UUID=a5dcd879-eea2-4d87-bdef-8ee76741e7df

That's for the initramfs to use, but there's a short UUID equivalent for
the kernel itself, or as Rob and myself have already pointed out, the
label system (which is problematical if you have multiple filesystems
with the same label.)  UUID is the better system.

For #1, are you really saying that you're somehow different from all the
x86 platform users, and can't cope with dynamic numbering of devices that
are present on x86 systems?

> It would be quite easy to adjust this to other systems if they
> provided similar functionality.  Nearly 100% of this code is just
> calling helper functions, so the code would be easy to find and change
> if/when there was a generic (non-DT) method for this.

Except the problem is already solved by the UUID or label mount methods,
which work everywhere, even across different media.  So, if you decide
to plug your SD card into a USB reader because the SD slot has become
unreliable, if you mount by UUID or label, the kernel will still find
the right device, even though it's now become /dev/sd* instead of
/dev/mmcblk*.

> > If consistent numbering for devices is a goal in the kernel, then I'd
> > feel otherwise. But I'm pretty sure that is a non-goal.
> 
> Can you provide documentation that this is a non-goal?  I can submit
> some patches upstream to make ID allocation behave more randomly if
> that would be helpful to upstream.  I'd probably want to disable it
> locally, but if you think folks would really like it...  ;)
> 
> In all seriousness, though, I'm not sure why randomness in IDs would
> be considered a worthwhile goal.

*Sigh* you're taking this to an extreme.  Random numbering isn't a goal
in itself.  The kernel just doesn't provide a _guarantee_ the order in
which devices appear or the names which the devices will get.

It means that you _can_ mount by device path if you wish, but you may
occasionally run into cases where the device path changes for one
reason or another (eg, because you've changed the PCIe card slot that
your SATA PCIe card is plugged into, or many other reasons.)

Just use UUID (preferred) or label and enjoy much more flexibility than
your solution adding yet more code to the kernel would give you.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
