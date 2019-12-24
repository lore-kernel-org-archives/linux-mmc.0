Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D686AC2D0CF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B175A20722
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXHZG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLXHZF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7BFDD550042D61DF732;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:56 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 5/6] mmc: davinci: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:14 +0800
Message-ID: <1577172735-18869-6-git-send-email-zhengbin13@huawei.com>
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

drivers/mmc/host/davinci_mmc.c:480:1-13: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/davinci_mmc.c:607:1-13: WARNING: Assignment of 0/1 to bool variable
drivers/mmc/host/davinci_mmc.c:1270:3-16: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index f01fecd..fe94907 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -477,7 +477,7 @@ static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 		}
 	}

-	host->do_dma = 1;
+	host->do_dma = true;
 	ret = mmc_davinci_send_dma_request(host, data);

 	return ret;
@@ -604,7 +604,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
 		return;
 	}

-	host->do_dma = 0;
+	host->do_dma = false;
 	mmc_davinci_prepare_data(host, req);
 	mmc_davinci_start_command(host, req->cmd);
 }
@@ -1267,7 +1267,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		if (ret == -EPROBE_DEFER)
 			goto dma_probe_defer;
 		else if (ret)
-			host->use_dma = 0;
+			host->use_dma = false;
 	}

 	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
--
2.7.4

