From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 11/14] mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
Date: Fri, 27 Apr 2018 17:17:20 +0530
Message-ID: <20180427114723.2687-12-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add support for the new compatible added specifically to support
k2g's MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 2232a9974b21..b11c846dd8a1 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -720,6 +720,10 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.ops = &sdhci_omap_ops,
 };
 
+static const struct sdhci_omap_data k2g_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -727,6 +731,7 @@ static const struct sdhci_omap_data dra7_data = {
 
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
+	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
-- 
2.17.0
