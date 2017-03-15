From: "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 1/2] mmc: core: guard dereference of optional parameter
Date: Wed, 15 Mar 2017 19:48:03 +1100
Message-ID: <1489567684-22763-2-git-send-email-me@tobin.cc>
References: <1489567684-22763-1-git-send-email-me@tobin.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489567684-22763-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Various functions take as parameter an optional pointer. Pointer
should be guarded with non-NULL check before dereferencing.

Add non-NULL check before dereference of pointer.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/mmc/core/sdio_io.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 74195d7..3482314 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -373,7 +373,8 @@ u8 sdio_readb(struct sdio_func *func, unsigned int addr, int *err_ret)
 	u8 val;
 
 	if (!func) {
-		*err_ret = -EINVAL;
+		if (err_ret)
+			*err_ret = -EINVAL;
 		return 0xFF;
 	}
 
@@ -407,7 +408,8 @@ void sdio_writeb(struct sdio_func *func, u8 b, unsigned int addr, int *err_ret)
 	int ret;
 
 	if (!func) {
-		*err_ret = -EINVAL;
+		if (err_ret)
+			*err_ret = -EINVAL;
 		return;
 	}
 
@@ -635,7 +637,8 @@ unsigned char sdio_f0_readb(struct sdio_func *func, unsigned int addr,
 	unsigned char val;
 
 	if (!func) {
-		*err_ret = -EINVAL;
+		if (err_ret)
+			*err_ret = -EINVAL;
 		return 0xFF;
 	}
 
@@ -673,7 +676,8 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
 	int ret;
 
 	if (!func) {
-		*err_ret = -EINVAL;
+		if (err_ret)
+			*err_ret = -EINVAL;
 		return;
 	}
 
-- 
2.7.4
