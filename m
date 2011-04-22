From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] plat-pxa: add missing define for PERMANENT CARDS
Date: Fri, 22 Apr 2011 13:16:14 -0700
Message-ID: <7AB22AD5-15A5-42CC-9041-FA71603A5238@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53810 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab1DVUQW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:16:22 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Zhangfei Gao <zgao6@marvell.com>


Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index b3e4d19..1c655d0 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -17,6 +17,7 @@
 /* Require clock free running */
 
 /* Board design supports 8-bit data on SD/SDIO BUS */
+#define PXA_FLAG_CARD_PERMANENT		(1<<1)
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
 
 /*
-- 
1.7.0.4

