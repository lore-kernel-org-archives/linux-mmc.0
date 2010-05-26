From: akpm@linux-foundation.org
Subject: [patch 013/203] sdhci: build fix: rename SDHCI I/O accessor functions
Date: Wed, 26 May 2010 14:42:03 -0700
Message-ID: <201005262142.o4QLg321015355@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54704 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710Ab0EZWPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:15:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, matt@console-pimps.org, ben-linux@fluff.org, cbouatmailru@gmail.com, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, zgao6@marvell.com

From: Matt Fleming <matt@console-pimps.org>

Unfortunately some architectures #define their read{b,w,l} and
write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functions of
the same names subject to preprocessing.  This leads to the following
compiler error,

In file included from drivers/mmc/host/sdhci.c:26:
drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 arguments, but takes just 2

Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS can
be enabled for architectures that implement their read{b,w,l} and
write{b,w,l} functions with macros.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
Cc: Zhangfei Gao <zgao6@marvell.com>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++-----
 drivers/mmc/host/sdhci-of-hlwd.c  |   12 ++++-----
 drivers/mmc/host/sdhci.h          |   36 ++++++++++++++--------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff -puN drivers/mmc/host/sdhci-of-esdhc.c~sdhci-rename-sdhci-i-o-accessor-functions drivers/mmc/host/sdhci-of-esdhc.c
--- a/drivers/mmc/host/sdhci-of-esdhc.c~sdhci-rename-sdhci-i-o-accessor-functions
+++ a/drivers/mmc/host/sdhci-of-esdhc.c
@@ -129,12 +129,12 @@ struct sdhci_of_data sdhci_esdhc = {
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET,
 	.ops = {
-		.readl = sdhci_be32bs_readl,
-		.readw = esdhc_readw,
-		.readb = sdhci_be32bs_readb,
-		.writel = sdhci_be32bs_writel,
-		.writew = esdhc_writew,
-		.writeb = esdhc_writeb,
+		.read_l = sdhci_be32bs_readl,
+		.read_w = esdhc_readw,
+		.read_b = sdhci_be32bs_readb,
+		.write_l = sdhci_be32bs_writel,
+		.write_w = esdhc_writew,
+		.write_b = esdhc_writeb,
 		.set_clock = esdhc_set_clock,
 		.enable_dma = esdhc_enable_dma,
 		.get_max_clock = esdhc_get_max_clock,
diff -puN drivers/mmc/host/sdhci-of-hlwd.c~sdhci-rename-sdhci-i-o-accessor-functions drivers/mmc/host/sdhci-of-hlwd.c
--- a/drivers/mmc/host/sdhci-of-hlwd.c~sdhci-rename-sdhci-i-o-accessor-functions
+++ a/drivers/mmc/host/sdhci-of-hlwd.c
@@ -55,11 +55,11 @@ struct sdhci_of_data sdhci_hlwd = {
 	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
 		  SDHCI_QUIRK_32BIT_DMA_SIZE,
 	.ops = {
-		.readl = sdhci_be32bs_readl,
-		.readw = sdhci_be32bs_readw,
-		.readb = sdhci_be32bs_readb,
-		.writel = sdhci_hlwd_writel,
-		.writew = sdhci_hlwd_writew,
-		.writeb = sdhci_hlwd_writeb,
+		.read_l = sdhci_be32bs_readl,
+		.read_w = sdhci_be32bs_readw,
+		.read_b = sdhci_be32bs_readb,
+		.write_l = sdhci_hlwd_writel,
+		.write_w = sdhci_hlwd_writew,
+		.write_b = sdhci_hlwd_writeb,
 	},
 };
diff -puN drivers/mmc/host/sdhci.h~sdhci-rename-sdhci-i-o-accessor-functions drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-rename-sdhci-i-o-accessor-functions
+++ a/drivers/mmc/host/sdhci.h
@@ -296,12 +296,12 @@ struct sdhci_host {
 
 struct sdhci_ops {
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-	u32		(*readl)(struct sdhci_host *host, int reg);
-	u16		(*readw)(struct sdhci_host *host, int reg);
-	u8		(*readb)(struct sdhci_host *host, int reg);
-	void		(*writel)(struct sdhci_host *host, u32 val, int reg);
-	void		(*writew)(struct sdhci_host *host, u16 val, int reg);
-	void		(*writeb)(struct sdhci_host *host, u8 val, int reg);
+	u32		(*read_l)(struct sdhci_host *host, int reg);
+	u16		(*read_w)(struct sdhci_host *host, int reg);
+	u8		(*read_b)(struct sdhci_host *host, int reg);
+	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
+	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
+	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
 #endif
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
@@ -316,48 +316,48 @@ struct sdhci_ops {
 
 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 {
-	if (unlikely(host->ops->writel))
-		host->ops->writel(host, val, reg);
+	if (unlikely(host->ops->write_l))
+		host->ops->write_l(host, val, reg);
 	else
 		writel(val, host->ioaddr + reg);
 }
 
 static inline void sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 {
-	if (unlikely(host->ops->writew))
-		host->ops->writew(host, val, reg);
+	if (unlikely(host->ops->write_w))
+		host->ops->write_w(host, val, reg);
 	else
 		writew(val, host->ioaddr + reg);
 }
 
 static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
 {
-	if (unlikely(host->ops->writeb))
-		host->ops->writeb(host, val, reg);
+	if (unlikely(host->ops->write_b))
+		host->ops->write_b(host, val, reg);
 	else
 		writeb(val, host->ioaddr + reg);
 }
 
 static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
 {
-	if (unlikely(host->ops->readl))
-		return host->ops->readl(host, reg);
+	if (unlikely(host->ops->read_l))
+		return host->ops->read_l(host, reg);
 	else
 		return readl(host->ioaddr + reg);
 }
 
 static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
 {
-	if (unlikely(host->ops->readw))
-		return host->ops->readw(host, reg);
+	if (unlikely(host->ops->read_w))
+		return host->ops->read_w(host, reg);
 	else
 		return readw(host->ioaddr + reg);
 }
 
 static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 {
-	if (unlikely(host->ops->readb))
-		return host->ops->readb(host, reg);
+	if (unlikely(host->ops->read_b))
+		return host->ops->read_b(host, reg);
 	else
 		return readb(host->ioaddr + reg);
 }
_
