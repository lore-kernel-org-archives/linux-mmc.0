From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] mmc: sdhci-bcm-kona: Remove unneeded version.h inclusion
Date: Mon,  8 Jul 2013 11:41:51 +0530
Message-ID: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37716 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab3GHG12 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 02:27:28 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so3781136pdj.28
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 23:27:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: csd@broadcom.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

version.h header inclusion is not necessary as detected by
versioncheck.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 87175f9..bca6d55 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/version.h>
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci-pltfm.h"
-- 
1.7.9.5

