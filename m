From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next] mmc: renesas-sdhi: provide a whitelist for Gen3 SoC ES versions
Date: Wed,  2 Aug 2017 14:48:42 +0200
Message-ID: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Provide a whitelist for Gen3 SoC ES versions for both the SYS DMAC and
internal DMAC variants of the SDHI driver.  This is to allow drivers to
only initialise for Gen3 SoC ES versions for which they are the appropriate
DMAC implementation.  Currently internal DMAC is the appropriate
implementation for all supported Gen3 SoC ES versions.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index a26c6ed8e029..6717003888e2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
+#include <linux/sys_soc.h>
 
 #include "renesas_sdhi.h"
 #include "tmio_mmc.h"
@@ -241,8 +242,22 @@ static struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
 	.dataend = renesas_sdhi_internal_dmac_dataend_dma,
 };
 
+/*
+ * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
+ * implementation as others may use a different implementation.
+ */
+static const struct soc_device_attribute gen3_soc_whitelist[] = {
+        { .soc_id = "r8a7795", .revision = "ES1.*" },
+        { .soc_id = "r8a7795", .revision = "ES2.0" },
+        { .soc_id = "r8a7796", .revision = "ES1.0" },
+        { /* sentinel */ }
+};
+
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 {
+	if (!soc_device_match(gen3_soc_whitelist))
+		return -ENODEV;
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
 }
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index b6789f5197b3..718cb8a9d2ce 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -18,8 +18,10 @@
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
+#include <linux/sys_soc.h>
 
 #include "renesas_sdhi.h"
 #include "tmio_mmc.h"
@@ -459,8 +461,21 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.dataend = renesas_sdhi_sys_dmac_dataend_dma,
 };
 
+/*
+ * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
+ * implementation. Currently empty as all supported ES versions use
+ * the internal DMAC.
+ */
+static const struct soc_device_attribute gen3_soc_whitelist[] = {
+        { /* sentinel */ }
+};
+
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 {
+	if (of_device_get_match_data(&pdev->dev) == &of_rcar_gen3_compatible &&
+	    !soc_device_match(gen3_soc_whitelist))
+		return -ENODEV;
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops);
 }
 
-- 
2.1.4
