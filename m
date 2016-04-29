From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Fri, 29 Apr 2016 20:57:41 +0100
Message-ID: <20160429195741.GY19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59510 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbcD2T6N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 15:58:13 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>Pawel Moll <p>

On Fri, Apr 29, 2016 at 12:43:39PM -0700, Doug Anderson wrote:
> Russell,
> 
> On Fri, Apr 29, 2016 at 11:12 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
> >> This series picks patches from various different places to produce what
> >> I consider the best solution to getting consistent mmc and mmcblk
> >> ordering.
> >>
> >> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> >> ordering solves a few different problems:
> >
> > NAK.  Really.  Use UUIDs, that's the proper solution here.
> 
> Un-NAK.  UUIDs don't solve point #1.

Re-NAK.  I don't think your point #1 is valid.  See my other reply.

> * Presumably on a PC you've got an extra bit in the middle (like grub
> or something like that) that can help you resolve your UUIDs even if
> you get your kernel from somewhere else.

You are over-estimating what grub does.  Grub doesn't resolve UUIDs at
all.  Grub just passes the kernel arguments in its configuration file
for the entry it is booting to the kernel.  It's a static configuration
found in /boot/grub/grub.conf.

It doesn't probe devices for UUIDs.

> * Presumably in the non-embedded world kernel hackers have a different
> workflow.  They probably don't swap between different devices with
> different configurations on an hourly basis.  They're not in the habit
> of totally reimaging their system periodically.  Etc.  Trying to force
> the workflow of a PC kernel hacker and an embedded kernel hacker to be
> the same doesn't seem like a worthwhile goal.

In _my_ world with the "embedded" devices I have, I mount by UUID on
platforms which have multiple MMC devices to avoid exactly the problem
you're having.  This works fine.

If I were to switch the SD card, and I wanted to avoid changing the
boot loader configuration, I'd use label instead, and I'd label all
the SD card rootfs using the same label so I could just swap the cards.

> * Presumably an embedded kernel hacker running with ATA / SCSI could
> _usually_ assume that "sda" is his/her root filesystem.  It's unlikely
> an embedded system would have more than one "sda" disk builtin and
> it's nearly guaranteed (I think) that a builtin ATA / SCSI controller
> would probe before any USB based devices.

You've got a funny view again.  N2100 has two hard disks.  The clearfog
board from SolidRun has two mini-PCIe slots, each of which can have two
SATA interfaces... If you want to use it as a server-type platform with
lots of disks...

> Sure, if your root
> filesystem is USB based (really?) and you've got additional USB
> storage devices then you're SOL.  Sorry.

One of my Versatile Express platforms boots from USB, and has a MMC
slot...  So this argument does not stack up.

Sorry.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
