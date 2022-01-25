Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C201C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jan 2022 20:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiAYUbV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:31:21 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:34834 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiAYUbU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2022 15:31:20 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 346362099DB9
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: core: sd: use sysfs_emit() in #define sdio_info_attr()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <b7dd683f-3856-5760-a16b-43f21f706939@omp.ru>
Date:   Tue, 25 Jan 2022 23:31:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
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

 drivers/mmc/core/sd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
