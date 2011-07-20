From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Question regarding SDR104 bus speed mode
Date: Wed, 20 Jul 2011 12:52:06 +0530
Message-ID: <000001cc46ad$bd0bb790$372326b0$@org>
References: <dd8e0dfbe0f4d466cc39fb67a2a4e4a3.squirrel@www.codeaurora.org> <000001cc450a$9c94aac0$d5be0040$@org> <02B9B20D-2C0C-41C1-BD8D-72FD2C3BCA41@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:45402 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1GTHWL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2011 03:22:11 -0400
In-Reply-To: <02B9B20D-2C0C-41C1-BD8D-72FD2C3BCA41@marvell.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Philip Rakity' <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Philip Rakity
> Sent: Monday, July 18, 2011 8:57 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; arindam.nath@amd.com
> Subject: Re: Question regarding SDR104 bus speed mode
> 
> 
> On Jul 17, 2011, at 10:21 PM, Subhash Jadavani wrote:
> 
> > Arindam/Philips,
> >
> > Can you help me with below query?
> >
> > Regards,
> > Subhash
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> >> Sent: Thursday, July 14, 2011 5:09 PM
> >> To: linux-mmc@vger.kernel.org; prakity@marvell.com;
> >> arindam.nath@amd.com
> >> Subject: Question regarding SDR104 bus speed mode
> >>
> >> Hi Arindam, Philips and All,
> >>
> >> According to SD 3.0 spec (section 3.9.6), cards may require current
> >> upto
> >> 800 mA while running in SDR104. However Max. supported current from
> >> PMIC
> >> regulator connected to sd card slot on my board is 600mA.
> >>
> >> I have these questions:
> >> 1. So does this mean we can't support the SDR104 mode if regulator
> >> current
> >> driving capacity is not upto 800 mA?
> >>
> >> 2. I am able to make SD card run in SDR104 mode even if the max.
> >> current
> >> supplied by regulator is upto 600 mA. So is this 800mA requirement
> is
> >> **must** condition to support SDR104 mode reliably?
> 
> Check the datasheet for the chip vendor you are using assuming the
> chip is soldered down on the board.  Our our system the eMMC chip
> is much more flexible then the JEDEC spec allows.

Philips,
This is not for eMMC/MMC spec and cards. This is for SDR104 mode from SD3.0
spec. and relevant for SD UHS-I cards only.
Any comments of running SDR104 with 600mA driver current? Is this fine
according to SD3.0 spec?

> 
> >>
> >> Regards,
> >> Subhash
> >>
> >> --
> >> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> >> Forum.
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

