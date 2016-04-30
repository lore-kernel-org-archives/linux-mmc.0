From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Sat, 30 Apr 2016 11:48:33 +0100
Message-ID: <20160430104832.GJ19428@n2100.arm.linux.org.uk>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CABxcv==4C+RrEV1Fd+DkbMdGrLyObw36vsmo3wTGdxO=UnAa8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60854 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcD3KtN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Apr 2016 06:49:13 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv==4C+RrEV1Fd+DkbMdGrLyObw36vsmo3wTGdxO=UnAa8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"devicetree@vger.kernel.org" <dev>

On Fri, Apr 29, 2016 at 06:42:35PM -0400, Javier Martinez Canillas wrote:
> Maybe a third opinion could make this conversation constructive again.
> 
> I think Doug's point is that using a UUID or labels for consistency is
> orthogonal to having a deterministic numbering for MMC devices. And I
> agree with his point of view for what is worth.

Yes, it may be orthogonal, but there are two issues here:

1. How does the system know which MMC device to mount for its rootfs.

This is the point that I've picked up on, which has been solved for
years, and actually pre-dates MMC support in the kernel, and that is
mount by UUID.

The kernel itself has no support for mount-by-label, which is normally
solved by using an initramfs, which contains programs such as mount
etc which will scan the block devices looking for an appropriately
labelled filesystem.  Label has slightly more issues since its possible
that you could end up with two filesystems with the same label (eg, on
x86, you're migrating your disks, and you plug in a disk which has a
label of "/" but is not your intended rootfs.)

Of course, any scheme which relies on an identifier on the disk may
result in some kind of clash if another partition/disk has the same
identifier.

2. The identifier found in kernel messages for each MMC device.

This is where Doug and myself disagree.  I don't see this as a big
problem - the big problem is (1) above, which is the one which can
lead to a non-functional system.  I believe that the actual name
that we end up with is a cosmetic issue.

What I've been trying to point out is that the same cosmetic issue
occurs elsewhere in the kernel, particularly with disks on SATA
interfaces.  I've lost count of the number of times that my IDE
disks on one of my machines have changed between /dev/hda, /dev/hdc,
/dev/sda, /dev/sdc, etc.  Thankfully, these are part of a raid
array, and they are always constructed to appear as /dev/md* devices
which are the devices that are mounted.

The device names that they end up with depend on which drivers are
built-in to the kernel, and the order in which the device drivers
and devices are probed.  There's no way to tell the kernel "I want
PCI card X socket Y to be _this_ device name" and that's a concious
decision that was made years ago.

However, it's a cosmetic issue - reading the log reveals which is
which, and MMC is no different - the information required is in the
log.

Here's some material on the problem:

http://www.tldp.org/HOWTO/Partition/devices.html
http://tldp.org/HOWTO/Partition-Mass-Storage-Definitions-Naming-HOWTO/x99.html
https://lkml.org/lkml/1997/5/4/54
http://marc.info/?l=linux-raid&m=113595057816321&w=2

The first two show that it's well understood (and documented) that
storage devices are dynamically assigned and variable.

The third is an example of how old this problem is - almost twenty
years old, and it hasn't been "solved" on x86 except by using UUID/
labels.

The forth is an example of the "problem" that this dynamic device
assignment causes, and again shows that kernel folk have chosen
not to solve it by way of the problem still existing today.

I guess I don't see it as much of problem because I've been doing
this for over a decade.

Now, thinking outside the box - if it's desirable for eMMC to be
treated differently from regular MMC slots, maybe the solution to
this problem is to have eMMC occupy a separate namespace, rather
than using the /dev/mmcblk* namespace.  IOW, /dev/emmc* ?

The /dev/mmcblk* namespace was designed (by me) to be dynamic,
because MMC (not SD) bus structure allows for multiple cards on the
same MMC host interface, much like a SCSI bus allows for multiple
devices on the same cable.  Hence, tying individual mmcblkN to
the mmcN host interface is wrong.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
