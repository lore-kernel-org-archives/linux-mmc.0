From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 6/6] mmc: atmel-mci: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 11:45:54 +0000
Message-ID: <1427370354-21247-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:59319 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbCZLqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2015 07:46:09 -0400
In-Reply-To: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: hskinnemoen@gmail.com, egtvedt@samfundet.no, linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben.dooks@codethink.co.uk>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Use <linux/atmel_io.h> to provide IO accessors which work on both
AVR32 and ARM for on-chip peripherals.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Ludovic Desroches <ludovic.desroches@atmel.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/atmel-mci-regs.h | 11 ++---------
 drivers/mmc/host/atmel-mci.c      |  1 +
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index 711bb53..2293f2c 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -135,17 +135,10 @@
 #define ATMCI_REGS_SIZE		0x100
 
 /* Register access macros */
-#ifdef CONFIG_AVR32
 #define atmci_readl(port,reg)			\
-	__raw_readl((port)->regs + reg)
+	atmel_oc_readl((port)->regs + reg)
 #define atmci_writel(port,reg,value)			\
-	__raw_writel((value), (port)->regs + reg)
-#else
-#define atmci_readl(port,reg)			\
-	readl_relaxed((port)->regs + reg)
-#define atmci_writel(port,reg,value)			\
-	writel_relaxed((value), (port)->regs + reg)
-#endif
+	atmel_oc_writel((value), (port)->regs + reg)
 
 /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
 #ifdef CONFIG_AVR32
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 03d7c75..49de0d7 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -37,6 +37,7 @@
 
 #include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
+#include <linux/atmel_io.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
-- 
2.1.4

