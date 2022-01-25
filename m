Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFEBC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jan 2022 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiAYTpk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:45:40 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:54474 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiAYTnm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2022 14:43:42 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 9F1102061BB2
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: core: bus: use sysfs_emit() in #define MMC_DEV_ATTR()
Organization: Open Mobile Platform
Message-ID: <580252c5-371d-8e9e-4405-bd256cd83a6c@omp.ru>
Date:   Tue, 25 Jan 2022 22:43:33 +0300
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

sprintf() (still used in #define MMC_DEV_ATTR()) is vulnerable to the
buffer overflow.  Use the new-fangled sysfs_emit() instead.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

 drivers/mmc/core/bus.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
 
