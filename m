From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for SOCFPGA
Date: Thu, 01 Aug 2013 09:28:13 +0900
Message-ID: <002601ce8e4e$027246c0$0756d440$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53141 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3HAA2P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jul 2013 20:28:15 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQT00GWNTAYXN20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Aug 2013 09:28:14 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 'Dinh Nguyen' <dinguyen@altera.com>, Jingoo Han <jg1.han@samsung.com>

Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
the following link error.

drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to `syscon_regmap_lookup_by_compatible'

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a4c066..84102bc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -569,7 +569,7 @@ config MMC_DW_EXYNOS
 
 config MMC_DW_SOCFPGA
 	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW
+	depends on MMC_DW && MFD_SYSCON
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Altera SoCFPGA specific extensions to the
-- 
1.7.10.4


