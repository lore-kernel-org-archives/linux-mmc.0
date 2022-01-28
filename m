Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3BC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Jan 2022 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiA1QrY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:47:24 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:50348 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349936AbiA1QrY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jan 2022 11:47:24 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 41241209835B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: core: sdio_bus: use sysfs_emit() in #define
 sdio_config_attr()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <ff012dc6-9f54-9546-3d2f-ee6f95e0665b@omp.ru>
Date:   Fri, 28 Jan 2022 19:47:19 +0300
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

sprintf() (still used in #define sdio_config_attr()) is vulnerable to the
buffer overflow.  Use the new-fangled sysfs_emit() instead.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
---
 drivers/mmc/core/sdio_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: mmc/drivers/mmc/core/sdio_bus.c
===================================================================
--- mmc.orig/drivers/mmc/core/sdio_bus.c
+++ mmc/drivers/mmc/core/sdio_bus.c
@@ -35,7 +35,7 @@ field##_show(struct device *dev, struct
 	struct sdio_func *func;						\
 									\
 	func = dev_to_sdio_func (dev);					\
-	return sprintf(buf, format_string, args);			\
+	return sysfs_emit(buf, format_string, args);			\
 }									\
 static DEVICE_ATTR_RO(field)
 
