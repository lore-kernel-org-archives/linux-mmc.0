From: grundler@google.com (Grant Grundler)
Subject: [PATCH] tegra/mmc: add pm_flags
Date: Fri, 25 Mar 2011 17:07:12 -0700 (PDT)
Message-ID: <20110326000712.DD5D3208182@grundler.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:46692 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530Ab1CZAHY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 20:07:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>
Cc: linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, grundler@chromium.org, olofj@chromium.org, vrao@broadcom.com

Enable fast bcm4329 WIFI suspend/resume on Tegra2 board.

This part allows the mach-tegra support tell the tegra MMC host controller
to NOT turn off power for the MMC controller the WIFI part lives behind.
Thus bcm4329 firmware doesn't need to be reloaded.

Signed-off-by: Venkat Rao <vrao@broadcom>
Tested-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
----
I'm not certain if this should go through tegra or mmc tree.
Can you advise please?

This is part of http://codereview.chromium.org/6474032 .
The other three change sets required for Seaboard (Tegra2):
    http://codereview.chromium.org/6484021
    http://codereview.chromium.org/6488018
    http://codereview.chromium.org/6489022


diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/arch/arm/mach-tegra/include/mach/sdhci.h
index 3ad086e..4231bc7 100644
--- a/arch/arm/mach-tegra/include/mach/sdhci.h
+++ b/arch/arm/mach-tegra/include/mach/sdhci.h
@@ -24,6 +24,7 @@ struct tegra_sdhci_platform_data {
 	int wp_gpio;
 	int power_gpio;
 	int is_8bit;
+	int pm_flags;
 };
 
 #endif
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f7e1f96..343c97e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -184,6 +184,8 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
+	host->mmc->pm_caps = plat->pm_flags;
+
 	if (plat->is_8bit)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
