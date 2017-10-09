From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 10/13] mmc: mediatek: add support of source_cg clock
Date: Mon, 9 Oct 2017 19:35:23 +0800
Message-ID: <1507548926-9555-11-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

source clock need an independent cg to control, when doing clk mode
switch, need gate source clock to avoid hw issue(multi-bit sync hw hang)

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5d99e05..522fd0a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -372,6 +372,7 @@ struct msdc_host {
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
+	struct clk *src_clk_cg; /* msdc source clock control gate */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
 	u32 sclk;		/* SD/MS bus clock frequency */
@@ -612,6 +613,7 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 
 static void msdc_gate_clock(struct msdc_host *host)
 {
+	clk_disable_unprepare(host->src_clk_cg);
 	clk_disable_unprepare(host->src_clk);
 	clk_disable_unprepare(host->h_clk);
 }
@@ -620,6 +622,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 {
 	clk_prepare_enable(host->h_clk);
 	clk_prepare_enable(host->src_clk);
+	clk_prepare_enable(host->src_clk_cg);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
 }
@@ -691,6 +694,15 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 			sclk = (host->src_clk_freq >> 2) / div;
 		}
 	}
+	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
+	/*
+	 * As src_clk/HCLK use the same bit to gate/ungate,
+	 * So if want to only gate src_clk, need gate its parent(mux).
+	 */
+	if (host->src_clk_cg)
+		clk_disable_unprepare(host->src_clk_cg);
+	else
+		clk_disable_unprepare(clk_get_parent(host->src_clk));
 	if (host->dev_comp->clk_div_bits == 8)
 		sdr_set_field(host->base + MSDC_CFG,
 			      MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
@@ -699,10 +711,14 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		sdr_set_field(host->base + MSDC_CFG,
 			      MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
 			      (mode << 12) | div);
+	if (host->src_clk_cg)
+		clk_prepare_enable(host->src_clk_cg);
+	else
+		clk_prepare_enable(clk_get_parent(host->src_clk));
 
-	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
+	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	host->sclk = sclk;
 	host->mclk = hz;
 	host->timing = timing;
@@ -1832,6 +1848,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/*source clock control gate is optional clock*/
+	host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
+	if (IS_ERR(host->src_clk_cg))
+		host->src_clk_cg = NULL;
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = -EINVAL;
-- 
1.8.1.1.dirty
