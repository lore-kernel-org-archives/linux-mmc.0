From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/7] mmc: core: Don't export the to_sdio_driver macro
Date: Tue, 14 Oct 2014 13:45:15 +0200
Message-ID: <1413287120-10914-3-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:52635 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:34 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so8362304lab.14
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:33 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

The macro is only used by the mmc core, so let's move it in there.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c   | 2 ++
 include/linux/mmc/sdio_func.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 5c02367..4805cc6 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -25,6 +25,8 @@
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
+#define to_sdio_driver(d)	container_of(d, struct sdio_driver, drv)
+
 /* show configuration fields */
 #define sdio_config_attr(field, format_string)				\
 static ssize_t								\
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 50f0bc9..aab032a 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -84,8 +84,6 @@ struct sdio_driver {
 	struct device_driver drv;
 };
 
-#define to_sdio_driver(d)	container_of(d, struct sdio_driver, drv)
-
 /**
  * SDIO_DEVICE - macro used to describe a specific SDIO device
  * @vend: the 16 bit manufacturer code
-- 
1.9.1

