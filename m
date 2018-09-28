From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: add bus_clk control
Date: Fri, 28 Sep 2018 19:40:55 +0800
Message-ID: <1538134855-11198-3-git-send-email-chaotian.jing@mediatek.com>
References: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

when gate MSDC0_HCLK, access register will hang, even the MSDC driver
will never accessing register after HCLK was gated, but for safety, need
gate the bus_clk(which used to access register) too.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0484138..1c1c967 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -387,6 +387,7 @@ struct msdc_host {
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
+	struct clk *bus_clk;	/* bus clock which used to access register */
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
@@ -660,12 +661,14 @@ static void msdc_gate_clock(struct msdc_host *host)
 {
 	clk_disable_unprepare(host->src_clk_cg);
 	clk_disable_unprepare(host->src_clk);
+	clk_disable_unprepare(host->bus_clk);
 	clk_disable_unprepare(host->h_clk);
 }
 
 static void msdc_ungate_clock(struct msdc_host *host)
 {
 	clk_prepare_enable(host->h_clk);
+	clk_prepare_enable(host->bus_clk);
 	clk_prepare_enable(host->src_clk);
 	clk_prepare_enable(host->src_clk_cg);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
@@ -1900,6 +1903,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(host->bus_clk))
+		host->bus_clk = NULL;
 	/*source clock control gate is optional clock*/
 	host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
 	if (IS_ERR(host->src_clk_cg))
-- 
1.8.1.1.dirty
