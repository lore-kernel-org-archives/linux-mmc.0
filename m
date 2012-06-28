From: philipspatches@gmail.com
Subject: [PATCH] sdhci: V2:  Allow CAPS[1] to be set via QUIRK
Date: Wed, 27 Jun 2012 21:15:45 -0700
Message-ID: <1340856945-1604-1-git-send-email-prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48269 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2F1EPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jun 2012 00:15:52 -0400
Received: by pbbrp8 with SMTP id rp8so2455256pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jun 2012 21:15:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

currently only the capability_0 register can be set if
SDHCI_QUIRK_MISSING_CAPS is defined.  This is a problem when
the capability_1 register also needs changing.  Use the
SDHCI_QUIRK_MISSING_CAPS to allow both registers to be set.

Redefining caps[1] is useful when the board design does not
support 1.8v vccq so UHS modes are not available.  The code
that calls sdhci_add_host can then detect this condition and
adjust the caps so the UHS mode will not be attempted on UHS
cards

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |    8 ++++++--
 include/linux/mmc/sdhci.h |    3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ef4231a..f46293d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2618,8 +2618,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
 
-	caps[1] = (host->version >= SDHCI_SPEC_300) ?
-		sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
+	if (host->version >= SDHCI_SPEC_300)
+		caps[1] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ?
+			host->caps1 :
+			sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	else
+		caps[1] = 0;
 
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e9051e1..d989b51 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -155,7 +155,8 @@ struct sdhci_host {
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-	unsigned int caps;	/* Alternative capabilities */
+	unsigned int caps;	/* Alternative CAPABILITY_0 */
+	unsigned int caps1;	/* Alternative CAPABILITY_1 */
 
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
-- 
1.7.0.4

