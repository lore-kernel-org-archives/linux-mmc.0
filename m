From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc: add a new quirk for NONREMOVABLE_CARD useful for sdhci-pltfm
Date: Wed,  4 May 2011 12:48:09 +0200
Message-ID: <1304506089-3862-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:60275 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888Ab1EDKsa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 06:48:30 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14C8915B
	for <linux-mmc@vger.kernel.org>; Wed,  4 May 2011 10:48:24 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4EAC1FB3
	for <linux-mmc@vger.kernel.org>; Wed,  4 May 2011 10:48:24 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

STM platforms use the sdhci-pltfm.c driver but, IMO
there are some problems when use the eMMC card.

  --- from sdhci.c file:

1897        if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
1898             mmc_card_is_removable(mmc))
1899                 mmc->caps |= MMC_CAP_NEEDS_POLL;

[snip]

          sdhci_set_card_detection
                |_ if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
                              return;

         sdhci_request
                 |_ /* If polling, assume that the card is always present. */

  ---

Passing the SDHCI_QUIRK_BROKEN_CARD_DETECTION as quirk
from my platform, IIUC, that guarantees that the card is actually
considered always present by the HC but the MMC_CAP_NONREMOVABLE is not set.

In fact some sdhci drivers based, to manage eMMC, actually do:

if (pdata-><own_field> == <OWN_PLATF>_PERMANET) {
     host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
     host->mmc->caps = MMC_CAP_NONREMOVABLE;
}

I need to do the same in the sdhci-pltfm for properly and logically use the
eMMC.

Moreover setting the SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
if we have a board with an eMMC (really plugged on) we skip,
in the sdhci_set_card_detection, the check of the card.
This works but it's logically broken and could create problems
on a board that has no eMMC soldered on the PCB yet.
Hmm, this is a limit case indeed. :-) but somebody followed in
this problem asking support for.

So a new quirk, called SDHCI_QUIRK_NONREMOVABLE_CARD, has been added.

This can be passed from the platform and managed in the sdhci to
directly set MMC_CAP_NONREMOVABLE.

To summarise:

o The meaning of SDHCI_QUIRK_BROKEN_CARD_DETECTION is:
	Card detection is broken but if there is a removal card
	(MMC_CAP_NEEDS_POLL is set) the sdhci considers it
	present. If there is an eMMC do not needs poll and
	the HC consider it as present too (really bad HW).

o The SDHCI_QUIRK_NONREMOVABLE_CARD meaning is:
      we have the eMMC and set the MMC_CAP_NONREMOVABLE caps
      and the sdhci has to verify if it is present otherwise
      can fail.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c  |    3 +++
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..650ea97 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1894,6 +1894,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
+	if (host->quirks & SDHCI_QUIRK_NONREMOVABLE_CARD)
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
+
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
 	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..370258c 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -85,6 +85,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+/* Controller has to treat an eMMC card */
+#define SDHCI_QUIRK_NONREMOVABLE_CARD			(1<<31)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.4.4

