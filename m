From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: + sdio-add-new-function-for-raw-read-after-write-operation.patch added to -mm tree
Date: Thu, 20 May 2010 12:57:21 +0300
Message-ID: <1274349441-15708-1-git-send-email-notasas@gmail.com>
References: <201005191952.o4JJqVtq002369@imap1.linux-foundation.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41221 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab0ETKAR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2010 06:00:17 -0400
Received: by wwb34 with SMTP id 34so104340wwb.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 May 2010 03:00:16 -0700 (PDT)
In-Reply-To: <201005191952.o4JJqVtq002369@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Here is updated version that addresses your comments (removes BUG()
and improves argument name).

------------------
From: Grazvydas Ignotas <notasas@gmail.com>
Subject: sdio: add new function for RAW (Read after Write) operation

SDIO specification allows RAW (Read after Write) operation using
IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operation is
similar to ordinary read/write commands, except that both write and read
are performed using single command/response pair. The Linux SDIO layer
already supports this internally, only external function is missing for
drivers to make use, which is added by this patch.

This type of command is required to implement proper power save mode
support in wl1251 wifi driver.

Android has similar patch for G1 in it's tree for the same reason:

http://android.git.kernel.org/?p=kernel/common.git;a=commitdiff;h=74a47786f6ecbe6c1cf9fb15efe6a968451deb52

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mmc/core/sdio_io.c    |   30 ++++++++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |    3 +++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index ff27c8c..0f687cd 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -406,6 +406,36 @@ void sdio_writeb(struct sdio_func *func, u8 b, unsigned int addr, int *err_ret)
 EXPORT_SYMBOL_GPL(sdio_writeb);
 
 /**
+ *	sdio_writeb_readb - write and read a byte from SDIO function
+ *	@func: SDIO function to access
+ *	@write_byte: byte to write
+ *	@addr: address to write to
+ *	@err_ret: optional status value from transfer
+ *
+ *	Performs a RAW (Read after Write) operation as defined by SDIO spec -
+ *	single byte is written to address space of a given SDIO function and
+ *	response is read back from the same address, both using single request.
+ *	If there is a problem with the operation, 0xff is returned and
+ *	@err_ret will contain the error code.
+ */
+u8 sdio_writeb_readb(struct sdio_func *func, u8 write_byte,
+	unsigned int addr, int *err_ret)
+{
+	int ret;
+	u8 val;
+
+	ret = mmc_io_rw_direct(func->card, 1, func->num, addr,
+			write_byte, &val);
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
index c6c0cce..31baaf8 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -145,6 +145,9 @@ extern void sdio_writew(struct sdio_func *func, u16 b,
 extern void sdio_writel(struct sdio_func *func, u32 b,
 	unsigned int addr, int *err_ret);
 
+extern u8 sdio_writeb_readb(struct sdio_func *func, u8 write_byte,
+	unsigned int addr, int *err_ret);
+
 extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int addr,
 	void *src, int count);
 extern int sdio_writesb(struct sdio_func *func, unsigned int addr,
-- 
1.6.3.3

