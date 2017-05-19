From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 38/41] ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM
Date: Fri, 19 May 2017 13:45:38 +0530
Message-ID: <20170519081541.26753-39-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

DRA74x EVM Rev H EVM comes with revision 2.0 silicon.
However, earlier versions of EVM can come with either
revision 1.1 or revision 1.0 of silicon.

The device-tree file is written to support rev 2.0 of
silicon. pdata quirks are used to then override the
settings needed for PG 1.1 silicon.

PG 1.1 silicon has limitations w.r.t frequencies at
which MMC1/2/3 can operate as well as different IOdelay
numbers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9700a8ef0f16..6b433fce65a5 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -434,6 +434,26 @@ static void __init omap5_uevm_legacy_init(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc1;
+static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc2;
+static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc3;
+
+static void __init dra7x_evm_mmc_quirk(void)
+{
+	if (omap_rev() == DRA752_REV_ES1_1 || omap_rev() == DRA752_REV_ES1_0) {
+		dra7_hsmmc_data_mmc1.version = "rev11";
+		dra7_hsmmc_data_mmc1.max_freq = 96000000;
+
+		dra7_hsmmc_data_mmc2.version = "rev11";
+		dra7_hsmmc_data_mmc2.max_freq = 48000000;
+
+		dra7_hsmmc_data_mmc3.version = "rev11";
+		dra7_hsmmc_data_mmc3.max_freq = 48000000;
+	}
+}
+#endif
+
 static struct pcs_pdata pcs_pdata;
 
 void omap_pcs_legacy_init(int irq, void (*rearm)(void))
@@ -561,6 +581,14 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
 		       &omap4_iommu_pdata),
 #endif
+#ifdef CONFIG_SOC_DRA7XX
+	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x4809c000, "4809c000.mmc",
+		       &dra7_hsmmc_data_mmc1),
+	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480b4000, "480b4000.mmc",
+		       &dra7_hsmmc_data_mmc2),
+	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480ad000, "480ad000.mmc",
+		       &dra7_hsmmc_data_mmc3),
+#endif
 	/* Common auxdata */
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
 	{ /* sentinel */ },
@@ -590,6 +618,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
 #endif
+#ifdef CONFIG_SOC_DRA7XX
+	{ "ti,dra7-evm", dra7x_evm_mmc_quirk, },
+#endif
 	{ /* sentinel */ },
 };
 
-- 
2.11.0
