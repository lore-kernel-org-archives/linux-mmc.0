From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4] MMC/SD: Add callback function to detect card
Date: Wed, 14 Dec 2011 02:21:24 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11645D83@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <1323077026-12071-2-git-send-email-r66093@freescale.com>
 <4EE1DCEB.5030102@intel.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11644BF7@039-SN1MPN1-006.039d.mgd.msft.net>
 <4EE7063F.9090900@intel <4EE712B1.6030706@intel.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11644F37@039-SN1MPN1-006.039d.mgd.msft.net>
 <4EE7285C.3070503@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:16203
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755741Ab1LNCV3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 21:21:29 -0500
In-Reply-To: <4EE7285C.3070503@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> >>>>
> >>>> You patch uses (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL) Does that
> >>>> mean SDHCI_CARD_CDPL does work in that case?
> >>> No.
> >>> The SDHCI_CARD_CDPL[bit13] reflect the pin level:
> >>> CDPL: Card detect pin level. This bit reflects the inverse value of
> >>> the
> >> SDHC_CD pin for the card socket.
> >>> 0 No card present (SDHC_CD = 1)
> >>> 1 Card present (SDHC_CD = 0)
> >>>
> >>> So, this bit has the same effect as SDHCI_CARD_PRESENT[bit15], the
> >> difference is that debouncing is not performed on this bit.
> >>>
> >>> Freescale's controller supports the card detection, if card is
> >>> present,
> >> none-zero will be returned, otherwise, zero will be returned.
> >>>
> >>> You can see my other patch [3/4], I add one callback to detect the
> >>> card
> >> state in special platform: if the controller supports card detection,
> >> this callback will be performed in special platform (e.g. sdhci-of-
> >> esdhc.c) and return the card state (present or absent), if controller
> >> doesn't support card detection, this callback will be not performed
> >> and return -ENOSYS.
> >>
> >> OK, but the point is, the request can be stopped in sdhci_request().
> >> Can you just add your callback there?
> > Why can the request be stopped? Just because of card absent or
> SDHCI_DEVICE_DEAD?
> 
> Yes, both
> 
This function is to request command to the card, if callback is added here,
it just replaces the code:
present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
                                SDHCI_CARD_PRESENT;
When SDHCI_QUIRK_BROKEN_CARD_DETECTION option is valid or the card is always present,
This will affect the performance because the driver always ask the card preset state
When card is present.
So I think the best way is to detect the card before performing the mmc_send_status function.


