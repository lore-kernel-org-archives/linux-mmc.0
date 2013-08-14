From: <dinguyen@altera.com>
Subject: [PATCHv4 3/3] mmc: dw_mmc: Use phandle to get SDR timing values from sys-mgr
Date: Wed, 14 Aug 2013 11:48:04 -0500
Message-ID: <1376498884-9199-3-git-send-email-dinguyen@altera.com>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:1692 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932831Ab3HNQsf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Aug 2013 12:48:35 -0400
In-Reply-To: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update the driver to get the system manager node from a phandle. Also, the
driver can get the correct clock value from the common clock API, thus the
"altr,dw-mshc-ciu-div" binding is not needed at all.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/mmc/host/dw_mmc-socfpga.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..73b4440 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -31,7 +31,6 @@
 
 /* SOCFPGA implementation specific driver private data */
 struct dw_mci_socfpga_priv_data {
-	u8	ciu_div; /* card interface unit divisor */
 	u32	hs_timing; /* bitmask for CIU clock phase shift */
 	struct regmap   *sysreg; /* regmap for system manager register */
 };
@@ -39,6 +38,7 @@ struct dw_mci_socfpga_priv_data {
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_socfpga_priv_data *priv;
+	struct device_node *np = host->dev->of_node;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -46,9 +46,9 @@ static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 		return -ENOMEM;
 	}
 
-	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+	priv->sysreg = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr");
 	if (IS_ERR(priv->sysreg)) {
-		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
+		dev_err(host->dev, "No sysmgr phandle specified!\n");
 		return PTR_ERR(priv->sysreg);
 	}
 	host->priv = priv;
@@ -64,8 +64,6 @@ static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
 	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
 		priv->hs_timing);
 	clk_prepare_enable(host->ciu_clk);
-
-	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
@@ -82,14 +80,8 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
-	u32 div = 0;
 	int ret;
 
-	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
-	if (ret)
-		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
-	priv->ciu_div = div;
-
 	ret = of_property_read_u32_array(np,
 			"altr,dw-mshc-sdr-timing", timing, 2);
 	if (ret)
-- 
1.7.9.5


