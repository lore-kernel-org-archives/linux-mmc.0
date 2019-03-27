From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Wed, 27 Mar 2019 20:54:24 +0000
Message-ID: <20190327205424.5qivtnyufiapkbor@shell.armlinux.org.uk>
References: <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
 <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
 <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
 <c23d6c4edf92d58aec86da811eaa97a5@agner.ch>
 <yw1xbm2930rr.fsf@mansr.com>
 <20190317165957.k6lxxaq3hbs2owqz@shell.armlinux.org.uk>
 <CAJ+vNU0v8FXStXCfJUk5uJXiPuGGFLNW7aHOYfSoNJgu9qXHKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0v8FXStXCfJUk5uJXiPuGGFLNW7aHOYfSoNJgu9qXHKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, Venu Byravarasu IN <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.comli
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 27, 2019 at 10:37:19AM -0700, Tim Harvey wrote:
> On Sun, Mar 17, 2019 at 10:00 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, Mar 17, 2019 at 04:48:24PM +0000, Måns Rullgård wrote:
> > > Stefan Agner <stefan@agner.ch> writes:
> > >
> > > > On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
> > > >> On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
> > > >>> If you have a FS or partition table there, it does.
> > > >>> If you don't, I agree ... that's a problem.
> > > >>
> > > >> eMMC boot partitions are called mmcblkXbootY, and unless you have more
> > > >> than one eMMC device on the system, they can be found either by looking
> > > >> for /dev/mmcblk*boot* or by querying udev.  The advantage of using udev
> > > >> is you can discover the physical device behind it by looking at DEVPATH,
> > > >> ID_PATH, etc, but you may not have that installed on an embedded device.
> > > >>
> > > >> However, as I say, just looking for /dev/mmcblk*boot* is sufficient to
> > > >> find the eMMC boot partitions where there is just one eMMC device
> > > >> present (which seems to be the standard setup.)
> > > >>
> > > >>> > I don't care the slightest what the numbering is, as long as it is
> > > >>> > stable.  On some hardware, with an unpatched kernel, the mmc device
> > > >>> > numbering changes depending on whether or not an SD card is inserted on
> > > >>> > boot.  Getting rid of that behaviour is really all I want.
> > > >>>
> > > >>> Agreed, that would be an improvement.
> > > >>
> > > >> The mmc device numbering was tied to the mmc host numbering a while back
> > > >> and the order that the hosts are probed should be completely independent
> > > >> of whether a card is inserted or not:
> > > >>
> > > >>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> > > >>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> > > >>
> > > >>         snprintf(rpmb_name, sizeof(rpmb_name),
> > > >>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> > > >>
> > > >> I suspect that Mans is quoting something from the dim and distant past
> > > >> to confuse the issue - as shown above, it is now dependent on the host
> > > >> numbering order not the order in which cards are inserted.
> > > >
> > > > Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as the
> > > > mmcblk device index") which came in with v4.6 enables constant mmc block
> > > > device numbering. I can confirm that it works nicely, and it improved
> > > > the situation a lot.
> > >
> > > That's the answer I was looking for.  I guess we can drop these patches
> > > from our kernels then.
> > >
> > > > That being said, we still use a patch downstream which allows
> > > > renumbering using an alias. We deal with a bunch of different boards
> > > > with different SoC's. I have a couple of SD cards with various rootfs
> > > > and use internal eMMC boot quite often as well. Remembering which board
> > > > uses which numbering is a pain. Maintaining a patch is just easier...
> > > > Furthermore, U-Boot allows reordering and all boards I deal with use mmc
> > > > 0 for the internal eMMC. The aliases allow consistency.
> > >
> > > Since pretty much every other device type supports renumbering with DT
> > > aliases, it would make sense to do this for mmc as well.
> >
> > SATA does not.  SCSI devices, whether they are disks, cdroms, tape
> > drives or whatever have always been allocated dynamically in the
> > order that they are discovered.
> >
> > Ethernet also does not, and davem remains opposed the idea of fixed
> > allocation in the kernel.
> >
> > It's only a minority that demand fixed enumeration of devices.
> >
> 
> Russell,
> 
> How does this case differ form defining a 'stdout-path' in the chosen
> node of the device-tree [1] purposed to provide a path to the boot
> console device among multiple UART's a board may have.

You are comparing apples and oranges.

stdout-path defines which output device is the "standard output", but
it doesn't define that it shall be called "output device number zero".

So, stdout-path has nothing to do with device naming.

> Again, I'm merely trying to overcome the fact that on one of my IMX6
> boards usdhc2 registers as 'mmcblk0' and is an SDIO radio while usdhc3
> registers as 'mmcblk1' and is the only 'bootable' device. I'm not all
> that familiar with SDIO drivers... perhaps its completely wrong that
> the IMX6 MMC driver is registering usdhc2 as a 'block device'?

Right, you probably only have the usdhc2 and usdhc3 devices enabled
in device tree, and usdhc2 gets probed first (and allocated the first
MMC host index) followed by usdhc3.

Prior to the commit I mentioned, your case would have been quite sane
in that the SD card would always show up as mmcblk0 irrespective of
the order that the two SD host interfaces were discovered.  However,
the commit that ties the MMC/SD host number to the MMC block device
number has two effects:

1. the MMC block device numbers are equal to the MMC/SD host numbers.
2. the MMC standard supports multiple cards attached to a single host
   which became unsupportable.  (This is why MMC block device numbers
   were dynamic - the MMC code was written in the days when MMC cards
   were popular and SD was "new".  There is no way to really know how
   many MMC block devices there could be showing up per host.)  That
   became obsolete with SD, and I don't believe anyone ever produced
   a multi-MMC card setup.

I had realised that setups such as yours (SDIO in first host, SD in
second host) would result in a sane numbering becoming weird, but the
voices demanding (and I use demand, because that's exactly the tone
of the discussion) that MMC block devices not be dynamic were very
loud and strong - and remains so, as you can see from the tone of
Mans message bring this subject back up.

I should point out that as a result of this, MMC block devices follow
different behaviour from other devices in Linux.  For example:

- ATA HDDs devices get allocated SCSI disk numbers starting at zero
  according to the order they are detected.  The same goes for all
  other devices such as scanners, tape drives, optical drives, etc.
- Ethernet devices get allocated ethX numbers starting at zero
  according to the order that the drivers register the devices.
- USB devices are exactly the same - entirely dynamic device names.

For all of these, there are solutions in userspace.  For block devices
with partitions, there is PARTUUID, which is an identifier from the
partition table plus a partition number which the kernel can interpret.
There are filesystem labels and UUIDs which an initramfs can probe to
locate the root filesystem.  These can also be used with udev to
create persistent device names in /dev - see /dev/disk/by-* for
example.

Ethernet devices in modern distros have udev rules to rename them to
a name that somehow represents their location - eg, enp1s0.

USB devices, such as serial ports, do not have static names, but if
you have a lot of them (like I do) udev really helps - I have custom
udev rules which create symlinks to the USB serial devices I care
about in /dev/serial, so for example:

lrwxrwxrwx 1 root root 10 Mar 20 00:43 /dev/serial/usb-cubox-es -> ../ttyUSB0
...
lrwxrwxrwx 1 root root 11 Mar 20 00:43 /dev/serial/usb-mcbin-ds-es -> ../ttyUSB10
lrwxrwxrwx 1 root root 11 Mar 20 00:43 /dev/serial/usb-mcbin-ss -> ../ttyUSB11
...
lrwxrwxrwx 1 root root 10 Mar 20 00:43 /dev/serial/usb-ttl -> ../ttyUSB1
...
lrwxrwxrwx 1 root root 10 Mar 20 00:43 /dev/serial/usb-zii-b -> ../ttyUSB8

so I no longer need to worry about which order these are discovered,
which bus they're connected to, which hub, or anything, which is
kind of important when you consider that this machine is laptop on a
docking station, and all these devices are connected via hubs on
four USB ports on the docking station.

In the absence of such custom rules, there are persistent names by
both the device name/serial number (/dev/serial/by-id) and by the
bus path (/dev/serial/by-path).  Both of these are created by udev
using the policy set in its rules database.

The kernel really does not set the userspace device name policy,
although it has a "default" policy.  Userspace has, for many years,
been at liberty to change the policy in any way it sees fit, even if
devtmpfs is being used.

devtmpfs is just a tmpfs filesystem which the kernel adds devices
to using the kernel's naming policy, and will remove its own 
devices when they disappear.  Userspace is at liberty to create
additional names, rename the devices, even delete them if it so
wishes.

Sure, some people may not wish to run udev, which is fine.  In the
absence of udev, it is entirely possible to find out the device
names by looking in /sys/class or /sys/devices.  For example, on
my Armada 8040 platform (where I have eMMC and a SD card), I can
look at all the block devices present using the default kernel
device name:

$ ls -al /sys/class/block

and each one is a symlink (that can be read using readlink in shell
code) to discover where it is on the system.  For example, in bash:

for dev in /sys/class/block/mmcblk*; do
  path=`readlink -f $dev`
  if [[ $path =~ /f06e0000.sdhci/ ]]; then
     basename $dev
  fi
done

yields:

mmcblk0
mmcblk0boot0
mmcblk0boot1

which are found under /dev:

brw-rw---- 1 root disk 179,  0 Mar 26 19:30 /dev/mmcblk0
brw-rw---- 1 root disk 179,  8 Mar 26 19:30 /dev/mmcblk0boot0
brw-rw---- 1 root disk 179, 16 Mar 26 19:30 /dev/mmcblk0boot1

Here's another way, which is simpler if you have the path of the
device in DT, which will always be constant:

$ basename
/sys/devices/platform/ap806/ap806\:config-space@f0000000/f06e0000.sdhci/mmc_host/mmc*/mmc*/block/mmcblk*
mmcblk0

or if you prefer:

$ find /sys/devices/platform/ap806/ap806\:config-space@f0000000/f06e0000.sdhci -name 'mmcblk?' -printf '%f\n'
mmcblk0

or:

$ find /sys/devices/platform/ap806 -name 'mmcblk*' -printf '%f\n'
mmcblk0rpmb
mmcblk0
mmcblk0boot0
mmcblk0boot1
$ find /sys/devices/platform/cp0 -name 'mmcblk*' -printf '%f\n'
mmcblk1
mmcblk1p3
mmcblk1p1
mmcblk1p2

There are many ways to solve the "what name is my device using" problem
in userspace that does not require coding policy into the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
