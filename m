From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/21] mmc: sdhci: Include leds.h
Date: Fri, 30 Dec 2016 13:47:22 +0100
Message-ID: <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33882 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3MsO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:14 -0500
Received: by mail-lf0-f53.google.com with SMTP id y21so236379147lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:13 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Don't rely on host.h to include the mmc.h header, but instead include it
explicitly because the driver depends on it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0b66f21..a10a7b6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 
 #include <linux/mmc/host.h>
 
-- 
1.9.1

