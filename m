From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: add imx6sx support
Date: Wed, 27 May 2015 18:13:30 +0800
Message-ID: <1432721611-31214-6-git-send-email-aisheng.dong@freescale.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:39973
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751796AbbE0KOr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 May 2015 06:14:47 -0400
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, b51421@freescale.com, linux-arm-kernel@lists.infradead.org

From: Dong Aisheng <b29396@freescale.com>

The imx6sx usdhc is derived from imx6sl, the difference is minor.
imx6sx have the errata ESDHC_FLAG_ERR004536 fixed.
So introduce a new compatible string for imx6sx to distinguish them.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a3b82d1..bcb5673 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -148,6 +148,11 @@ static struct esdhc_soc_data usdhc_imx6sl_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
 };
 
+static struct esdhc_soc_data usdhc_imx6sx_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -188,6 +193,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
+	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
 	{ /* sentinel */ }
-- 
1.9.1

