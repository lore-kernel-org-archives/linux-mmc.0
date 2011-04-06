From: Stephen Warren <swarren@nvidia.com>
Subject: RE: Dynamic MMC device naming vs. bootloaders
Date: Wed, 6 Apr 2011 09:59:36 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB36C7@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
 <BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
 <BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:8849 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1DFQ7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 12:59:22 -0400
In-Reply-To: <BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Kishore Kadiyala wrote at Wednesday, April 06, 2011 4:11 AM:
> 
> On Wed, Apr 6, 2011 at 2:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Kishore Kadiyala wrote at Tuesday, April 05, 2011 12:38 AM:
> >>
> >> Hi Stephen,
> >>
> >> On Mon, Apr 4, 2011 at 11:09 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >> > Chris et. al.,
> >> >
> >> > I'm working on an ARM system that contains at least two MMC/SD devices;
> >> > specifically the board has an internal MMC device, and an SD card slot,
> >> > although the SoC has four MMC/SD hosts IIRC.
> >> >
> >> > The kernel's naming of these devices is dynamic. If the SD card is not
> >> > plugged in, the internal MMC is always known as mmcblock0. If the SD card
> >> > is plugged in too, sometimes the internal MMC is mmcblk0 and sometimes it's
> >> > mmcblk1. I assume this is timing related; 2.6.37 usually seemed to name
> >> > them "in order", whereas 2.6.38 usually seems to name them "backwards".
> >> >
> >> > This causes problems with the bootloader scripts I'm using, which assumes
> >> > that the internal MMC is always device 0 and the SD slot is always device 1,
> >> > and hence provides kernel command-line argument root=/dev/mmcblk0p3 or
> >> > root=/dev/mmcblk1p3 based on whether it booted from SD or internal MMC (SD
> >> > is searched for a valid image first by the bootloader).
> >>
> >> Just follow this thread which discusses the same but for OMAP4 controller
> >> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47853.html
> >
> > Kishore, thanks for the pointer. However, I don't see anything in that thread
> > that affects MMC block device IDs. The thread ended with the original poster
> > requesting the patch be dropped, since he'd made a mistake in his bootloader
> > settings.
> >
> > Just perhaps the registration order change is enough to change the timing of
> > device (memory device, not host controller?) probing, which just happens to
> > affect the ID assignment?
> >
> >> One solution could be make your internal MMC always registered as mmcblk0
> >> and the removable one as next device.
> >
> > That's essentially what the patch I gave previously does.
> 
> Your change was in mmc/card/block.c, but you can handle this by
> changing sequence during device registeration.
> 
> Following change in the patch does that
> https://patchwork.kernel.org/patch/595861/

Ah. I do see now that Tegra's equivalent platform_device registration order was
changed between the two kernels that exhibit different behavior, so re-ordering
might work. I'll try it out.

However, isn't it just a fluke that this will work; registering the internal
host controller first will I assume start probing of any attached devices on
that controller first, but does it actually guarantee that such probing will
also complete first, which I believe is the necessary condition for the mmcblk
device to be assigned ID 0?

Equally, if there were two controllers with fixed/internal MMC and/or two
controllers which supported pluggable SD cards, the race issue would still
exist?

Thanks for the pointer!

-- 
nvpublic

