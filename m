From: <dinguyen@altera.com>
Subject: [PATCHv6 1/5] mmc: dw_mmc: Add support to set the SDR and DDR timing through clock framework
Date: Thu, 12 Dec 2013 14:30:41 -0600
Message-ID: <1386880245-10192-2-git-send-email-dinguyen@altera.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:2293 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751840Ab3LLVG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2013 16:06:56 -0500
In-Reply-To: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

All implementations of the Synopsys DW SD/MMC IP have settings to control
the phase shift of the CIU clk. These phase shift settings are necessary for
the SD/MMC to correctly clock the card. All variants of the dw_mmc will need
these settings, but how they are implemented can vastly vary.

This patch enables the setting for the SDR and/or DDR settings through the
common clock framework.

Depends on the patch "mmc: dw_mmc: Enable the hold reg for certain speed modes",
that is already reading the "samsung,dw-mshc-sdr-timing" and
"samsung,dw-mshc-ddr-timing" bindings, this patch saves those values into a
u32 bitmask that can be passed to the clock framework to use.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v6: Add this patch
v5: none
v4: none
v3: none
v2: none
---
 drivers/mmc/host/dw_mmc.c  |   23 +++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h |    6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 480dafe..1fb5cff 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2431,6 +2431,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if ((sdr_timing[1] == 0) || (ddr_timing[1] == 0))
 		pdata->cclk_in_drv = 0;
 
+	pdata->sdr_timing = (sdr_timing[1] | (sdr_timing[0] << 4));
+	pdata->ddr_timing = (ddr_timing[1] | (ddr_timing[0] << 4));
 	return pdata;
 }
 
@@ -2478,6 +2480,27 @@ int dw_mci_probe(struct dw_mci *host)
 		dev_dbg(host->dev, "ciu clock not available\n");
 		host->bus_hz = host->pdata->bus_hz;
 	} else {
+		/* If the CIU clk is available, we check for SDR and DDR
+		 * timing phase shift settings. But not all platforms
+		 * may have populated these settings, the driver will not fail
+		 * if these settings are not specified.
+		 */
+		if (host->pdata->sdr_timing) {
+			host->sdr_clk = devm_clk_get(host->dev, "sdr_mmc_clk");
+			if (IS_ERR(host->sdr_clk))
+				dev_dbg(host->dev, "sdr_mmc clock not available\n");
+			else
+				clk_set_rate(host->sdr_clk, host->pdata->sdr_timing);
+		}
+
+		if (host->pdata->ddr_timing) {
+			host->ddr_clk = devm_clk_get(host->dev, "ddr_mmc_clk");
+			if (IS_ERR(host->ddr_clk))
+				dev_dbg(host->dev, "ddr_mmc clock not available\n");
+			else
+				clk_set_rate(host->ddr_clk, host->pdata->ddr_timing);
+		}
+
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
 			dev_err(host->dev, "failed to enable ciu clock\n");
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 2b5b8bf..ad90ad1 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -83,6 +83,8 @@ struct mmc_data;
  * @priv: Implementation defined private data.
  * @biu_clk: Pointer to bus interface unit clock instance.
  * @ciu_clk: Pointer to card interface unit clock instance.
+ * @sdr_clk: Pointer to the SDR clock instance.
+ * @ddr_clk: Pointer to the DDR clock instance.
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @data_shift: log2 of FIFO item size.
@@ -170,6 +172,8 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
+	struct clk		*sdr_clk;
+	struct clk		*ddr_clk;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
 
 	/* FIFO push and pull */
@@ -241,6 +245,8 @@ struct dw_mci_board {
 	u32 caps2;	/* More capabilities */
 	u32 pm_caps;	/* PM capabilities */
 	u32 cclk_in_drv;	/*cclk_in_drv phase shift */
+	u32 sdr_timing;	/* Single data rate timing setting. */
+	u32 ddr_timing;	/* Double data rate timing setting. */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
1.7.9.5


