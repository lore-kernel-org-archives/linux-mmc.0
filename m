From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add write/read function for DATA register
Date: Fri, 30 Sep 2011 17:37:58 +0900
Message-ID: <4E857FE6.5020208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22195 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1I3IiD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2011 04:38:03 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSB007K8UJT7FS0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 17:38:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSB00G2WUNCO090@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 17:38:00 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

In dw_mmc 2.40a spec, Data register's offset is changed.
Now we used Data register offset is 0x100. but if somebody use 2.40a
controller, must use 0x200 for Data register.

This patch is added version-id checking point and write/read function
with data_offset for DATA register.(e.g writeld()/readld()...)
(assume 2.40a is the latest version)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   66
++++++++++++++++++++++++++++++--------------
 drivers/mmc/host/dw_mmc.h  |   24 ++++++++++++++++
 include/linux/mmc/dw_mmc.h |    2 +
 3 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0ed1d28..d1aed43 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1043,7 +1043,8 @@ static void dw_mci_push_data16(struct dw_mci
*host, void *buf, int cnt)
 		buf += len;
 		cnt -= len;
 		if (!sg_next(host->sg) || host->part_buf_count == 2) {
-			mci_writew(host, DATA, host->part_buf16);
+			mci_writewd(host, DATA, host->part_buf16,
+					host->data_offset);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1060,21 +1061,23 @@ static void dw_mci_push_data16(struct dw_mci
*host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writew(host, DATA, aligned_buf[i]);
+				mci_writewd(host, DATA, aligned_buf[i],
+						host->data_offset);
 		}
 	} else
 #endif
 	{
 		u16 *pdata = buf;
 		for (; cnt >= 2; cnt -= 2)
-			mci_writew(host, DATA, *pdata++);
+			mci_writewd(host, DATA, *pdata++, host->data_offset);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
 	if (cnt) {
 		dw_mci_set_part_bytes(host, buf, cnt);
 		if (!sg_next(host->sg))
-			mci_writew(host, DATA, host->part_buf16);
+			mci_writewd(host, DATA, host->part_buf16,
+					host->data_offset);
 	}
 }

@@ -1089,7 +1092,8 @@ static void dw_mci_pull_data16(struct dw_mci
*host, void *buf, int cnt)
 			int items = len >> 1;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readw(host, DATA);
+				aligned_buf[i] = mci_readwd(host, DATA,
+						host->data_offset);
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1100,11 +1104,11 @@ static void dw_mci_pull_data16(struct dw_mci
*host, void *buf, int cnt)
 	{
 		u16 *pdata = buf;
 		for (; cnt >= 2; cnt -= 2)
-			*pdata++ = mci_readw(host, DATA);
+			*pdata++ = mci_readwd(host, DATA, host->data_offset);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf16 = mci_readw(host, DATA);
+		host->part_buf16 = mci_readwd(host, DATA, host->data_offset);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -1117,7 +1121,8 @@ static void dw_mci_push_data32(struct dw_mci
*host, void *buf, int cnt)
 		buf += len;
 		cnt -= len;
 		if (!sg_next(host->sg) || host->part_buf_count == 4) {
-			mci_writel(host, DATA, host->part_buf32);
+			mci_writeld(host, DATA, host->part_buf32,
+					host->data_offset);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1134,21 +1139,23 @@ static void dw_mci_push_data32(struct dw_mci
*host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writel(host, DATA, aligned_buf[i]);
+				mci_writeld(host, DATA, aligned_buf[i],
+						host->data_offset);
 		}
 	} else
 #endif
 	{
 		u32 *pdata = buf;
 		for (; cnt >= 4; cnt -= 4)
-			mci_writel(host, DATA, *pdata++);
+			mci_writeld(host, DATA, *pdata++, host->data_offset);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
 	if (cnt) {
 		dw_mci_set_part_bytes(host, buf, cnt);
 		if (!sg_next(host->sg))
-			mci_writel(host, DATA, host->part_buf32);
+			mci_writeld(host, DATA, host->part_buf32,
+					host->data_offset);
 	}
 }

@@ -1163,7 +1170,8 @@ static void dw_mci_pull_data32(struct dw_mci
*host, void *buf, int cnt)
 			int items = len >> 2;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readl(host, DATA);
+				aligned_buf[i] = mci_readld(host, DATA,
+						host->data_offset);
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1174,11 +1182,11 @@ static void dw_mci_pull_data32(struct dw_mci
*host, void *buf, int cnt)
 	{
 		u32 *pdata = buf;
 		for (; cnt >= 4; cnt -= 4)
-			*pdata++ = mci_readl(host, DATA);
+			*pdata++ = mci_readld(host, DATA, host->data_offset);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf32 = mci_readl(host, DATA);
+		host->part_buf32 = mci_readld(host, DATA, host->data_offset);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -1191,7 +1199,8 @@ static void dw_mci_push_data64(struct dw_mci
*host, void *buf, int cnt)
 		buf += len;
 		cnt -= len;
 		if (!sg_next(host->sg) || host->part_buf_count == 8) {
-			mci_writew(host, DATA, host->part_buf);
+			mci_writewd(host, DATA, host->part_buf,
+					host->data_offset);
 			host->part_buf_count = 0;
 		}
 	}
@@ -1208,21 +1217,23 @@ static void dw_mci_push_data64(struct dw_mci
*host, void *buf, int cnt)
 			cnt -= len;
 			/* push data from aligned buffer into fifo */
 			for (i = 0; i < items; ++i)
-				mci_writeq(host, DATA, aligned_buf[i]);
+				mci_writeqd(host, DATA, aligned_buf[i],
+						host->data_offset);
 		}
 	} else
 #endif
 	{
 		u64 *pdata = buf;
 		for (; cnt >= 8; cnt -= 8)
-			mci_writeq(host, DATA, *pdata++);
+			mci_writeqd(host, DATA, *pdata++, host->data_offset);
 		buf = pdata;
 	}
 	/* put anything remaining in the part_buf */
 	if (cnt) {
 		dw_mci_set_part_bytes(host, buf, cnt);
 		if (!sg_next(host->sg))
-			mci_writeq(host, DATA, host->part_buf);
+			mci_writeqd(host, DATA, host->part_buf,
+					host->data_offset);
 	}
 }

