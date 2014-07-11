From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: [PATCH 2/3] mmc: sdhci-msm: Remove unnecessary header file inclusion
Date: Fri, 11 Jul 2014 20:48:12 +0300
Message-ID: <1405100893-32107-3-git-send-email-gdjakov@mm-sol.com>
References: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Georgi Djakov <gdjakov@mm-sol.com>
List-Id: linux-mmc@vger.kernel.org

The header <linux/regulator/consumer.h> is unused. Remove it.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 drivers/mmc/host/sdhci-msm.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 40573a5..1a6661e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -16,7 +16,6 @@
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/regulator/consumer.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
 #include <linux/slab.h>
-- 
1.7.9.5
