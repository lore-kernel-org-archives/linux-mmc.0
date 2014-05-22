From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: moxart: Remove unneeded version.h inclusion
Date: Thu, 22 May 2014 09:36:45 +0530
Message-ID: <1400731605-1261-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38742 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaEVEI6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 00:08:58 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2071096pab.20
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2014 21:08:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org, Jonas Jensen <jonas.jensen@gmail.com>

version.h inclusion is not needed as suggested by versioncheck.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 74924a04026e..b4b1efbf6c16 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -13,7 +13,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-- 
1.7.9.5

