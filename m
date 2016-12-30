From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/21] mmc: host: Include interrupt.h in mmc host drivers that depends on it
Date: Fri, 30 Dec 2016 13:47:23 +0100
Message-ID: <1483102054-1752-11-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33891 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3MsQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:16 -0500
Received: by mail-lf0-f48.google.com with SMTP id y21so236379550lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:15 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

An mmc host driver shouldn't rely on interrupt.h being included by another
public mmc header. Instead make that dependency explicit by including
interrupt.h in those host drivers that depends on it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c  | 1 +
 drivers/mmc/host/dw_mmc.h       | 1 +
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 drivers/mmc/host/mtk-sd.c       | 1 +
 drivers/mmc/host/sdhci.h        | 1 +
 drivers/mmc/host/tmio_mmc.h     | 1 +
 drivers/mmc/host/via-sdmmc.c    | 1 +
 drivers/mmc/host/wmt-sdmmc.c    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 36b5af8..1e2600d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/interrupt.h>
 
 #include <linux/platform_data/mmc-davinci.h>
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9601461..231a46f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -18,6 +18,7 @@
 #include <linux/mmc/core.h>
 #include <linux/dmaengine.h>
 #include <linux/reset.h>
+#include <linux/interrupt.h>
 
 #define MAX_MCI_SLOTS	2
 
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b352760..22bfe5e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interrupt.h>
 
 #define DRIVER_NAME "meson-gx-mmc"
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 10ef2ae..d33828e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/core.h>
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a10a7b6..edf3adf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/interrupt.h>
 
 #include <linux/mmc/host.h>
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9e20bcf..9b22844 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -24,6 +24,7 @@
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 
 #define CTL_SD_CMD 0x00
 #define CTL_ARG_REG 0x04
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 63fac78..6380044 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <linux/mmc/host.h>
 
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5af0055..21ebba8 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
1.9.1

