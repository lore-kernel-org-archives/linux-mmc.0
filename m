Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BAC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiBHMCW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiBHMCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 07:02:21 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A12C03FEC0
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 04:02:18 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 21A4821214FF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] mmc: core: use sysfs_emit() instead of sprintf()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <717729b2-d65b-c72e-9fac-471d28d00b5a@omp.ru>
Date:   Tue, 8 Feb 2022 15:02:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sprintf() (still used in the MMC core for the sysfs output) is vulnerable
to the buffer overflow.  Use the new-fangled sysfs_emit() instead.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

Changes in version 2:
- added #include <linux/sysfs.h> where it was missing;
- moved  #include <linux/sysfs.h> where it was present (the #includes weren't
  sorted as it seemed at 1st).

 drivers/mmc/core/bus.c      |    9 +++++----
 drivers/mmc/core/bus.h      |    3 ++-
 drivers/mmc/core/mmc.c      |   16 ++++++++--------
 drivers/mmc/core/sd.c       |   27 +++++++++++++--------------
 drivers/mmc/core/sdio.c     |    5 +++--
 drivers/mmc/core/sdio_bus.c |    7 ++++---
 6 files changed, 35 insertions(+), 32 deletions(-)

Index: mmc/drivers/mmc/core/bus.c
===================================================================
--- mmc.orig/drivers/mmc/core/bus.c
+++ mmc/drivers/mmc/core/bus.c
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -34,13 +35,13 @@ static ssize_t type_show(struct device *
 
 	switch (card->type) {
 	case MMC_TYPE_MMC:
-		return sprintf(buf, "MMC\n");
+		return sysfs_emit(buf, "MMC\n");
 	case MMC_TYPE_SD:
-		return sprintf(buf, "SD\n");
+		return sysfs_emit(buf, "SD\n");
 	case MMC_TYPE_SDIO:
-		return sprintf(buf, "SDIO\n");
+		return sysfs_emit(buf, "SDIO\n");
 	case MMC_TYPE_SD_COMBO:
-		return sprintf(buf, "SDcombo\n");
+		return sysfs_emit(buf, "SDcombo\n");
 	default:
 		return -EFAULT;
 	}
Index: mmc/drivers/mmc/core/bus.h
===================================================================
--- mmc.orig/drivers/mmc/core/bus.h
+++ mmc/drivers/mmc/core/bus.h
@@ -9,6 +9,7 @@
 #define _MMC_CORE_BUS_H
 
 #include <linux/device.h>
+#include <linux/sysfs.h>
 
 struct mmc_host;
 struct mmc_card;
@@ -17,7 +18,7 @@ struct mmc_card;
 static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	struct mmc_card *card = mmc_dev_to_card(dev);				\
-	return sprintf(buf, fmt, args);						\
+	return sysfs_emit(buf, fmt, args);					\
 }										\
 static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
 
Index: mmc/drivers/mmc/core/mmc.c
===================================================================
--- mmc.orig/drivers/mmc/core/mmc.c
+++ mmc/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -812,12 +813,11 @@ static ssize_t mmc_fwrev_show(struct dev
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
-	if (card->ext_csd.rev < 7) {
-		return sprintf(buf, "0x%x\n", card->cid.fwrev);
-	} else {
-		return sprintf(buf, "0x%*phN\n", MMC_FIRMWARE_LEN,
-			       card->ext_csd.fwrev);
-	}
+	if (card->ext_csd.rev < 7)
+		return sysfs_emit(buf, "0x%x\n", card->cid.fwrev);
+	else
+		return sysfs_emit(buf, "0x%*phN\n", MMC_FIRMWARE_LEN,
+				  card->ext_csd.fwrev);
 }
 
 static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
@@ -830,10 +830,10 @@ static ssize_t mmc_dsr_show(struct devic
 	struct mmc_host *host = card->host;
 
 	if (card->csd.dsr_imp && host->dsr_req)
-		return sprintf(buf, "0x%x\n", host->dsr);
+		return sysfs_emit(buf, "0x%x\n", host->dsr);
 	else
 		/* return default DSR value */
-		return sprintf(buf, "0x%x\n", 0x404);
+		return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
Index: mmc/drivers/mmc/core/sd.c
===================================================================
--- mmc.orig/drivers/mmc/core/sd.c
+++ mmc/drivers/mmc/core/sd.c
@@ -13,6 +13,7 @@
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -708,18 +709,16 @@ MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr)
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
 
 
-static ssize_t mmc_dsr_show(struct device *dev,
-                           struct device_attribute *attr,
-                           char *buf)
-{
-       struct mmc_card *card = mmc_dev_to_card(dev);
-       struct mmc_host *host = card->host;
-
-       if (card->csd.dsr_imp && host->dsr_req)
-               return sprintf(buf, "0x%x\n", host->dsr);
-       else
-               /* return default DSR value */
-               return sprintf(buf, "0x%x\n", 0x404);
+static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+
+	if (card->csd.dsr_imp && host->dsr_req)
+		return sysfs_emit(buf, "0x%x\n", host->dsr);
+	/* return default DSR value */
+	return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
@@ -735,9 +734,9 @@ static ssize_t info##num##_show(struct d
 												\
 	if (num > card->num_info)								\
 		return -ENODATA;								\
-	if (!card->info[num-1][0])								\
+	if (!card->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", card->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", card->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
Index: mmc/drivers/mmc/core/sdio.c
===================================================================
--- mmc.orig/drivers/mmc/core/sdio.c
+++ mmc/drivers/mmc/core/sdio.c
@@ -7,6 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -40,9 +41,9 @@ static ssize_t info##num##_show(struct d
 												\
 	if (num > card->num_info)								\
 		return -ENODATA;								\
-	if (!card->info[num-1][0])								\
+	if (!card->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", card->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", card->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
Index: mmc/drivers/mmc/core/sdio_bus.c
===================================================================
--- mmc.orig/drivers/mmc/core/sdio_bus.c
+++ mmc/drivers/mmc/core/sdio_bus.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/acpi.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -35,7 +36,7 @@ field##_show(struct device *dev, struct
 	struct sdio_func *func;						\
 									\
 	func = dev_to_sdio_func (dev);					\
-	return sprintf(buf, format_string, args);			\
+	return sysfs_emit(buf, format_string, args);			\
 }									\
 static DEVICE_ATTR_RO(field)
 
@@ -52,9 +53,9 @@ static ssize_t info##num##_show(struct d
 												\
 	if (num > func->num_info)								\
 		return -ENODATA;								\
-	if (!func->info[num-1][0])								\
+	if (!func->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", func->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", func->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
