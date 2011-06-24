From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4/6] mmc: dw_mmc: brackets in register access macros
Date: Fri, 24 Jun 2011 13:56:38 +0100
Message-ID: <4E048986.3040007@imgtec.com>
References: <4E0488A9.6050109@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:1422 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab1FXNMG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Jun 2011 09:12:06 -0400
In-Reply-To: <4E0488A9.6050109@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, james@albanarts.com

Add brackets around use of the dev argument to the
mci_{read,write}{w,l,q}() macros, for extra safety.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/mmc/host/dw_mmc.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 23c662a..bb9e5de 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -134,22 +134,22 @@
 
 /* Register access macros */
 #define mci_readl(dev, reg)			\
-	__raw_readl(dev->regs + SDMMC_##reg)
+	__raw_readl((dev)->regs + SDMMC_##reg)
 #define mci_writel(dev, reg, value)			\
-	__raw_writel((value), dev->regs + SDMMC_##reg)
+	__raw_writel((value), (dev)->regs + SDMMC_##reg)
 
 /* 16-bit FIFO access macros */
 #define mci_readw(dev, reg)			\
-	__raw_readw(dev->regs + SDMMC_##reg)
+	__raw_readw((dev)->regs + SDMMC_##reg)
 #define mci_writew(dev, reg, value)			\
-	__raw_writew((value), dev->regs + SDMMC_##reg)
+	__raw_writew((value), (dev)->regs + SDMMC_##reg)
 
 /* 64-bit FIFO access macros */
 #ifdef readq
 #define mci_readq(dev, reg)			\
-	__raw_readq(dev->regs + SDMMC_##reg)
+	__raw_readq((dev)->regs + SDMMC_##reg)
 #define mci_writeq(dev, reg, value)			\
-	__raw_writeq((value), dev->regs + SDMMC_##reg)
+	__raw_writeq((value), (dev)->regs + SDMMC_##reg)
 #else
 /*
  * Dummy readq implementation for architectures that don't define it.
@@ -160,9 +160,9 @@
  * rest of the code free from ifdefs.
  */
 #define mci_readq(dev, reg)			\
-	(*(volatile u64 __force *)(dev->regs + SDMMC_##reg))
+	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
 #define mci_writeq(dev, reg, value)			\
-	(*(volatile u64 __force *)(dev->regs + SDMMC_##reg) = value)
+	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
 #endif
 
 #endif /* _DW_MMC_H_ */
-- 
1.7.2.3


