From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 14/16] mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
Date: Mon, 5 Feb 2018 18:20:27 +0530
Message-ID: <20180205125029.21570-15-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:11999 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeBEMv5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Feb 2018 07:51:57 -0500
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for the new compatible added specifically to support
k2g's MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index db487b77fbcc..863f6736c2fe 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -719,6 +719,10 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.ops = &sdhci_omap_ops,
 };
 
+static const struct sdhci_omap_data k2g_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -726,6 +730,7 @@ static const struct sdhci_omap_data dra7_data = {
 
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
+	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
@@ -846,6 +851,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	int ret;
 	u32 offset;
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_omap_host *omap_host;
@@ -872,6 +878,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 	}
 
+	if (of_device_is_compatible(node, "ti,k2g-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+
 	pltfm_host = sdhci_priv(host);
 	omap_host = sdhci_pltfm_priv(pltfm_host);
 	omap_host->host = host;
-- 
2.11.0

