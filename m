From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 3/6] mmc: core: sdio_bus.c: Fixed lines > 80 chars
Date: Fri, 19 Oct 2012 01:31:56 +0900
Message-ID: <1350577919-2750-3-git-send-email-antiroot@gmail.com>
References: <n>
 <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.gortmaker@windriver.com, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, rjw@sisk.pl, girish.shivananjappa@linaro.org, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>
List-Id: linux-mmc@vger.kernel.org

I fixed lines over 80 characters per line.

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sdio_bus.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 13146d2..efa30eb 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -27,7 +27,7 @@
 /* show configuration fields */
 #define sdio_config_attr(field, format_string)				\
 static ssize_t								\
-field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
+field##_show(struct device *dev, struct device_attribute *attr, char *buf)\
 {									\
 	struct sdio_func *func;						\
 									\
@@ -39,7 +39,8 @@ sdio_config_attr(class, "0x%02x\n");
 sdio_config_attr(vendor, "0x%04x\n");
 sdio_config_attr(device, "0x%04x\n");
 
-static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct sdio_func *func = dev_to_sdio_func (dev);
 
-- 
1.7.9.5
