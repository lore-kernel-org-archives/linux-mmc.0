From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 06/22] mmc: dw_mmc: socfpga: move socfpga private init
Date: Sat, 31 Aug 2013 00:12:10 +0900
Message-ID: <000901cea593$4ce8e4f0$e6baaed0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20179 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3H3PMM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:12:12 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00HHGNKBWSA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:12:11 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>

Currently platform specific private data initialization is done by
dw_mci_socfpga_priv_init and dw_mci_socfpga_parse_dt. As we already have
separate platform specific device tree parser dw_mci_socfpga_parse_dt,
move the dw_mci_socfpga_priv_init code to dw_mci_socfpga_parse_dt.
We can use the dw_mci_socfpga_priv_init to do some actual platform
specific initialization.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-socfpga.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..4d7b999 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -38,21 +38,6 @@ struct dw_mci_socfpga_priv_data {
 
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
-
 	return 0;
 }
 
@@ -79,12 +64,24 @@ static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
 
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
@@ -96,6 +93,7 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 		return ret;
 
 	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
+	host->priv = priv;
 	return 0;
 }
 
-- 
1.7.0.4


