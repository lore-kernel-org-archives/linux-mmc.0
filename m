From: "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 2/2] mmc: core: simplify return code
Date: Wed, 15 Mar 2017 19:48:04 +1100
Message-ID: <1489567684-22763-3-git-send-email-me@tobin.cc>
References: <1489567684-22763-1-git-send-email-me@tobin.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489567684-22763-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

File contains multiple functions doing variations on the same thing,
sdio_readb(), sdio_writeb()f, sdio_readw(), sdio_writew()
etc. Although the functions have very similar logic the code is laid
out in a variety of ways. This makes it overly complicated to
read. There is a already a nice clean chunk of code, if we use this
format for all instances then we will have cleaned up the code,
reduced the line count and lessened the cognitive load required while
reading. Less lines equals less bugs.

Pick the most simple and clear code flow and change all functions to
be the same.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/mmc/core/sdio_io.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 3482314..d40744b 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -378,15 +378,11 @@ u8 sdio_readb(struct sdio_func *func, unsigned int addr, int *err_ret)
 		return 0xFF;
 	}
 
-	if (err_ret)
-		*err_ret = 0;
-
 	ret = mmc_io_rw_direct(func->card, 0, func->num, addr, 0, &val);
-	if (ret) {
-		if (err_ret)
-			*err_ret = ret;
+	if (err_ret)
+		*err_ret = ret;
+	if (ret)
 		return 0xFF;
-	}
 
 	return val;
 }
@@ -443,7 +439,7 @@ u8 sdio_writeb_readb(struct sdio_func *func, u8 write_byte,
 	if (err_ret)
 		*err_ret = ret;
 	if (ret)
-		val = 0xff;
+		return 0xff;
 
 	return val;
 }
@@ -531,15 +527,11 @@ u16 sdio_readw(struct sdio_func *func, unsigned int addr, int *err_ret)
 {
 	int ret;
 
-	if (err_ret)
-		*err_ret = 0;
-
 	ret = sdio_memcpy_fromio(func, func->tmpbuf, addr, 2);
-	if (ret) {
-		if (err_ret)
-			*err_ret = ret;
+	if (err_ret)
+		*err_ret = ret;
+	if (ret)
 		return 0xFFFF;
-	}
 
 	return le16_to_cpup((__le16 *)func->tmpbuf);
 }
@@ -583,15 +575,11 @@ u32 sdio_readl(struct sdio_func *func, unsigned int addr, int *err_ret)
 {
 	int ret;
 
-	if (err_ret)
-		*err_ret = 0;
-
 	ret = sdio_memcpy_fromio(func, func->tmpbuf, addr, 4);
-	if (ret) {
-		if (err_ret)
-			*err_ret = ret;
+	if (err_ret)
+		*err_ret = ret;
+	if (ret)
 		return 0xFFFFFFFF;
-	}
 
 	return le32_to_cpup((__le32 *)func->tmpbuf);
 }
@@ -642,15 +630,11 @@ unsigned char sdio_f0_readb(struct sdio_func *func, unsigned int addr,
 		return 0xFF;
 	}
 
-	if (err_ret)
-		*err_ret = 0;
-
 	ret = mmc_io_rw_direct(func->card, 0, 0, addr, 0, &val);
-	if (ret) {
-		if (err_ret)
-			*err_ret = ret;
+	if (err_ret)
+		*err_ret = ret;
+	if (ret)
 		return 0xFF;
-	}
 
 	return val;
 }
-- 
2.7.4
