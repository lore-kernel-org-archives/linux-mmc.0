From: Zhang Xinlin <zhangxinlin@gmail.com>
Subject: [PATCH] mmc: esdhc-imx: fix reading of SDHCI_HOST_VERSION when controller version isn't 3.
Date: Sat, 10 Dec 2011 09:06:01 +0800
Message-ID: <1323479161-24191-1-git-send-email-zhangxinlin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [121.8.191.61] ([121.8.191.61]:56893 "EHLO maxiptech.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab1LJBMw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Dec 2011 20:12:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Zhang Xinlin <zhangxinlin@gmail.com>

According to the IMX25RMAD:
   eSDHC version      value
       1.0            0x00
       2.0            0x10
       2.1            0x11
       2.2            0x12

Signed-off-by: Zhang Xinlin <zhangxinlin@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4b976f0..1a0eb92 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -240,7 +240,8 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 		 * SDHCI_SPEC_300 definition.  Work it around here.
 		 */
 		if ((val & SDHCI_SPEC_VER_MASK) == 3)
-			return --val;
+			--val;
+		return val;
 	}
 
 	return readw(host->ioaddr + reg);
-- 
1.7.8.rc1

