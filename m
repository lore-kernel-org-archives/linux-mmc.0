Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A22C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbhLWSp2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:45:28 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:38060 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbhLWSp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 13:45:28 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 8296B20617B5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: au1xmmc: propagate errors from platform_get_irq()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Manuel Lauss <manuel.lauss@gmail.com>
Organization: Open Mobile Platform
Message-ID: <f642ef4d-6027-eb2e-0257-1c4f13911aed@omp.ru>
Date:   Thu, 23 Dec 2021 21:45:21 +0300
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

The driver overrides the error codes returned by platform_get_irq() to
-ENODEV. Switch to propagating the error codes upstream.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

 drivers/mmc/host/au1xmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux/drivers/mmc/host/au1xmmc.c
===================================================================
--- linux.orig/drivers/mmc/host/au1xmmc.c
+++ linux/drivers/mmc/host/au1xmmc.c
@@ -969,8 +969,10 @@ static int au1xmmc_probe(struct platform
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0)
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto out3;
+	}
 
 	mmc->ops = &au1xmmc_ops;
 
