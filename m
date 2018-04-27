From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 04/14] mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt properties
Date: Fri, 27 Apr 2018 17:17:13 +0530
Message-ID: <20180427114723.2687-5-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
sdhci specific properties from dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b3dc7f1466e5..d5c1a9c71f95 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
+	sdhci_get_of_property(pdev);
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_pltfm_free;
-- 
2.17.0
