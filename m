From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 01/12] mmc: mxcmmc: Include interrupt.h in the platform data header
Date: Wed, 11 Jan 2017 12:51:07 +0100
Message-ID: <1484135478-2077-2-git-send-email-ulf.hansson@linaro.org>
References: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36845 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934842AbdAKLvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 06:51:33 -0500
Received: by mail-lf0-f49.google.com with SMTP id o140so80117107lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 03:51:33 -0800 (PST)
In-Reply-To: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mxcmmc platform data header depends on interrupt.h. Don't rely on the
public mmc header host.h to include it, bud instead make that dependency
explicit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/platform_data/mmc-mxcmmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/mmc-mxcmmc.h b/include/linux/platform_data/mmc-mxcmmc.h
index 29115f4..b0fdaa9 100644
--- a/include/linux/platform_data/mmc-mxcmmc.h
+++ b/include/linux/platform_data/mmc-mxcmmc.h
@@ -1,6 +1,7 @@
 #ifndef ASMARM_ARCH_MMC_H
 #define ASMARM_ARCH_MMC_H
 
+#include <linux/interrupt.h>
 #include <linux/mmc/host.h>
 
 struct device;
-- 
1.9.1

