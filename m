From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 3/9] mmc: meson-gx: improve meson_mmc_clk_set
Date: Tue, 7 Feb 2017 22:34:32 +0100
Message-ID: <34ea9c0b-a39c-93ac-a626-d07e45fe4ab2@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35893 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbdBGVpL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:45:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id k90so6678415wrc.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:45:10 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The following changes are quite small, therefore I combined them in
one patch.

- ret doesn't need to be initialized with 0
- use standard !clk_rate notation to check for a zero value
- If clk_rate is zero we return here. Therefore all further checks
  in this function for clk_rate != 0 are not needed.
- switch from dev_warn to dev_err if the clock can't be set
- If due to clock source and available divider values the requested
  frequency isn't matched exactly (always the case if requested
  frequency is 52 MHz), then just print the differing values as
  debug message and not as warning.
- Also remove ret from the message as it is always 0.
- Set member current_clock to the current requested rate and
  mmc->actual_clock to the current actual rate

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- Introduce member current_clock to store the current requested rate
- Use mmc->actual_clock to store the actual rate
---
 drivers/mmc/host/meson-gx-mmc.c | 42 +++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 9d79df7c..d6a4dfae 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -132,6 +132,7 @@ struct meson_host {
 	struct clk_mux mux;
 	struct clk *mux_clk;
 	struct clk *mux_parent[MUX_CLK_NUM_PARENTS];
+	unsigned long current_clock;
 
 	struct clk_divider cfg_div;
 	struct clk *cfg_div_clk;
@@ -178,7 +179,7 @@ struct sd_emmc_desc {
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
-	int ret = 0;
+	int ret;
 	u32 cfg;
 
 	if (clk_rate) {
@@ -188,7 +189,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 			clk_rate = mmc->f_min;
 	}
 
-	if (clk_rate == mmc->actual_clock)
+	if (clk_rate == host->current_clock)
 		return 0;
 
 	/* stop clock */
@@ -201,29 +202,34 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 	dev_dbg(host->dev, "change clock rate %u -> %lu\n",
 		mmc->actual_clock, clk_rate);
 
-	if (clk_rate == 0) {
+	if (!clk_rate) {
 		mmc->actual_clock = 0;
+		host->current_clock = 0;
+		/* return with clock being stopped */
 		return 0;
 	}
 
 	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
-	if (ret)
-		dev_warn(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
-			 clk_rate, ret);
-	else if (clk_rate && clk_rate != clk_get_rate(host->cfg_div_clk))
-		dev_warn(host->dev, "divider requested rate %lu != actual rate %lu: ret=%d\n",
-			 clk_rate, clk_get_rate(host->cfg_div_clk), ret);
-	else
-		mmc->actual_clock = clk_rate;
-
-	/* (re)start clock, if non-zero */
-	if (!ret && clk_rate) {
-		cfg = readl(host->regs + SD_EMMC_CFG);
-		cfg &= ~CFG_STOP_CLOCK;
-		writel(cfg, host->regs + SD_EMMC_CFG);
+	if (ret) {
+		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
+			clk_rate, ret);
+		return ret;
 	}
 
-	return ret;
+	mmc->actual_clock = clk_get_rate(host->cfg_div_clk);
+	host->current_clock = clk_rate;
+
+	if (clk_rate != mmc->actual_clock)
+		dev_dbg(host->dev,
+			"divider requested rate %lu != actual rate %u\n",
+			clk_rate, mmc->actual_clock);
+
+	/* (re)start clock */
+	cfg = readl(host->regs + SD_EMMC_CFG);
+	cfg &= ~CFG_STOP_CLOCK;
+	writel(cfg, host->regs + SD_EMMC_CFG);
+
+	return 0;
 }
 
 /*
-- 
2.11.0


