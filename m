From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Fri, 16 Dec 2011 03:25:54 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11651768@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323829093-29655-1-git-send-email-r66093@freescale.com>
 <144B2D54-4027-4815-833F-C5D91626382B@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11646CFB@039-SN1MPN1-006.039d.mgd.msft.net>
 <1A3D9F4B-2CA9-42E4-863D-F2E457D9593A@marvell.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1164F1EF@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EE9C61A.30103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:2294 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab1LPD0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 22:26:13 -0500
In-Reply-To: <4EE9C61A.30103@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

> > I am very confused, why do we read the present state register on every
> request?
> 
> How long time read the present state register?
Even if one line code is performed, I think it need time to complete.

> > My codes are added to the function mmc_sd_detect in file core/sd.c
> > Function mmc_rescan has detect the card present state repeatedly, so I
> think we don't need to detect the card state on every request.
> > So I think the codes to detect the card present state in sdhci_request
> should be removed to improve the performance.
> 
> How did you get the performance benefit?
Do you know there are many tools to run the performance?
IPForward/IPSEC for network, iozone for SATA/SDHC...

We have the performance result from our platform, the result will decrease 2%~5%!

If the driver has the option 'MMC_CAP_NEEDS_POLL' (many driver enable this option) and the card is always present, the driver will send the command "mmc_send_status" to ask the card state repeatedly.
Do you know what it means? Many interrupts will be generated even if the system is reading from/writing to the SD/MMC card.

> And mmc_rescan is repeatedly for SD-card?
> If mmc_rescan is repeatedly, that reason is the below code. (just my
> thinking)
> 
> if (host->caps & MMC_CAP_NEEDS_POLL)
> 	mmc_schedule_delayed_work(&host->detect, HZ);
> 
> what is your point related with mmc_rescan?
> I didn't understand yours..

There are some controllers don't support the card detect, the SDHCI_CARD_PRESENT is forever one. And some controller must enable the MMC_CAP_NEEDS_POLL option (about this, you can search the folder mmc/host/), that means mmc_rescan will be run repeatedly.
In these cases, if we detect the card state though command mmc_send_status, a lot of interrupts will be generated.

For the transaction from/to SD card, we don't need to check the card present state, it should be done in other area.
So I don't think it is correct to detect card state in function sdhci_request. 


