Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74365C43219
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Jan 2022 21:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiA0VB7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:01:59 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:53084 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiA0VB7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jan 2022 16:01:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 3CC55208FDF8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] mmc: core: use sysfs_emit() in #define sdio_info_attr()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <b0d9cdda-33f3-1eb0-a76e-26125089e5c5@omp.ru>
Date:   Fri, 28 Jan 2022 00:01:53 +0300
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

sprintf() (still used in #define sdio_info_attr()) is vulnerable to the
buffer overflow.  Use the new-fangled sysfs_emit() instead.

While at it, add spaces around the minus sign...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

Changes in version 2:
- added the same macro change in drivers/mmc/corfe/sdio[_bus].c;
- updated the patch subject.

 drivers/mmc/core/sd.c       |    4 ++--
 drivers/mmc/core/sdio.c     |    4 ++--
 drivers/mmc/core/sdio_bus.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: mmc/drivers/mmc/core/sd.c
===================================================================
--- mmc.orig/drivers/mmc/core/sd.c
+++ mmc/drivers/mmc/core/sd.c
@@ -735,9 +735,9 @@ static ssize_t info##num##_show(struct d
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
@@ -40,9 +40,9 @@ static ssize_t info##num##_show(struct d
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
@@ -52,9 +52,9 @@ static ssize_t info##num##_show(struct d
 												\
 	if (num > func->num_info)								\
 		return -ENODATA;								\
-	if (!func->info[num-1][0])								\
+	if (!func->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", func->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", func->info[num - 1]);						\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
