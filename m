From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Date: Fri, 22 Apr 2011 13:13:28 -0700
Message-ID: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50424 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755058Ab1DVUNs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:13:48 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>, Chris Ball <cjb@laptop.org>

The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
clock.  This feature is useful and required depending on the board
design.  Add infrastructure to support SD clock tuning.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..dd1ce96 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -30,6 +30,9 @@ struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned short	adjust_clocks;
+	unsigned short	clk_select;
+	unsigned short	clk_delay;
 };
 
 #endif /* __PLAT_PXA_SDHCI_H */
-- 
1.7.0.4

