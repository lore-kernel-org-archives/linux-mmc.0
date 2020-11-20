Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0620C5519F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 07:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D713222BA
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 07:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKTHoV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:44:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgKTHoT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2020 02:44:19 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcpTC0ZjNzhdbq;
        Fri, 20 Nov 2020 15:43:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:06 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] memstick: fix a double-free bug in memstick_check
Date:   Fri, 20 Nov 2020 15:48:46 +0800
Message-ID: <20201120074846.31322-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

kfree(host->card) has been called in put_device so that
another kfree would raise cause a double-free bug.

Fixes: 0193383a5833 ("memstick: core: fix device_register() error handling")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/memstick/core/memstick.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index ef03d6faf..12bc3f5a6 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -468,7 +468,6 @@ static void memstick_check(struct work_struct *work)
 			host->card = card;
 			if (device_register(&card->dev)) {
 				put_device(&card->dev);
-				kfree(host->card);
 				host->card = NULL;
 			}
 		} else
-- 
2.23.0

