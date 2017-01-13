From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 02/15] ARM: davinci: Don't rely on public mmc header to include leds.h
Date: Fri, 13 Jan 2017 14:14:03 +0100
Message-ID: <1484313256-25993-3-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33274 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdAMNOk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:14:40 -0500
Received: by mail-lf0-f45.google.com with SMTP id k86so37147208lfi.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 05:14:40 -0800 (PST)
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org

Some of the davinci boards, da850-evm, dm644x-evm and neuros-osd2 depends
on leds.h. Explicitly include it instead of relying on the public mmc
header host.h.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I am seeking an ack for this change as following changes for mmc in the
series, has build-dependencies to it.

---
 arch/arm/mach-davinci/board-da850-evm.c   | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c  | 1 +
 arch/arm/mach-davinci/board-neuros-osd2.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index aac3ab1..df3ca38 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -18,6 +18,7 @@
 #include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
 #include <linux/platform_data/pca953x.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 521e4097..023480b 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -25,6 +25,7 @@
 #include <linux/videodev2.h>
 #include <linux/v4l2-dv-timings.h>
 #include <linux/export.h>
+#include <linux/leds.h>
 
 #include <media/i2c/tvp514x.h>
 
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index ad10017..0a78388 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -25,6 +25,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/i2c-davinci.h>
-- 
1.9.1

