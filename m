From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH RESEND] mmc: sunxi: Check the value returned by clk_round_rate
Date: Sat, 13 Aug 2016 18:01:47 +0200
Message-ID: <E1bYbzY-0006mL-Gh@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-sunxi@googlegroups.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

clk_round_rate() may return an error. Check it.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
This patch was initially sent in a patch series about the MMC new mode,
but it may be applied independently.
---
 drivers/mmc/host/sunxi-mmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2ee4c21..ba647b7 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -656,7 +656,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
-	u32 rate, oclk_dly, rval, sclk_dly;
+	long rate;
+	u32 oclk_dly, rval, sclk_dly;
 	u32 clock = ios->clock;
 	int ret;
 
@@ -666,13 +667,18 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		clock <<= 1;
 
 	rate = clk_round_rate(host->clk_mmc, clock);
-	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
+	if (rate < 0) {
+		dev_err(mmc_dev(host->mmc), "error rounding clk to %d: %ld\n",
+			clock, rate);
+		return rate;
+	}
+	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
 		clock, rate);
 
 	/* setting clock rate */
 	ret = clk_set_rate(host->clk_mmc, rate);
 	if (ret) {
-		dev_err(mmc_dev(host->mmc), "error setting clk to %d: %d\n",
+		dev_err(mmc_dev(host->mmc), "error setting clk to %ld: %d\n",
 			rate, ret);
 		return ret;
 	}
-- 
2.9.2
