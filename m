Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A2C433F1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DE32075A
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgG0RL0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:11:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727815AbgG0RL0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jul 2020 13:11:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0FB6E238D3403D437591;
        Tue, 28 Jul 2020 01:01:46 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 01:01:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] mmc: mediatek: make function msdc_cqe_disable() static
Date:   Tue, 28 Jul 2020 01:11:29 +0800
Message-ID: <20200727171129.2945-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sparse tool complains as follows:

drivers/mmc/host/mtk-sd.c:2269:6: warning:
 symbol 'msdc_cqe_disable' was not declared. Should it be static?

This function is not used outside of mtk-sd.c, so this commit
marks it static.

Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 734e403a142e..4e2583f69a63 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2266,7 +2266,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
 	msdc_set_timeout(host, 1000000000ULL, 0);
 }
 
-void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
+static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 

