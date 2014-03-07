From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3 4/7] mmc: sh_mmcif: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Fri, 07 Mar 2014 22:30:59 +0900
Message-ID: <002c01cf3a09$7a358c00$6ea0a400$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006301cf2a57$81fa0040$85ee00c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13720 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbaCGNbB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 08:31:01 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2200JCSIVNII90@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 22:30:59 +0900 (KST)
In-reply-to: <006301cf2a57$81fa0040$85ee00c0$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>

Replaced UHS_DDR50 with MMC_DDR52.

CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/sh_mmcif.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 54730f4..656fbba 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -803,12 +803,13 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 			break;
 		}
 		switch (host->timing) {
-		case MMC_TIMING_UHS_DDR50:
+		case MMC_TIMING_MMC_DDR52:
 			/*
 			 * MMC core will only set this timing, if the host
-			 * advertises the MMC_CAP_UHS_DDR50 capability. MMCIF
-			 * implementations with this capability, e.g. sh73a0,
-			 * will have to set it in their platform data.
+			 * advertises the MMC_CAP_1_8V_DDR/MMC_CAP_1_2V_DDR
+			 * capability. MMCIF implementations with this
+			 * capability, e.g. sh73a0, will have to set it
+			 * in their platform data.
 			 */
 			tmp |= CMD_SET_DARS;
 			break;
-- 
1.7.0.4


