From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] mmc: meson-gx: introduce struct meson_tuning_params
Date: Tue, 4 Apr 2017 21:03:22 +0200
Message-ID: <f48de131-09fd-9656-e71f-de9cfe1e1a5c@gmail.com>
References: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36162 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbdDDTL1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2017 15:11:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so7505710wmf.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2017 12:11:26 -0700 (PDT)
In-Reply-To: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Introduce struct meson_tuning_params for storing the clock phase
configurations. There's no functional change because tx and rx
clock phase were implicitely set to CLK_PHASE_0 before.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 0036680b..3a6e51c8 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -49,6 +49,8 @@
 #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
 #define   CLK_SRC_PLL_RATE 1000000000
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
+#define   CLK_TX_PHASE_MASK GENMASK(11, 10)
+#define   CLK_RX_PHASE_MASK GENMASK(13, 12)
 #define   CLK_PHASE_0 0
 #define   CLK_PHASE_90 1
 #define   CLK_PHASE_180 2
@@ -111,6 +113,12 @@
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define MUX_CLK_NUM_PARENTS 2
 
+struct meson_tuning_params {
+	u8 core_phase;
+	u8 tx_phase;
+	u8 rx_phase;
+};
+
 struct meson_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
@@ -130,6 +138,7 @@ struct meson_host {
 	void *bounce_buf;
 	dma_addr_t bounce_dma_addr;
 
+	struct meson_tuning_params tp;
 	bool vqmmc_enabled;
 };
 
@@ -312,7 +321,9 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
+	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
+	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
 	clk_reg |= FIELD_PREP(CLK_SRC_MASK, CLK_SRC_XTAL);
 	clk_reg |= FIELD_PREP(CLK_DIV_MASK, CLK_DIV_MAX);
 	clk_reg &= ~CLK_ALWAYS_ON;
@@ -757,6 +768,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	host->tp.core_phase = CLK_PHASE_180;
+	host->tp.tx_phase = CLK_PHASE_0;
+	host->tp.rx_phase = CLK_PHASE_0;
+
 	ret = meson_mmc_clk_init(host);
 	if (ret)
 		goto err_core_clk;
-- 
2.12.1


