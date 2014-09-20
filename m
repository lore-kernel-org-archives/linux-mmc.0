From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] mmc: usdhi6rol0: Remove unnecessary header files
Date: Sat, 20 Sep 2014 23:13:14 +0530
Message-ID: <1411234994-25520-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

These headers are not required hence this change removes them from
the driver.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/mmc/host/usdhi6rol0.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index f0a39eb..4094d8f 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -12,21 +12,14 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/log2.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
-#include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/string.h>
-#include <linux/time.h>
-#include <linux/virtio.h>
 #include <linux/workqueue.h>
 
 #define USDHI6_SD_CMD		0x0000
-- 
1.8.3.2
