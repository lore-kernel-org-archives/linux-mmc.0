From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH 1/4] mmc: Add quirk to disable SDR50 mode
Date: Thu, 5 Nov 2015 17:39:57 -0500
Message-ID: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:6216 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbbKEXF1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 18:05:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Add quirk to disable SDR50 mode for controllers/boards that have
problems with this mode.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b48565e..71067c7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3176,6 +3176,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
+	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_SDR50)
+		mmc->caps &= ~MMC_CAP_UHS_SDR50;
+
 	if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
 	    (caps[1] & SDHCI_SUPPORT_HS400))
 		mmc->caps2 |= MMC_CAP2_HS400;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9d4aa31..0941c94 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -412,6 +412,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Controller does not support SDR50 */
+#define SDHCI_QUIRK2_BROKEN_SDR50			(1<<16)
 /*
  * When internal clock is disabled, a delay is needed before modifying the
  * SD clock frequency or enabling back the internal clock.
-- 
1.9.0.138.g2de3478

