From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 4/4] mmc: sdhci-omap: Remove redundant structure assignments
Date: Mon, 19 Nov 2018 16:46:18 +0530
Message-ID: <20181119111618.2745-5-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The sdhci_execute_tuning() function has assignment of
private pointers multiple times. Remove the redundant assignment.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index bf268b38ddc8..b3cb39d0db6f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -295,10 +295,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
