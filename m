From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/3] sh, mmc: Use defines when setting CE_CLK_CTRL
Date: Sat, 27 Nov 2010 08:02:59 +0900
Message-ID: <1290812579-20410-3-git-send-email-horms@verge.net.au>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1290812579-20410-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

The 16-19th bits of CE_CLK_CTRL set the
MMC clock frequency.

Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/linux/mmc/sh_mmcif.h |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 519a2cd..adf9dba 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -77,6 +77,9 @@ struct sh_mmcif_plat_data {
 #define CLK_ENABLE		(1 << 24) /* 1: output mmc clock */
 #define CLK_CLEAR		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
 #define CLK_SUP_PCLK		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
+#define CLKDIV_4		(1<<16) /* mmc clock frequency.
+					 * n: bus clock/(2^(n+1)) */
+#define CLKDIV_256		(7<<16) /* mmc clock frequency. (see above) */
 #define SRSPTO_256		((1 << 13) | (0 << 12)) /* resp timeout */
 #define SRBSYTO_29		((1 << 11) | (1 << 10) |	\
 				 (1 << 9) | (1 << 8)) /* resp busy timeout */
@@ -185,14 +188,10 @@ static inline void sh_mmcif_boot_init(void __iomem *base)
 	/* Set block size in MMCIF hardware */
 	sh_mmcif_writel(base, MMCIF_CE_BLOCK_SET, SH_MMCIF_BBS);
 
-	/* Enable the clock, set it to Bus clock/256 (about 325Khz).
-	 * It is unclear where 0x70000 comes from or if it is even needed.
-	 * It is there for byte-compatibility with code that is known to
-	 * work.
-	 */
+	/* Enable the clock, set it to Bus clock/256 (about 325Khz). */
 	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL,
-			CLK_ENABLE | SRSPTO_256 | SRBSYTO_29 | SRWDTO_29 |
-			SCCSTO_29 | 0x70000);
+			CLK_ENABLE | CLKDIV_256 | SRSPTO_256 |
+			SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
 
 	/* CMD0 */
 	sh_mmcif_boot_cmd(base, 0x00000040, 0);
@@ -216,8 +215,12 @@ static inline void sh_mmcif_boot_slurp(void __iomem *base,
 {
 	unsigned long tmp;
 
+	return;
+
 	/* In data transfer mode: Set clock to Bus clock/4 (about 20Mhz) */
-	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL, 0x01012fff);
+	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL,
+			CLK_ENABLE | CLKDIV_4 | SRSPTO_256 |
+			SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
 
 	/* CMD9 - Get CSD */
 	sh_mmcif_boot_cmd(base, 0x09806000, 0x00010000);
-- 
1.7.2.3

