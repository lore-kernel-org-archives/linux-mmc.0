From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] mmc: sunxi: fix support for new timings mode only SoCs
Date: Sat,  5 Aug 2017 05:35:54 +0800
Message-ID: <20170804213555.6024-1-icenowy@aosc.io>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:36103 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdHDVgJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Aug 2017 17:36:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>

The A83T MMC support code introduces the timings mode switch, however
such a switch doesn't exist on new SoCs with only new timings mode.

Only execute the switch if the SoC really have the timings mode switch,
to fix the regression shown on new timings mode only SoCs (A64, H5,
etc).

Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use both
old and new timings")

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3777517982dd..59aba93beffb 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -784,7 +784,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		clock <<= 1;
 	}
 
-	if (host->use_new_timings) {
+	if (host->use_new_timings && host->cfg->has_timings_switch) {
 		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
 		if (ret) {
 			dev_err(mmc_dev(mmc),
-- 
2.13.0

