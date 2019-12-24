Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E23C2D0D2
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4448820730
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLXHZJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:25:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfLXHZH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:07 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABC8499E2679293C035C;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 1/6] mmc: core: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:10 +0800
Message-ID: <1577172735-18869-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
References: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes coccicheck warning:

drivers/mmc/core/core.c:60:5-16: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5e..be06320 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -57,7 +57,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
  * performance cost, and for other reasons may not always be desired.
  * So we allow it it to be disabled.
  */
-bool use_spi_crc = 1;
+bool use_spi_crc = true;
 module_param(use_spi_crc, bool, 0);

 static int mmc_schedule_delayed_work(struct delayed_work *work,
--
2.7.4

