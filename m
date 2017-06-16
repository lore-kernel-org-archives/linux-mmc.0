From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/16] mmc: host: omap_hsmmc: Add new compatible string to support dra7
Date: Fri, 16 Jun 2017 18:15:38 +0530
Message-ID: <20170616124544.15046-11-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a new compatible string "ti,dra7-hsmmc" to support
dra7 and dra72 controllers. Also create a new controller flag
"OMAP_HSMMC_REQUIRE_IODELAY" to specify all controllers that use
"ti,dra7-hsmmc" require iodealy configuration to be set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  1 +
 drivers/mmc/host/omap_hsmmc.c                           | 10 ++++++++++
 include/linux/platform_data/hsmmc-omap.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 74166a0d460d..258e25af10f7 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -12,6 +12,7 @@ Required properties:
  Should be "ti,omap3-hsmmc", for OMAP3 controllers
  Should be "ti,omap3-pre-es3-hsmmc" for OMAP3 controllers pre ES3.0
  Should be "ti,omap4-hsmmc", for OMAP4 controllers
+ Should be "ti,dra7-hsmmc", for dra7 and dra72 controllers
  Should be "ti,am33xx-hsmmc", for AM335x controllers
 - ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d797224152ac..9d59fe611498 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2302,6 +2302,12 @@ static const struct omap_mmc_of_data am33xx_mmc_of_data = {
 	.controller_flags = OMAP_HSMMC_SWAKEUP_MISSING,
 };
 
+static const struct omap_mmc_of_data dra7_mmc_of_data = {
+	.reg_offset = 0x100,
+	.controller_flags = OMAP_HSMMC_SWAKEUP_MISSING |
+			    OMAP_HSMMC_REQUIRE_IODELAY,
+};
+
 static const struct of_device_id omap_mmc_of_match[] = {
 	{
 		.compatible = "ti,omap2-hsmmc",
@@ -2321,6 +2327,10 @@ static const struct of_device_id omap_mmc_of_match[] = {
 		.compatible = "ti,am33xx-hsmmc",
 		.data = &am33xx_mmc_of_data,
 	},
+	{
+		.compatible = "ti,dra7-hsmmc",
+		.data = &dra7_mmc_of_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 67bded22eae4..8e771851e07a 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -27,6 +27,7 @@
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
 #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
+#define OMAP_HSMMC_REQUIRE_IODELAY		BIT(3)
 
 struct omap_hsmmc_dev_attr {
 	u8 flags;
-- 
2.11.0
