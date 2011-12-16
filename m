From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Fri, 16 Dec 2011 04:33:20 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1165180B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323829093-29655-1-git-send-email-r66093@freescale.com>
 <144B2D54-4027-4815-833F-C5D91626382B@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646CFB@039-SN1MPN1-006.039d.mgd.msft.net>
 <1A3D9F4B-2CA9-42E4-863D-F2E457D9593A@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1164F1EF@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EE9C61A.30103@samsung.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11651768@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EEAC38D.9070705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:15282
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754042Ab1LPEdY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Dec 2011 23:33:24 -0500
In-Reply-To: <4EEAC38D.9070705@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
> Sent: Friday, December 16, 2011 12:06 PM
> To: Huang Changming-R66093
> Cc: Jaehoon Chung; Philip Rakity; linux-mmc@vger.kernel.org; Chris Ball
> Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect
> the card
> 
> On 12/16/2011 12:25 PM, Huang Changming-R66093 wrote:
> 
> >>> I am very confused, why do we read the present state register on
> every
> >> request?
> >>
> >> How long time read the present state register?
> > Even if one line code is performed, I think it need time to complete.
> >
> >>> My codes are added to the function mmc_sd_detect in file core/sd.c
> >>> Function mmc_rescan has detect the card present state repeatedly, so
> I
> >> think we don't need to detect the card state on every request.
> >>> So I think the codes to detect the card present state in
> sdhci_request
> >> should be removed to improve the performance.
> >>
> >> How did you get the performance benefit?
> > Do you know there are many tools to run the performance?
> > IPForward/IPSEC for network, iozone for SATA/SDHC...
> >
> > We have the performance result from our platform, the result will
> decrease 2%~5%!
> >
> > If the driver has the option 'MMC_CAP_NEEDS_POLL' (many driver enable
> this option) and the card is always present, the driver will send the
> command "mmc_send_status" to ask the card state repeatedly.
> > Do you know what it means? Many interrupts will be generated even if
> the system is reading from/writing to the SD/MMC card.
> >
> >> And mmc_rescan is repeatedly for SD-card?
> >> If mmc_rescan is repeatedly, that reason is the below code. (just my
> >> thinking)
> >>
> >> if (host->caps & MMC_CAP_NEEDS_POLL)
> >> 	mmc_schedule_delayed_work(&host->detect, HZ);
> >>
> >> what is your point related with mmc_rescan?
> >> I didn't understand yours..
> >
> > There are some controllers don't support the card detect, the
> SDHCI_CARD_PRESENT is forever one. And some controller must enable the
> MMC_CAP_NEEDS_POLL option (about this, you can search the folder
> mmc/host/), that means mmc_rescan will be run repeatedly.
> > In these cases, if we detect the card state though command
> mmc_send_status, a lot of interrupts will be generated.
> 
> I know that...Some controller didn't support the card detect...But I
> think you can control this problem with SDHCI_QUIRK_BROKEN_CARD_DETECTION
> and some flags.
> If controller is always polling for card status, that's inefficient.
Maybe.
But, many controller will polling the card state as controller designed.

> I use the SDHCI_QUIRK_BROKEN_CARD_DETECTION, but didn't generate the
> interrupt at every time(didn't polling)
> I think you can solve this problem in sdhci-xxx.c, not in sdhci.c
> 
Because there is one interface to detect card state .get_cd in structure mmc_host_ops,
I just implement it in sdhci.c and just run the callback if the controller support the card detection,
and think about some controller don't support card detection,
I add one new interface to detect the card state in special platform.
For FSL eSDHC controller, I do it in sdhci-of-esdhc.c

