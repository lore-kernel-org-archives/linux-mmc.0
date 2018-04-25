From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 02/12] mmc: sdhci-omap: Remove setting ADMA capability in driver
Date: Wed, 25 Apr 2018 17:39:27 +0530
Message-ID: <20180425120937.29867-3-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

sdhci can directly get ADMA capability from MMCHS_CAPA register.
Remove explicitly setting ADMA here as some instances might not have
ADMA enabled. (sdhci_read_caps() is also removed from here since
sdhci_setup_host() invokes it).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 9bb53702e0e5..6e2cf4cfeec0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 
-	sdhci_read_caps(host);
-	host->caps |= SDHCI_CAN_DO_ADMA2;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.17.0
