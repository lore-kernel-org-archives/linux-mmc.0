From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 09/12] mmc: mediatek: add support of source_cg clock
Date: Tue, 12 Sep 2017 17:07:49 +0800
Message-ID: <1505207272-16983-10-git-send-email-chaotian.jing@mediatek.com>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1505207272-16983-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

source clock need an independent cg to control, when doing clk mode
switch, need gate source clock to avoid hw issue(multi-bit sync hw hang)

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
