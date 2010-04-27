From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] sdio: add new function for RAW (Read after Write) operation
Date: Wed, 28 Apr 2010 00:18:08 +0300
Message-ID: <1272403088-4727-1-git-send-email-notasas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56016 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab0D0VSP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2010 17:18:15 -0400
Received: by wye20 with SMTP id 20so261826wye.19
        for <linux-mmc@vger.kernel.org>; Tue, 27 Apr 2010 14:18:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Grazvydas Ignotas <notasas@gmail.com>

SDIO specification allows RAW (Read after Write) operation using
IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operation is
similar to ordinary read/write commands, except that both write and read
are performed using single command/response pair. The Linux SDIO layer
already supports this internaly, only external function is missing for
drivers to make use, which is added by this patch.

This type of command is required to implement proper power save mode
support in wl1251 wifi driver.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mmc/core/sdio_io.c    |   31 +++++++++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |    3 +++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index ff27c8c..3f681be 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -406,6 +406,37 @@ void sdio_writeb(struct sdio_func *func, u8 b, unsigned int addr, int *err_ret)
 EXPORT_SYMBOL_GPL(sdio_writeb);
 
 /**
+ *	sdio_writeb_readb - write and read a byte from SDIO function
+ *	@func: SDIO function to access
+ *	@b: byte to write
+ *	@addr: address to write to
+ *	@err_ret: optional status value from transfer
+ *
+ *	Performs a RAW (Read after Write) operation as defined by SDIO spec -
+ *	single byte is written to address space of a given SDIO function and
+ *	response is read back from the same address, both using single request.
+ *	If there is a problem with the operation, 0xff is returned and
+ *	@err_ret will contain the error code.
+ */
+u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
+	unsigned int addr, int *err_ret)
+{
+	int ret;
+	u8 val;
+
+	BUG_ON(!func);
+
+	ret = mmc_io_rw_direct(func->card, 1, func->num, addr, b, &val);
+	if (err_ret)
+		*err_ret = ret;
+	if (ret)
+		val = 0xff;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(sdio_writeb_readb);
+
+/**
  *	sdio_memcpy_fromio - read a chunk of memory from a SDIO function
  *	@func: SDIO function to access
  *	@dst: buffer to store the data
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index c6c0cce..8974b19 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -145,6 +145,9 @@ extern void sdio_writew(struct sdio_func *func, u16 b,
 extern void sdio_writel(struct sdio_func *func, u32 b,
 	unsigned int addr, int *err_ret);
 
+extern u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
+	unsigned int addr, int *err_ret);
+
 extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int addr,
 	void *src, int count);
 extern int sdio_writesb(struct sdio_func *func, unsigned int addr,
-- 
1.6.3.3

