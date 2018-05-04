From: Aapo Vienamo <aapo.vienamo@iki.fi>
Subject: [PATCH] mmc: tegra: remove redundant return statement
Date: Fri, 4 May 2018 12:20:53 +0300
Message-ID: <20180504092053.GA20277@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

A redundant return statement is removed from
tegra_sdhci_set_uhs_signaling(). The function returns void and the
return does not affect the control flow of the function.

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b877c13184c2..970d38f68939 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -231,7 +231,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	if (timing == MMC_TIMING_UHS_DDR50)
 		tegra_host->ddr_signaling = true;
 
-	return sdhci_set_uhs_signaling(host, timing);
+	sdhci_set_uhs_signaling(host, timing);
 }
 
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
-- 
2.16.1
