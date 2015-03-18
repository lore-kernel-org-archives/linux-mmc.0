From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 12/13] mmc: atmel-mci: use endian agnostic IO
Date: Wed, 18 Mar 2015 15:53:11 +0000
Message-ID: <1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:32912 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbbCRPx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2015 11:53:57 -0400
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk, linux-arm-kernel@lists.infradead.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Change the __raw IO functions to endian agnostic relaxed ones to allow
the driver to function on big endian ARM systems.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Ludovic Desroches <ludovic.desroches@atmel.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/atmel-mci-regs.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index c97001e..711bb53 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -135,10 +135,17 @@
 #define ATMCI_REGS_SIZE		0x100
 
 /* Register access macros */
-#define atmci_readl(port,reg)				\
+#ifdef CONFIG_AVR32
+#define atmci_readl(port,reg)			\
 	__raw_readl((port)->regs + reg)
 #define atmci_writel(port,reg,value)			\
 	__raw_writel((value), (port)->regs + reg)
+#else
+#define atmci_readl(port,reg)			\
+	readl_relaxed((port)->regs + reg)
+#define atmci_writel(port,reg,value)			\
+	writel_relaxed((value), (port)->regs + reg)
+#endif
 
 /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
 #ifdef CONFIG_AVR32
-- 
2.1.4

