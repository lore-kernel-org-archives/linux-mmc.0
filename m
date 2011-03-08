From: grundler@google.com (Grant Grundler)
Subject: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Tue,  8 Mar 2011 13:39:20 -0800 (PST)
Message-ID: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:16728 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756761Ab1CHVj1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 16:39:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org


Save and restore SDHCI interrupt mask during suspend/resume.
Enables ARM Tegra2 board to suspend/resume.

Signed-off-by: Venkat Rao <vrao@broadcom.com>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
---
 drivers/mmc/host/sdhci.c  |    5 +++++
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3c6358f..68d2e36 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 	if (mmc->card && (mmc->card->type != MMC_TYPE_SDIO))
 		ret = mmc_suspend_host(host->mmc);
 
+	/* Save the original intmask to restore later */
+	host->save_intmask = sdhci_readl(host, SDHCI_INT_ENABLE);
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 
 	if (host->vmmc)
@@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
+	/* Restore the original intmask */
+	sdhci_unmask_irqs(host, host->save_intmask);
+
 	return ret;
 }
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dfb2106..5b9f6db 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -141,6 +141,8 @@ struct sdhci_host {
 
 	unsigned int caps;	/* Alternative capabilities */
 
+	unsigned int save_intmask;    /* Store original intmask */
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
-- 
1.7.2.3

