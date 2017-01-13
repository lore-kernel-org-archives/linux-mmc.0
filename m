From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: set host's DDR52 timing when finishing switching voltage
Date: Fri, 13 Jan 2017 10:29:35 +0800
Message-ID: <1484274575-38137-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:54774 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdAMCbM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 21:31:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Gary Bisson <gary.bisson@boundarydevices.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, stable@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>, Bough Chen <haibo.chen@nxp.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>

>From the discussion[0], it seems like a regression but we are
prone to believe that the problematic commit just expose some
issues of sdhci-* driver. Now we could just move the setting of
host's DDR52 timing only when finishing switching voltage to
solve the problem.

[0]: https://lists.gt.net/linux/kernel/2598199?page=last
Fixes: e173f8911f091fa50 ("mmc: core: Update CMD13 polling policy...")
cc: <stable@vger.kernel.org>
cc: Dong Aisheng <aisheng.dong@nxp.com>
cc: Bough Chen <haibo.chen@nxp.com>
cc: Fabio Estevam <festevam@gmail.com>
cc: Shawn Guo <shawnguo@kernel.org>
Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---

 drivers/mmc/core/mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ec2e85c..52b3989 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1074,8 +1074,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   EXT_CSD_BUS_WIDTH,
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
-			   MMC_TIMING_MMC_DDR52,
-			   true, true, true);
+			   0, true, true, true);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1118,6 +1117,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	if (err)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
+	if (!err)
+		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
+
 	return err;
 }
 
-- 
1.9.1


