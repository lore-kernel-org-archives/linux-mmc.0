From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V3 2/4] mmc: dw_mmc: socfpga: move socfpga private init
Date: Wed, 28 Aug 2013 17:38:49 +0530
Message-ID: <1377691731-7226-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33844 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab3H1MJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2013 08:09:20 -0400
In-Reply-To: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Currently platform specific private data initialisation is done by
dw_mci_socfpga_priv_init and dw_mci_socfpga_parse_dt.As we already have
separate platform specific device tree parser dw_mci_socfpga_parse_dt,
move the dw_mci_socfpga_priv_init code to dw_mci_socfpga_parse_dt.
We can use the dw_mci_socfpga_priv_init to do some actual platform
specific initialisation.

This patch is compile tested only.

changes since V2: none

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-socfpga.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..953f260 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -38,20 +38,6 @@ struct dw_mci_socfpga_priv_data {
 
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 {
-	struct dw_mci_socfpga_priv_data *priv;
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(host->dev, "mem alloc failed for private data\n");
-		return -ENOMEM;
-	}
-
-	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-	if (IS_ERR(priv->sysreg)) {
-		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
-		return PTR_ERR(priv->sysreg);
-	}
-	host->priv = priv;
 
 	return 0;
 }
@@ -79,12 +65,24 @@ static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
 
 static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 {
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
+	struct dw_mci_socfpga_priv_data *priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
 	u32 div = 0;
 	int ret;
 
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(host->dev, "mem alloc failed for private data\n");
+		return -ENOMEM;
+	}
+
+	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+	if (IS_ERR(priv->sysreg)) {
+		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
+		return PTR_ERR(priv->sysreg);
+	}
+
 	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
 	if (ret)
 		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
@@ -96,6 +94,7 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 		return ret;
 
 	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
+	host->priv = priv;
 	return 0;
 }
 
-- 
1.7.9.5

