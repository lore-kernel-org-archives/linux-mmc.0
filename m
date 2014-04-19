From: James Cameron <quozl@laptop.org>
Subject: [PATCH] mmc: avoid garbage when dt properties missing
Date: Sat, 19 Apr 2014 11:24:09 +1000
Message-ID: <20140419012409.GA27990@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from zimbra.real-time.com ([63.170.91.9]:54217 "EHLO
	zimbra.real-time.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbaDSBdc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Apr 2014 21:33:32 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, James Cameron <quozl@laptop.org>

When of_property_read_u32 does not find a property, it does not
initialise the variable, yet we were using the uninitialised variable.

Found and reproduced in sdhci-pxav3.c, on wider review found also in two
other places in drivers/mmc/host/, did not review wider.

Signed-off-by: James Cameron <quozl@laptop.org>
---
 drivers/mmc/host/omap_hsmmc.c  | 2 +-
 drivers/mmc/host/sdhci-pxav2.c | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e91ee21..21ff9aa 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1784,7 +1784,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 {
 	struct omap_mmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
-	u32 bus_width, max_freq;
+	u32 bus_width = 0, max_freq;
 	int cd_gpio, wp_gpio;
 
 	cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index d51e061..10bb29b 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -130,8 +130,8 @@ static struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device *dev)
 {
 	struct sdhci_pxa_platdata *pdata;
 	struct device_node *np = dev->of_node;
-	u32 bus_width;
-	u32 clk_delay_cycles;
+	u32 bus_width = 0;
+	u32 clk_delay_cycles = 0;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 2fd73b3..d2baa15 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -253,7 +253,7 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 {
 	struct sdhci_pxa_platdata *pdata;
 	struct device_node *np = dev->of_node;
-	u32 clk_delay_cycles;
+	u32 clk_delay_cycles = 0;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-- 
1.8.3.2


-- 
James Cameron
http://quozl.linux.org.au/
