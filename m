From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 313/493] mmc: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:22 -0500
Message-ID: <1353349642-3677-313-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:42024 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2KSSsA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 13:48:00 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chris Ball <cjb@laptop.org> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Rob Herring <rob.herring@calxeda.com> 
Cc: linux-mmc@vger.kernel.org 
Cc: devicetree-discuss@lists.ozlabs.org 
---
 drivers/mmc/host/mmc_spi.c     | 2 +-
 drivers/mmc/host/sdhci-dove.c  | 2 +-
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index f7df798..1e2256b 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1517,7 +1517,7 @@ static int __devexit mmc_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct of_device_id mmc_spi_of_match_table[] __devinitdata = {
+static struct of_device_id mmc_spi_of_match_table[] = {
 	{ .compatible = "mmc-spi-slot", },
 	{},
 };
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 334ec5c..73c0eb8 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -129,7 +129,7 @@ static int __devexit sdhci_dove_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id sdhci_dove_of_match_table[] __devinitdata = {
+static const struct of_device_id sdhci_dove_of_match_table[] = {
 	{ .compatible = "marvell,dove-sdhci", },
 	{}
 };
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 339c41e..d3936d0 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -206,7 +206,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra30 = {
 };
 #endif
 
-static const struct of_device_id sdhci_tegra_dt_match[] __devinitdata = {
+static const struct of_device_id sdhci_tegra_dt_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 #endif
-- 
1.8.0

