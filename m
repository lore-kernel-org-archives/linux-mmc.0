From: "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH] mmc: Allow sdhci platform drivers to set quirks2 from
 platform data
Date: Tue, 30 Apr 2013 10:42:05 -0400
Message-ID: <1367332925-30671-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1905 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760050Ab3D3Omz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:42:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    4 +++-
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3145a78..e605509 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -149,8 +149,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
+	if (pdata) {
 		host->quirks = pdata->quirks;
+		host->quirks2 = pdata->quirks2;
+	}
 	host->irq = platform_get_irq(pdev, 0);
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 153b6c5..2940ee3 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -18,6 +18,7 @@
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
+	unsigned int quirks2;
 };
 
 struct sdhci_pltfm_host {
-- 
1.7.6


