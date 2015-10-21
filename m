From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc: fix the CardThreshold boundary at CardThrCtl
 register
Date: Wed, 21 Oct 2015 19:49:41 +0900
Message-ID: <1445424582-7940-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58336 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbbJUKtq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 06:49:46 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWK01W6MGQVBB90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Oct 2015 19:49:43 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, k.kozlowski@samsung.com, linux.amoon@gmail.com, jh80.chung@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>

According to DesignWare DoC file, CardThreshold bit should be
bit[27:16].
So it's correct to use (0xFFF << 16), not (0x1FFF << 16).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index f2a88d4..01cdc86 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -172,7 +172,7 @@
 /* Version ID register define */
 #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
 /* Card read threshold */
-#define SDMMC_SET_RD_THLD(v, x)		(((v) & 0x1FFF) << 16 | (x))
+#define SDMMC_SET_RD_THLD(v, x)		(((v) & 0xFFF) << 16 | (x))
 #define SDMMC_UHS_18V			BIT(0)
 /* All ctrl reset bits */
 #define SDMMC_CTRL_ALL_RESET_FLAGS \
-- 
1.9.1

