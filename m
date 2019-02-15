From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 8/8] mmc: sdhci-omap: Add am335x and am437x specific compatibles
Date: Sat, 16 Feb 2019 00:50:33 +0530
Message-ID: <20190215192033.24203-9-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add support for new compatible for TI's am335x and am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index ae9701d198d5..2e246b5b744c 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -861,6 +861,14 @@ static const struct sdhci_omap_data k2g_data = {
 	.offset = 0x200,
 };
 
+static const struct sdhci_omap_data am335_data = {
+	.offset = 0x200,
+};
+
+static const struct sdhci_omap_data am437_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -869,6 +877,8 @@ static const struct sdhci_omap_data dra7_data = {
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
 	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
+	{ .compatible = "ti,am335-sdhci", .data = &am335_data },
+	{ .compatible = "ti,am437-sdhci", .data = &am437_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
-- 
2.19.2
