From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH] mmc: dw_mmc: remove unnecessary debug message
Date: Tue, 23 Dec 2014 21:07:33 +0900
Message-ID: <1419336453-6411-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58789 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaLWMHg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Dec 2014 07:07:36 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NH1006JJB0MYA70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Dec 2014 21:07:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Beomho Seo <beomho.seo@samsung.com>

This patch remove unnecessary 'out of memory' message on dw mmc driver.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    4 +---
 drivers/mmc/host/dw_mmc.c        |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index f936704..74eb081 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -230,10 +230,8 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	int ret;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(host->dev, "mem alloc failed for private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
 		if (of_device_is_compatible(np, exynos_compat[idx].compatible))
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a1b80e5..6e4d864 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2546,10 +2546,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	u32 clock_frequency;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "could not allocate memory for pdata\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/* find out number of slots supported */
 	if (of_property_read_u32(dev->of_node, "num-slots",
-- 
1.7.9.5