@@ -1237,7 +1248,8 @@ static void dw_mci_pull_data64(struct dw_mci
*host, void *buf, int cnt)
 			int items = len >> 3;
 			int i;
 			for (i = 0; i < items; ++i)
-				aligned_buf[i] = mci_readq(host, DATA);
+				aligned_buf[i] = mci_readqd(host, DATA,
+						host->data_offset);
 			/* memcpy from aligned buffer into output buffer */
 			memcpy(buf, aligned_buf, len);
 			buf += len;
@@ -1248,11 +1260,11 @@ static void dw_mci_pull_data64(struct dw_mci
*host, void *buf, int cnt)
 	{
 		u64 *pdata = buf;
 		for (; cnt >= 8; cnt -= 8)
-			*pdata++ = mci_readq(host, DATA);
+			*pdata++ = mci_readqd(host, DATA, host->data_offset);
 		buf = pdata;
 	}
 	if (cnt) {
-		host->part_buf = mci_readq(host, DATA);
+		host->part_buf = mci_readqd(host, DATA, host->data_offset);
 		dw_mci_pull_final_bytes(host, buf, cnt);
 	}
 }
@@ -1952,6 +1964,18 @@ static int dw_mci_probe(struct platform_device *pdev)
 	}

 	/*
+	 * In 2.40a spec, Data offset is changed.
+	 * Need to check the version-id and set data-offset for DATA register.
+	 */
+	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
+	dev_info(&pdev->dev, "Version ID is %04x\n", host->verid);
+
+	if (host->verid == DW_MMC_240A)
+		host->data_offset = DATA_240A_OFFSET;
+	else
+		host->data_offset = DATA_OFFSET;
+
+	/*
 	 * Enable interrupts for command done, data over, data empty, card det,
 	 * receive ready and error such as transmit, receive timeout, crc error
 	 */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index bfa3c1c..6cdbe5f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -14,6 +14,8 @@
 #ifndef _DW_MMC_H_
 #define _DW_MMC_H_

+#define DW_MMC_240A		0x240a
+
 #define SDMMC_CTRL		0x000
 #define SDMMC_PWREN		0x004
 #define SDMMC_CLKDIV		0x008
@@ -53,6 +55,10 @@
 #define SDMMC_BUFADDR		0x098
 #define SDMMC_DATA		0x100

+/* Data offset is difference according to Verision */
+#define DATA_OFFSET		0
+#define DATA_240A_OFFSET	0x100
+
 /* shift bit field */
 #define _SBF(f, v)		((v) << (f))

@@ -130,25 +136,39 @@
 #define SDMMC_IDMAC_ENABLE		BIT(7)
 #define SDMMC_IDMAC_FB			BIT(1)
 #define SDMMC_IDMAC_SWRESET		BIT(0)
+/* Version ID register define */
+#define SDMMC_GET_VERID(x)		((x) & 0xFFFF)

 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	__raw_readl((dev)->regs + SDMMC_##reg)
+#define mci_readld(dev, reg, offset)			\
+	__raw_readl((dev)->regs + SDMMC_##reg + offset)
 #define mci_writel(dev, reg, value)			\
 	__raw_writel((value), (dev)->regs + SDMMC_##reg)
+#define mci_writeld(dev, reg, value, offset)		\
+	__raw_writel((value), (dev)->regs + SDMMC_##reg + offset)

 /* 16-bit FIFO access macros */
 #define mci_readw(dev, reg)			\
 	__raw_readw((dev)->regs + SDMMC_##reg)
+#define mci_readwd(dev, reg, offset)		\
+	__raw_readw((dev)->regs + SDMMC_##reg + offset)
 #define mci_writew(dev, reg, value)			\
 	__raw_writew((value), (dev)->regs + SDMMC_##reg)
+#define mci_writewd(dev, reg, value, offset)		\
+	__raw_writew((value), (dev)->regs + SDMMC_##reg + offset)

 /* 64-bit FIFO access macros */
 #ifdef readq
 #define mci_readq(dev, reg)			\
 	__raw_readq((dev)->regs + SDMMC_##reg)
+#define mci_readqd(dev, reg, offset)		\
+	__raw_readq((dev)->regs + SDMMC_##reg + offset)
 #define mci_writeq(dev, reg, value)			\
 	__raw_writeq((value), (dev)->regs + SDMMC_##reg)
+#define mci_writeqd(dev, reg, value, offset)		\
+	__raw_writeq((value), (dev)->regs + SDMMC_##reg + offset)
 #else
 /*
  * Dummy readq implementation for architectures that don't define it.
@@ -160,8 +180,12 @@
  */
 #define mci_readq(dev, reg)			\
 	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
+#define mci_readqd(dev, reg, offset)		\
+	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg + offset))
 #define mci_writeq(dev, reg, value)			\
 	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
+#define mci_writeqd(dev, reg, value, offset)		\
+	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg + offset) = (value))
 #endif

 #endif /* _DW_MMC_H_ */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6b46819..6928e29 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -147,6 +147,8 @@ struct dw_mci {
 	u32			current_speed;
 	u32			num_slots;
 	u32			fifoth_val;
+	u16			verid;
+	u16			data_offset;
 	struct platform_device	*pdev;
 	struct dw_mci_board	*pdata;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];

