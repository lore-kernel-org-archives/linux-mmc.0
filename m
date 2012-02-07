From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci: add quirk for keeping card power during suspend
Date: Tue,  7 Feb 2012 14:48:54 +0200
Message-ID: <1328618935-25175-4-git-send-email-adrian.hunter@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2BGMs6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 07:48:58 -0500
In-Reply-To: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add quirk SDHCI_QUIRK2_HOST_OFF_CARD_ON to cater for the
case when the card keeps power during suspend but the
host controller does not i.e. the card power is not
controlled by the host controller.  In that case, the
controller must be fully reset on resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  |   13 +++++++++++--
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1f5888b..80cc784 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2426,8 +2426,17 @@ int sdhci_resume_host(struct sdhci_host *host)
 	if (ret)
 		return ret;
 
-	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
-	mmiowb();
+	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
+	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
+		/* Card keeps power but host controller does not */
+		sdhci_init(host, 0);
+		host->pwr = 0;
+		host->clock = 0;
+		sdhci_do_set_ios(host, &host->mmc->ios);
+	} else {
+		sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
+		mmiowb();
+	}
 
 	ret = mmc_resume_host(host->mmc);
 	sdhci_enable_card_detection(host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index c750f85..e9051e1 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -90,6 +90,8 @@ struct sdhci_host {
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
+#define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
+
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.7.6.4

