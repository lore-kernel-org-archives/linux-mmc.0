From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 1/2] mmc: dw_mmc: exynos: Add a new compatible string for exynos5420
Date: Fri, 24 May 2013 15:34:32 +0530
Message-ID: <1369389873-15018-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53741 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760009Ab3EXKFP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 06:05:15 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so4139474pac.14
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2013 03:05:14 -0700 (PDT)
In-Reply-To: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, thomas.ab@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>

The Exynos5420 has a DWMMC controller which is different from prior
versions.This patch adds a new compatible string for Exynos5420.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index f013e7e..f883b17 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -41,6 +41,7 @@ enum dw_mci_exynos_type {
 	DW_MCI_TYPE_EXYNOS4210,
 	DW_MCI_TYPE_EXYNOS4412,
 	DW_MCI_TYPE_EXYNOS5250,
+	DW_MCI_TYPE_EXYNOS5420,
 };
 
 /* Exynos implementation specific driver private data */
@@ -64,6 +65,9 @@ static struct dw_mci_exynos_compatible {
 	}, {
 		.compatible	= "samsung,exynos5250-dw-mshc",
 		.ctrl_type	= DW_MCI_TYPE_EXYNOS5250,
+	}, {
+		.compatible	= "samsung,exynos5420-dw-mshc",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS5420,
 	},
 };
 
@@ -92,7 +96,8 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
-	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420)
 		host->bus_hz /= (priv->ciu_div + 1);
 	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
 		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
@@ -175,6 +180,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
 			.data = &exynos_drv_data, },
 	{ .compatible = "samsung,exynos5250-dw-mshc",
 			.data = &exynos_drv_data, },
+	{ .compatible = "samsung,exynos5420-dw-mshc",
+			.data = &exynos_drv_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
-- 
1.7.9.5

