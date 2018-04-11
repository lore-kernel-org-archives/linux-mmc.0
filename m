From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] mmc: wbsd: Replace mdelay with usleep_range in wbsd_init
Date: Wed, 11 Apr 2018 10:46:43 +0800
Message-ID: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre@ossman.eu, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-mmc@vger.kernel.org

wbsd_init() is never called in atomic context.

The call chains ending up at wbsd_init() are:
[1] wbsd_init() <- wbsd_probe()
[2] wbsd_init() <- wbsd_pnp_probe()

wbsd_probe() is set as ".probe" in struct platform_driver.
wbsd_pnp_probe() is set as ".probe" in struct pnp_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, wbsd_init()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/host/wbsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 546aaf8..6224d12 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1709,7 +1709,7 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
 	/*
 	 * Allow device to initialise itself properly.
 	 */
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	/*
 	 * Reset the chip into a known state.
-- 
1.9.1
