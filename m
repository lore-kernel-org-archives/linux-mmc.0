From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH RESEND] mmc: sunxi: Check the value returned by clk_round_rate
Date: Sat, 13 Aug 2016 18:01:47 +0200
Message-ID: <57af4930.cad11c0a.f4672.4373SMTPIN_ADDED_MISSING@gmr-mx.google.com>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBMESXW6QKGQE3FVN5TQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

clk_round_rate() may return an error. Check it.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
