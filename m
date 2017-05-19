From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 11/41] mmc: host: omap_hsmmc: Add new compatible string to support dra7
Date: Fri, 19 May 2017 13:45:11 +0530
Message-ID: <20170519081541.26753-12-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a new compatible string "ti,dra7-hsmmc" to support
dra7 and dra72 controllers. Also create a new controller flag
"OMAP_HSMMC_REQUIRE_IODELAY" to specify all controllers that use
"ti,dra7-hsmmc" require iodealy configuration to be set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
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
index 7088a88074a8..8114b8b73491 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2314,6 +2314,12 @@ static const struct omap_mmc_of_data am33xx_mmc_of_data = {
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
@@ -2333,6 +2339,10 @@ static const struct of_device_id omap_mmc_of_match[] = {
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
index 8e981be2e2c2..21832a357654 100644
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
