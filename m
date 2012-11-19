From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 4/7] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Mon, 19 Nov 2012 21:59:58 +0530
Message-ID: <1353342601-15210-4-git-send-email-svenkatr@ti.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39601 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab2KSQao (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Nov 2012 11:30:44 -0500
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Venkatraman S <svenkatr@ti.com>

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

HSMMC IP on AM33xx need a special setting to handle High-speed cards.
Other platforms like TI81xx, OMAP4 may need this as-well. This depends
on the HSMMC IP timing closure done for the high speed cards.

>From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)

The MMC/SD/SDIO output signals can be driven on either falling edge or
rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
to reach better timing performance, and thus to increase data transfer
frequency.

There are few pre-requisites for enabling the HSPE bit
- Controller should support High-Speed-Enable Bit and
- Controller should not be using DDR Mode and
- Controller should advertise that it supports High Speed in
  capabilities register and
- MMC/SD clock coming out of controller > 25MHz

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  1 +
 arch/arm/plat-omap/include/plat/mmc.h              |  1 +
 drivers/mmc/host/omap_hsmmc.c                      | 30 +++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index be76a23..ed271fc 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -19,6 +19,7 @@ ti,dual-volt: boolean, supports dual voltage cards
 "supply-name" examples are "vmmc", "vmmc_aux" etc
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
+ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
 
 Example:
 	mmc1: mmc@0x4809c000 {
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 8b4e4f2..346af5b 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -126,6 +126,7 @@ struct omap_mmc_platform_data {
 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
 #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
+#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
 		unsigned features;
 
 		int switch_pin;			/* gpio (card detect) */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 571cd80..18d3f19 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -63,6 +63,7 @@
 
 #define VS18			(1 << 26)
 #define VS30			(1 << 25)
+#define HSS			(1 << 21)
 #define SDVS18			(0x5 << 9)
 #define SDVS30			(0x6 << 9)
 #define SDVS33			(0x7 << 9)
@@ -90,6 +91,7 @@
 #define MSBS			(1 << 5)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
+#define HSPE			(1 << 2)
 #define DDR			(1 << 19)
 #define DW8			(1 << 5)
 #define CC			0x1
@@ -495,6 +497,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	struct mmc_ios *ios = &host->mmc->ios;
 	unsigned long regval;
 	unsigned long timeout;
+	unsigned long clkdiv;
 
 	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
 
@@ -502,7 +505,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 
 	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
 	regval = regval & ~(CLKD_MASK | DTO_MASK);
-	regval = regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
+	clkdiv = calc_divisor(host, ios);
+	regval = regval | (clkdiv << 6) | (DTO << 16);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
@@ -513,6 +517,27 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		cpu_relax();
 
+	/*
+	 * Enable High-Speed Support
+	 * Pre-Requisites
+	 *	- Controller should support High-Speed-Enable Bit
+	 *	- Controller should not be using DDR Mode
+	 *	- Controller should advertise that it supports High Speed
+	 *	  in capabilities register
+	 *	- MMC/SD clock coming out of controller > 25MHz
+	 */
+	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
+	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
+	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
+		regval = OMAP_HSMMC_READ(host->base, HCTL);
+		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
+			regval |= HSPE;
+		else
+			regval &= ~HSPE;
+
+		OMAP_HSMMC_WRITE(host->base, HCTL, regval);
+	}
+
 	omap_hsmmc_start_clock(host);
 }
 
@@ -1715,6 +1740,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (!of_property_read_u32(np, "max-frequency", &max_freq))
 		pdata->max_freq = max_freq;
 
+	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
+		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
+
 	return pdata;
 }
 #else
-- 
1.8.0

