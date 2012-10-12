From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/4] MMC: omap_hsmmc: add DT property for max bus frequency
Date: Fri, 12 Oct 2012 12:58:15 +0200
Message-ID: <1350039495-360-5-git-send-email-zonque@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1350039495-360-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Maximum bus frequency can be limited by external circuitry like level
shifters etc. Allow passing this value from DT.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/mmc/host/omap_hsmmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 86f0759..4650ef7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1676,7 +1676,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 {
 	struct omap_mmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
-	u32 bus_width;
+	u32 bus_width, max_freq;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1703,6 +1703,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,needs-special-reset", NULL))
 		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
 
+	if (!of_property_read_u32(np, "max-frequency", &max_freq))
+		pdata->max_freq = max_freq;
+
 	return pdata;
 }
 #else
-- 
1.7.11.4

