From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 4/9] mmc: mediatek: change the argument "ddr" to "timing"
Date: Tue, 20 Oct 2015 17:13:06 +0800
Message-ID: <1445332391-30530-5-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Minda Chen <Minda.Chen@csr.com>, Dong Aisheng <b29396@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Weijun Yang <Weijun.Yang@csr.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, Howard Chen <ibanezchen@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ivan.ivanov@linaro.org, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias>
List-Id: linux-mmc@vger.kernel.org

use the ios->timing directly is better
It can reflect current timing and do settings by timing

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8b3e15d..c877ded 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -297,7 +297,7 @@ struct msdc_host {
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
 	u32 sclk;		/* SD/MS bus clock frequency */
-	bool ddr;
+	unsigned char timing;
 	bool vqmmc_enabled;
 	struct msdc_save_para save_para; /* used when gate HCLK */
 };
@@ -488,7 +488,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 		cpu_relax();
 }
 
-static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
+static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 {
 	u32 mode;
 	u32 flags;
@@ -504,7 +504,8 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
 
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
-	if (ddr) { /* may need to modify later */
+	if (timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_MMC_DDR52) {
 		mode = 0x2; /* ddr mode and use divisor */
 		if (hz >= (host->src_clk_freq >> 2)) {
 			div = 0; /* mean div = 1/4 */
@@ -535,12 +536,12 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
 		cpu_relax();
 	host->sclk = sclk;
 	host->mclk = hz;
-	host->ddr = ddr;
+	host->timing = timing;
 	/* need because clk changed. */
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
 	sdr_set_bits(host->base + MSDC_INTEN, flags);
 
-	dev_dbg(host->dev, "sclk: %d, ddr: %d\n", host->sclk, ddr);
+	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
 }
 
 static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
@@ -1158,14 +1159,9 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
-	u32 ddr = 0;
 
 	pm_runtime_get_sync(host->dev);
 
-	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_DDR52)
-		ddr = 1;
-
 	msdc_set_buswidth(host, ios->bus_width);
 
 	/* Suspend/Resume will do power off/on */
@@ -1202,8 +1198,8 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->mclk != ios->clock || host->ddr != ddr)
-		msdc_set_mclk(host, ddr, ios->clock);
+	if (host->mclk != ios->clock || host->timing != ios->timing)
+		msdc_set_mclk(host, ios->timing, ios->clock);
 
 end:
 	pm_runtime_mark_last_busy(host->dev);
-- 
1.8.1.1.dirty
