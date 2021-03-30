Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB4C433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8083661864
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 06:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC3Gn6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:43:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14955 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhC3Gnd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 02:43:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8fwz64H6zyNG1;
        Tue, 30 Mar 2021 14:41:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:43:20 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <jh80.chung@samsung.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:40:48 +0800
Message-ID: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 29d2494..0311a37 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2013 Hisilicon Limited.
+ * Copyright (c) 2013 HiSilicon Limited.
  */
 
 #include <linux/bitops.h>
-- 
2.8.1

