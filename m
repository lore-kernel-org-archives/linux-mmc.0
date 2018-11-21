From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 3/3] mmc: sdhci-omap: Remove redundant structure assignments
Date: Wed, 21 Nov 2018 16:03:57 +0530
Message-ID: <20181121103357.3448-4-faiz_abbas@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The sdhci_execute_tuning() function has assignment of
private pointers multiple times. Remove the redundant assignment.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 4fad47926743..f588ab679cb0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -296,10 +296,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int ret = 0;
 	u32 reg;
 
-	pltfm_host = sdhci_priv(host);
-	omap_host = sdhci_pltfm_priv(pltfm_host);
-	dev = omap_host->dev;
-
 	/* clock tuning is not needed for upto 52MHz */
 	if (ios->clock <= 52000000)
 		return 0;
-- 
2.19.1
