From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH v2] mmc: sunxi: fix support for new timings mode
 only SoCs
Date: Tue,  8 Aug 2017 15:09:03 +0800
Message-ID: <20170808070903.16898-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBGWHUXGAKGQEAICFQZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The A83T MMC support code introduces the timings mode switch, however
such a switch doesn't exist on new SoCs with only new timings mode.

Only execute the switch if the SoC really have the timings mode switch,
to fix the regression shown on new timings mode only SoCs (A64, H5,
etc).

Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
		      both old and new timings")
Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
Changes in v2:
- Slightly adjusted the format of the Fixes: line/
- Added review tag from Chen-Yu.

 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 020547e5fa45..7447d41833ee 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -789,7 +789,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		clock <<= 1;
 	}
 
-	if (host->use_new_timings) {
+	if (host->use_new_timings && host->cfg->has_timings_switch) {
 		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
 		if (ret) {
 			dev_err(mmc_dev(mmc),
-- 
2.13.0
