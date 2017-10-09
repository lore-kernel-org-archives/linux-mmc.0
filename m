From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 05/13] mmc: mediatek: make hs400_tune_response only for
 mt8173
Date: Mon, 9 Oct 2017 19:35:18 +0800
Message-ID: <1507548926-9555-6-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, yong mao <yong.mao@mediatek.com>, Phong LE <ple@baylibre.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: linux-mmc@vger.kernel.org

the origin design of hs400_tune_response is for mt8173 because of
mt8173 has a special design. for doing that, we add a new member
"compatible", by now it's only for mt8173.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 643c795..e8f8ad9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -317,6 +317,7 @@ struct msdc_delay_phase {
 struct msdc_host {
 	struct device *dev;
 	const struct mtk_mmc_compatible *dev_comp;
+	const char *compatible;
 	struct mmc_host *mmc;	/* mmc structure */
 	int cmd_rsp;
 
@@ -666,7 +667,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		       host->base + PAD_CMD_TUNE);
 	}
 
-	if (timing == MMC_TIMING_MMC_HS400)
+	if (timing == MMC_TIMING_MMC_HS400 &&
+	    !strcmp(host->compatible, "mediatek,mt8173-mmc"))
 		sdr_set_field(host->base + PAD_CMD_TUNE,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
@@ -1594,7 +1596,8 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
-	if (host->hs400_mode)
+	if (host->hs400_mode &&
+	    !strcmp(host->compatible, "mediatek,mt8173-mmc"))
 		ret = hs400_tune_response(mmc, opcode);
 	else
 		ret = msdc_tune_response(mmc, opcode);
@@ -1745,6 +1748,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->dev = &pdev->dev;
 	host->dev_comp = of_id->data;
+	host->compatible = of_id->compatible;
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
-- 
1.8.1.1.dirty
