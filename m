From: Matt Fleming <matt@console-pimps.org>
Subject: Re: mmc: sdhci.h compile error
Date: Sun, 25 Apr 2010 23:28:17 +0100
Message-ID: <87zl0rb20u.fsf@linux-g6p1.site>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:55212 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab0DYW2X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Apr 2010 18:28:23 -0400
In-Reply-To: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: zhangfei.gao@gmail.com, linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 21 Apr 2010 19:43:32 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> 
> There is compile error when we enable CONFIG_MMC_SDHCI_IO_ACCESSORS,
> and include header file #include "sdhci.h"
> error: macro "writel" passed 3 arguments, but takes just 2
> 

Interesting...

It was Anton Vorontsov that added this code; presumably the code has
never been compiled for an ARM board (or any other architecture that
#define's their I/O accessors in asm/io.h).

> The writel is treated as macro and it is already defined in ARM.
> The workaround is modify the name of ops writel.
> 

It would be better if all architectures declared their I/O accessors as
static inline, but I'm not volunteering to touch all those headers ;-)
Renaming the SDHCI ops is definitely the easiest option. Anton, do you
have a problem with the attached patch to rename the SDHCI accessor
functions?

> Is there anybody also see such issue, and my platform is ARM.

I'm curious to know why you need to set MMC_SDHCI_IO_ACCESSORS. Does
your board have weird I/O memory access requirements? This option is
pretty specialized.

--

>From d9c3a1666ea7597c21a68e44f3b5a2de0a6932b6 Mon Sep 17 00:00:00 2001
Message-Id: <d9c3a1666ea7597c21a68e44f3b5a2de0a6932b6.1272234369.git.matt@console-pimps.org>
From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 25 Apr 2010 23:14:34 +0100
Subject: [PATCH] sdhci: Rename SDHCI I/O accessor functions

Unfortunately some architectures #define their read{b,w,l} and
write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functions
of the same names subject to preprocessing. This leads to the following
compiler error,

In file included from drivers/mmc/host/sdhci.c:26:
drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 arguments, but takes just 2

Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS can
be enabled for architectures that implement their read{b,w,l} and
write{b,w,l} functions with macros.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++++------
 drivers/mmc/host/sdhci-of-hlwd.c  |   12 ++++++------
 drivers/mmc/host/sdhci.h          |   36 ++++++++++++++++++------------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d5b11a1..c8623de 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
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
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 35117f3..68ddb75 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
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
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..68de5cf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -294,12 +294,12 @@ struct sdhci_host {
 
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
@@ -314,48 +314,48 @@ struct sdhci_ops {
 
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
-- 
1.6.4.rc0

