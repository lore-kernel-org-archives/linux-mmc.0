From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/6] mmc: mediatek: fill the actual clock for mmc debugfs
Date: Sat, 13 Oct 2018 15:20:46 +0800
Message-ID: <1539415250-32337-3-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org

as the mmc core layer has the mmc->actual_clock, so fill it
and drop msdc_host->sclk.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 1c1c967..ef45f1d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -391,7 +391,6 @@ struct msdc_host {
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
-	u32 sclk;		/* SD/MS bus clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 latch_ck;
@@ -636,10 +635,10 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 
 	host->timeout_ns = ns;
 	host->timeout_clks = clks;
-	if (host->sclk == 0) {
+	if (host->mmc->actual_clock == 0) {
 		timeout = 0;
 	} else {
-		clk_ns  = 1000000000UL / host->sclk;
+		clk_ns  = 1000000000UL / host->mmc->actual_clock;
 		timeout = (ns + clk_ns - 1) / clk_ns + clks;
 		/* in 1048576 sclk cycle unit */
 		timeout = (timeout + (0x1 << 20) - 1) >> 20;
@@ -686,6 +685,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
 		host->mclk = 0;
+		host->mmc->actual_clock = 0;
 		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 		return;
 	}
@@ -764,7 +764,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
-	host->sclk = sclk;
+	host->mmc->actual_clock = sclk;
 	host->mclk = hz;
 	host->timing = timing;
 	/* need because clk changed. */
@@ -775,7 +775,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
 	 * tune result of hs200/200Mhz is not suitable for 50Mhz
 	 */
-	if (host->sclk <= 52000000) {
+	if (host->mmc->actual_clock <= 52000000) {
 		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
 		writel(host->def_tune_para.pad_tune, host->base + tune_reg);
 	} else {
@@ -790,7 +790,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		sdr_set_field(host->base + PAD_CMD_TUNE,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
-	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
+	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
+		timing);
 }
 
 static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
-- 
1.8.1.1.dirty
