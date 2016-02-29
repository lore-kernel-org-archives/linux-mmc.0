From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH 1/2] mmc: tegra: properly disable card clock
Date: Mon, 29 Feb 2016 21:56:24 +0100
Message-ID: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:60848 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750732AbcB2U4c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Feb 2016 15:56:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

The new code to do the clock rate setting externally to the SDMMC
module has a shortcut to not propagate changes with a 0 rate to
the CAR by simply bailing out. This breaks proper cutting of the
card clock. Fix it by directly calling the correct sdhci function.

Fixes: a8e326a911d3 "mmc: tegra: implement module external clock change"
Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 212d51f..46a6bd1 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -194,7 +194,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	unsigned long host_clk;
 
 	if (!clock)
-		return;
+		return sdhci_set_clock(host, clock);;
 
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
 	clk_set_rate(pltfm_host->clk, host_clk);
-- 
2.5.0

