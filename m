From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RESEND 5/7] mmc: host: dw_mmc make IO accessors endian agnostic
Date: Wed, 25 Mar 2015 11:27:50 +0000
Message-ID: <1427282872-10563-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:52425 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbCYL2A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2015 07:28:00 -0400
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, marc.dunford@codethink.co.uk, sam.bishop@codethink.co.uk, Dinh Nguyen <dinguyen@opensource.altera.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Linux MMC <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

The dw_mmc driver does not use endian agnostic IO accessors, so fix
the use of __raw reads and writes to be the relaxed versions.

This fixes the dw_mmc driver initialisation on Altera socfpga in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux MMC <linux-mmc@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 18c4afe..46efdc5 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -171,22 +171,22 @@
 
 /* Register access macros */
 #define mci_readl(dev, reg)			\
-	__raw_readl((dev)->regs + SDMMC_##reg)
+	readl_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writel(dev, reg, value)			\
-	__raw_writel((value), (dev)->regs + SDMMC_##reg)
+	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
 
 /* 16-bit FIFO access macros */
 #define mci_readw(dev, reg)			\
-	__raw_readw((dev)->regs + SDMMC_##reg)
+	readw_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writew(dev, reg, value)			\
-	__raw_writew((value), (dev)->regs + SDMMC_##reg)
+	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
 
 /* 64-bit FIFO access macros */
 #ifdef readq
 #define mci_readq(dev, reg)			\
-	__raw_readq((dev)->regs + SDMMC_##reg)
+	readq_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writeq(dev, reg, value)			\
-	__raw_writeq((value), (dev)->regs + SDMMC_##reg)
+	writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
 #else
 /*
  * Dummy readq implementation for architectures that don't define it.
-- 
2.1.4

