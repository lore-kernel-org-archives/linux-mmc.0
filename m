From: Simon Horman <horms@verge.net.au>
Subject: [PATCH v2] mmc, sh: Move constants to sh_mmcif.h
Date: Tue, 9 Nov 2010 17:47:02 +0900
Message-ID: <20101109092952.01349C223F@yukiko.kent.sydney.vergenet.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41095 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab0KIJ34 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 04:29:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

This moves some constants from sh_mmcif.c to sh_mmcif.h
so that they can be used in sh_mmcif_boot_init().

It also alters the definition of SOFT_RST_OFF from (0 << 31) to
~SOFT_RST_ON (= ~(1 << 31)). The former seems bogus.  The latter is
consistent with the code in sh_mmcif_boot_init().

Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mmcif.c  |   23 -----------------------
 include/linux/mmc/sh_mmcif.h |   39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 28 deletions(-)

* v1 diff against 2.6.37-rc1

* v2 rediff against Linus's current tree

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ddd0984..3f49273 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -62,25 +62,6 @@
 /* CE_BLOCK_SET */
 #define BLOCK_SIZE_MASK		0x0000ffff
 
-/* CE_CLK_CTRL */
-#define CLK_ENABLE		(1 << 24) /* 1: output mmc clock */
-#define CLK_CLEAR		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
-#define CLK_SUP_PCLK		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
-#define SRSPTO_256		((1 << 13) | (0 << 12)) /* resp timeout */
-#define SRBSYTO_29		((1 << 11) | (1 << 10) |	\
-				 (1 << 9) | (1 << 8)) /* resp busy timeout */
-#define SRWDTO_29		((1 << 7) | (1 << 6) |		\
-				 (1 << 5) | (1 << 4)) /* read/write timeout */
-#define SCCSTO_29		((1 << 3) | (1 << 2) |		\
-				 (1 << 1) | (1 << 0)) /* ccs timeout */
-
-/* CE_BUF_ACC */
-#define BUF_ACC_DMAWEN		(1 << 25)
-#define BUF_ACC_DMAREN		(1 << 24)
-#define BUF_ACC_BUSW_32		(0 << 17)
-#define BUF_ACC_BUSW_16		(1 << 17)
-#define BUF_ACC_ATYP		(1 << 16)
-
 /* CE_INT */
 #define INT_CCSDE		(1 << 29)
 #define INT_CMD12DRE		(1 << 26)
@@ -165,10 +146,6 @@
 				 STS2_AC12BSYTO | STS2_RSPBSYTO |	\
 				 STS2_AC12RSPTO | STS2_RSPTO)
 
-/* CE_VERSION */
-#define SOFT_RST_ON		(1 << 31)
-#define SOFT_RST_OFF		(0 << 31)
-
 #define CLKDEV_EMMC_DATA	52000000 /* 52MHz */
 #define CLKDEV_MMC_DATA		20000000 /* 20MHz */
 #define CLKDEV_INIT		400000   /* 400 KHz */
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index d19e211..b4eaebf 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -59,6 +59,29 @@ struct sh_mmcif_plat_data {
 #define MMCIF_CE_HOST_STS2	0x0000004C
 #define MMCIF_CE_VERSION	0x0000007C
 
+/* CE_BUF_ACC */
+#define BUF_ACC_DMAWEN		(1 << 25)
+#define BUF_ACC_DMAREN		(1 << 24)
+#define BUF_ACC_BUSW_32		(0 << 17)
+#define BUF_ACC_BUSW_16		(1 << 17)
+#define BUF_ACC_ATYP		(1 << 16)
+
+/* CE_CLK_CTRL */
+#define CLK_ENABLE		(1 << 24) /* 1: output mmc clock */
+#define CLK_CLEAR		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
+#define CLK_SUP_PCLK		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
+#define SRSPTO_256		((1 << 13) | (0 << 12)) /* resp timeout */
+#define SRBSYTO_29		((1 << 11) | (1 << 10) |	\
+				 (1 << 9) | (1 << 8)) /* resp busy timeout */
+#define SRWDTO_29		((1 << 7) | (1 << 6) |		\
+				 (1 << 5) | (1 << 4)) /* read/write timeout */
+#define SCCSTO_29		((1 << 3) | (1 << 2) |		\
+				 (1 << 1) | (1 << 0)) /* ccs timeout */
+
+/* CE_VERSION */
+#define SOFT_RST_ON		(1 << 31)
+#define SOFT_RST_OFF		~SOFT_RST_ON
+
 static inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
 {
 	return readl(addr + reg);
@@ -149,17 +172,23 @@ extern inline void sh_mmcif_boot_init(void __iomem *base)
 
 	/* reset */
 	tmp = sh_mmcif_readl(base, MMCIF_CE_VERSION);
-	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp | 0x80000000);
-	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp & ~0x80000000);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp | SOFT_RST_ON);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp & SOFT_RST_OFF);
 
 	/* byte swap */
-	sh_mmcif_writel(base, MMCIF_CE_BUF_ACC, 0x00010000);
+	sh_mmcif_writel(base, MMCIF_CE_BUF_ACC, BUF_ACC_ATYP);
 
 	/* Set block size in MMCIF hardware */
 	sh_mmcif_writel(base, MMCIF_CE_BLOCK_SET, SH_MMCIF_BBS);
 
-	/* Enable the clock, set it to Bus clock/256 (about 325Khz)*/
-	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL, 0x01072fff);
+	/* Enable the clock, set it to Bus clock/256 (about 325Khz).
+	 * It is unclear where 0x70000 comes from or if it is even needed.
+	 * It is there for byte-compatibility with code that is known to
+	 * work.
+	 */
+	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL,
+			CLK_ENABLE | SRSPTO_256 | SRBSYTO_29 | SRWDTO_29 |
+			SCCSTO_29 | 0x70000);
 
 	/* CMD0 */
 	sh_mmcif_boot_cmd(base, 0x00000040, 0);
-- 
1.7.2.3

