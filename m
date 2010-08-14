From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] MMC: sh_mmcif: no reason to declare inline functions as
 "extern inline"
Date: Sat, 14 Aug 2010 22:47:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1008142245260.16329@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:46044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755274Ab0HNUrr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 14 Aug 2010 16:47:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/sh_mmcif.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index d4a2ebb..86b892e 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -58,19 +58,19 @@ struct sh_mmcif_plat_data {
 #define MMCIF_CE_HOST_STS2	0x0000004C
 #define MMCIF_CE_VERSION	0x0000007C
 
-extern inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
+static inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
 {
 	return readl(addr + reg);
 }
 
-extern inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
+static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
 {
 	writel(val, addr + reg);
 }
 
 #define SH_MMCIF_BBS 512 /* boot block size */
 
-extern inline void sh_mmcif_boot_cmd_send(void __iomem *base,
+static inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 					  unsigned long cmd, unsigned long arg)
 {
 	sh_mmcif_writel(base, MMCIF_CE_INT, 0);
@@ -78,7 +78,7 @@ extern inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 	sh_mmcif_writel(base, MMCIF_CE_CMD_SET, cmd);
 }
 
-extern inline int sh_mmcif_boot_cmd_poll(void __iomem *base, unsigned long mask)
+static inline int sh_mmcif_boot_cmd_poll(void __iomem *base, unsigned long mask)
 {
 	unsigned long tmp;
 	int cnt;
@@ -94,14 +94,14 @@ extern inline int sh_mmcif_boot_cmd_poll(void __iomem *base, unsigned long mask)
 	return -1;
 }
 
-extern inline int sh_mmcif_boot_cmd(void __iomem *base,
+static inline int sh_mmcif_boot_cmd(void __iomem *base,
 				    unsigned long cmd, unsigned long arg)
 {
 	sh_mmcif_boot_cmd_send(base, cmd, arg);
 	return sh_mmcif_boot_cmd_poll(base, 0x00010000);
 }
 
-extern inline int sh_mmcif_boot_do_read_single(void __iomem *base,
+static inline int sh_mmcif_boot_do_read_single(void __iomem *base,
 					       unsigned int block_nr,
 					       unsigned long *buf)
 {
@@ -124,7 +124,7 @@ extern inline int sh_mmcif_boot_do_read_single(void __iomem *base,
 	return 0;
 }
 
-extern inline int sh_mmcif_boot_do_read(void __iomem *base,
+static inline int sh_mmcif_boot_do_read(void __iomem *base,
 					unsigned long first_block,
 					unsigned long nr_blocks,
 					void *buf)
@@ -142,7 +142,7 @@ extern inline int sh_mmcif_boot_do_read(void __iomem *base,
 	return ret;
 }
 
-extern inline void sh_mmcif_boot_init(void __iomem *base)
+static inline void sh_mmcif_boot_init(void __iomem *base)
 {
 	unsigned long tmp;
 
@@ -176,7 +176,7 @@ extern inline void sh_mmcif_boot_init(void __iomem *base)
 	sh_mmcif_boot_cmd(base, 0x03400040, 0x00010000);
 }
 
-extern inline void sh_mmcif_boot_slurp(void __iomem *base,
+static inline void sh_mmcif_boot_slurp(void __iomem *base,
 				       unsigned char *buf,
 				       unsigned long no_bytes)
 {
-- 
1.7.2

