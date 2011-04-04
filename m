From: Stephen Warren <swarren@nvidia.com>
Subject: RE: Dynamic MMC device naming vs. bootloaders
Date: Mon, 4 Apr 2011 14:07:06 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3428@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
 <m3r59haog5.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:9891 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab1DDVGu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 17:06:50 -0400
In-Reply-To: <m3r59haog5.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris Ball wrote at Monday, April 04, 2011 11:58 AM:
> 
> Hi Stephen,
> 
> On Mon, Apr 04 2011, Stephen Warren wrote:
> > Chris et. al.,
> >
> > I'm working on an ARM system that contains at least two MMC/SD devices;
> > specifically the board has an internal MMC device, and an SD card slot,
> > although the SoC has four MMC/SD hosts IIRC.
> >
> > The kernel's naming of these devices is dynamic. If the SD card is not
> > plugged in, the internal MMC is always known as mmcblock0. If the SD card
> > is plugged in too, sometimes the internal MMC is mmcblk0 and sometimes it's
> > mmcblk1. I assume this is timing related; 2.6.37 usually seemed to name
> > them "in order", whereas 2.6.38 usually seems to name them "backwards".
> 
> The standard way to solve this is to use an initrd that performs the
> naming (and mounting) that you'd like based on characteristics of the
> device or card -- this could include making mmcblk{0,1} always attach
> to the controllers that you're expecting it to.  It's hard enough to get
> device naming policy right that we don't usually try to do it in-kernel.


Chris,

Thanks for the very quick response.

I have a followup question: How could the initrd identify each device, in
order to know which names to assign to them, or which one to mount?

Is there a way to query the block device to determine which host controller
ID it's connected to? Querying device size is pretty easy, but the user
could easily happen to choose an SD card of the same size as the internal
MMC for example.

I believe that x86 desktop distros typically use filesystem or device UUIDs
for this purpose in the initrd, but in the distro I'm using, there is
typically neither any UUID, nor an initrd. Equally, it's pretty easy with
grub to edit grub.cfg/menu.cfg to contain the correct UUID during install
or if it ever changes. Modifying U-Boot's saved environment (boot commands)
to include the a UUID would be more challenging, especially since
the boot commands are typically stored in the system's ROM/flash, whereas
the filesystem may be on some completely random user-supplied SD card.

Thanks.

-- 
nvpublic

