From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/41] mmc: host: omap_hsmmc: Remove incorrect voltage switch  sequence
Date: Fri, 19 May 2017 13:45:08 +0530
Message-ID: <20170519081541.26753-9-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:10304 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbdESIQ4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 04:16:56 -0400
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com

ios->vdd is set only in mmc_power_up and mmc_power_off and not in
mmc_select_voltage() as mentioned in the code comment. This seems to be
legacy code that has been carried for a long time without being
tested.

This will be replaced with the correct voltage switch sequence and
populated in start_signal_voltage_switch ops to be used by mmc core
for switching voltages.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 79 -------------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d47ef51fbe51..30cd2be7141c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1292,67 +1292,6 @@ static void set_sd_bus_power(struct omap_hsmmc_host *host)
 	}
 }
 
-/*
- * Switch MMC interface voltage ... only relevant for MMC1.
- *
- * MMC2 and MMC3 use fixed 1.8V levels, and maybe a transceiver.
- * The MMC2 transceiver controls are used instead of DAT4..DAT7.
- * Some chips, like eMMC ones, use internal transceivers.
- */
-static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
-{
-	u32 reg_val = 0;
-	int ret;
-
-	/* Disable the clocks */
-	if (host->dbclk)
-		clk_disable_unprepare(host->dbclk);
-
-	/* Turn the power off */
-	ret = omap_hsmmc_set_power(host, 0, 0);
-
-	/* Turn the power ON with given VDD 1.8 or 3.0v */
-	if (!ret)
-		ret = omap_hsmmc_set_power(host, 1, vdd);
-	if (host->dbclk)
-		clk_prepare_enable(host->dbclk);
-
-	if (ret != 0)
-		goto err;
-
-	OMAP_HSMMC_WRITE(host->base, HCTL,
-		OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
-	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
-
-	/*
-	 * If a MMC dual voltage card is detected, the set_ios fn calls
-	 * this fn with VDD bit set for 1.8V. Upon card removal from the
-	 * slot, omap_hsmmc_set_ios sets the VDD back to 3V on MMC_POWER_OFF.
-	 *
-	 * Cope with a bit of slop in the range ... per data sheets:
-	 *  - "1.8V" for vdds_mmc1/vdds_mmc1a can be up to 2.45V max,
-	 *    but recommended values are 1.71V to 1.89V
-	 *  - "3.0V" for vdds_mmc1/vdds_mmc1a can be up to 3.5V max,
-	 *    but recommended values are 2.7V to 3.3V
-	 *
-	 * Board setup code shouldn't permit anything very out-of-range.
-	 * TWL4030-family VMMC1 and VSIM regulators are fine (avoiding the
-	 * middle range) but VSIM can't power DAT4..DAT7 at more than 3V.
-	 */
-	if ((1 << vdd) <= MMC_VDD_23_24)
-		reg_val |= SDVS18;
-	else
-		reg_val |= SDVS30;
-
-	OMAP_HSMMC_WRITE(host->base, HCTL, reg_val);
-	set_sd_bus_power(host);
-
-	return 0;
-err:
-	dev_err(mmc_dev(host->mmc), "Unable to switch operating voltage\n");
-	return ret;
-}
-
 /* Protect the card while the cover is open */
 static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 {
@@ -1763,24 +1702,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	omap_hsmmc_set_bus_width(host);
 
-	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
-		/* Only MMC1 can interface at 3V without some flavor
-		 * of external transceiver; but they all handle 1.8V.
-		 */
-		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
-			(ios->vdd == DUAL_VOLT_OCR_BIT)) {
-				/*
-				 * The mmc_select_voltage fn of the core does
-				 * not seem to set the power_mode to
-				 * MMC_POWER_UP upon recalculating the voltage.
-				 * vdd 1.8v.
-				 */
-			if (omap_hsmmc_switch_opcond(host, ios->vdd) != 0)
-				dev_dbg(mmc_dev(host->mmc),
-						"Switch operation failed\n");
-		}
-	}
-
 	omap_hsmmc_set_clock(host);
 
 	if (ios->timing != host->timing) {
-- 
2.11.0

