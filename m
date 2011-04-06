From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: Dynamic MMC device naming vs. bootloaders
Date: Wed, 6 Apr 2011 15:41:15 +0530
Message-ID: <BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
 <BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43427 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab1DFKLh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 06:11:37 -0400
Received: by wwa36 with SMTP id 36so1558999wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 03:11:36 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 6, 2011 at 2:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Kishore Kadiyala wrote at Tuesday, April 05, 2011 12:38 AM:
>>
>> Hi Stephen,
>>
>> On Mon, Apr 4, 2011 at 11:09 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> > Chris et. al.,
>> >
>> > I'm working on an ARM system that contains at least two MMC/SD devices;
>> > specifically the board has an internal MMC device, and an SD card slot,
>> > although the SoC has four MMC/SD hosts IIRC.
>> >
>> > The kernel's naming of these devices is dynamic. If the SD card is not
>> > plugged in, the internal MMC is always known as mmcblock0. If the SD card
>> > is plugged in too, sometimes the internal MMC is mmcblk0 and sometimes it's
>> > mmcblk1. I assume this is timing related; 2.6.37 usually seemed to name
>> > them "in order", whereas 2.6.38 usually seems to name them "backwards".
>> >
>> > This causes problems with the bootloader scripts I'm using, which assumes
>> > that the internal MMC is always device 0 and the SD slot is always device 1,
>> > and hence provides kernel command-line argument root=/dev/mmcblk0p3 or
>> > root=/dev/mmcblk1p3 based on whether it booted from SD or internal MMC (SD
>> > is searched for a valid image first by the bootloader).
>>
>> Just follow this thread which discusses the same but for OMAP4 controller
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47853.html
>
> Kishore, thanks for the pointer. However, I don't see anything in that thread
> that affects MMC block device IDs. The thread ended with the original poster
> requesting the patch be dropped, since he'd made a mistake in his bootloader
> settings.
>
> Just perhaps the registration order change is enough to change the timing of
> device (memory device, not host controller?) probing, which just happens to
> affect the ID assignment?
>
>> One solution could be make your internal MMC always registered as mmcblk0
>> and the removable one as next device.
>
> That's essentially what the patch I gave previously does.

Your change was in mmc/card/block.c, but you can handle this by
changing sequence during
device registeration.

Following change in the patch does that
https://patchwork.kernel.org/patch/595861/

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index 1a943be..f914099 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -349,11 +349,6 @@  static struct twl4030_usb_data omap4_usbphy_data = {

 static struct omap2_hsmmc_info mmc[] = {
 	{
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-		.gpio_wp	= -EINVAL,
-	},
-	{
 		.mmc		= 2,
 		.caps		=  MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
@@ -361,19 +356,24 @@  static struct omap2_hsmmc_info mmc[] = {
 		.nonremovable   = true,
 		.ocr_mask	= MMC_VDD_29_30,
 	},
+	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpio_wp	= -EINVAL,
+	},
 	{}	/* Terminator */
 };

Regards,
Kishore

>
> --
> nvpublic
>
>
