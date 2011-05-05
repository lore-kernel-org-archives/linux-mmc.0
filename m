From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
Date: Thu,  5 May 2011 21:22:58 +0800
Message-ID: <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43023 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab1EENUP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 09:20:15 -0400
Received: by pvg12 with SMTP id 12so957777pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 06:20:15 -0700 (PDT)
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
 arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index 6b2940b..b401689 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -8,7 +8,6 @@
 
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
-#include <mach/esdhc.h>
 
 #define imx_sdhci_esdhc_imx_data_entry_single(soc, _id, hwid) \
 	{								\
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..c95ab13 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -243,7 +243,7 @@ struct imx_mxc_w1_data {
 struct platform_device *__init imx_add_mxc_w1(
 		const struct imx_mxc_w1_data *data);
 
-#include <mach/esdhc.h>
+#include <linux/mmc/esdhc.h>
 struct imx_sdhci_esdhc_imx_data {
 	int id;
 	resource_size_t iobase;
-- 
1.7.4.1

