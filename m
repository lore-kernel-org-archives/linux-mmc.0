Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B6DC3F68F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626D20730
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLXHZJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:25:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLXHZH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:07 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF54E937DA98AD3E0C5E;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:56 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 3/6] mmc: sdhci-msm: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:12 +0800
Message-ID: <1577172735-18869-4-git-send-email-zhengbin13@huawei.com>
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

drivers/mmc/host/sdhci-msm.c:1498:1-23: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/sdhci-msm.c:1611:2-24: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/sdhci-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 71f29ba..91f7ad7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1495,7 +1495,7 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);

 	sdhci_msm_handle_pwr_irq(host, irq);
-	msm_host->pwr_irq_flag = 1;
+	msm_host->pwr_irq_flag = true;
 	sdhci_msm_complete_pwr_irq_wait(msm_host);


@@ -1608,7 +1608,7 @@ static int __sdhci_msm_check_write(struct sdhci_host *host, u16 val, int reg)
 	}

 	if (req_type) {
-		msm_host->pwr_irq_flag = 0;
+		msm_host->pwr_irq_flag = false;
 		/*
 		 * Since this register write may trigger a power irq, ensure
 		 * all previous register writes are complete by this point.
--
2.7.4

