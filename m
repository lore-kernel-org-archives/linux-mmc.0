Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F47C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB3F61B2C
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 21:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbhKOVkF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:40:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18894 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348475AbhKOVTG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 16:19:06 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFJuA88014488;
        Mon, 15 Nov 2021 13:15:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0u9v8UoHudJT4C+u2s5L/90f8DkKf49tATsvUyIaKbY=;
 b=OwNWA8MTOI+ZHjvpdkSW8THWR6Ak/Rd8c4FsBA3R8te6S0OS7roDH/HqFVQg35FfKCvu
 6eBJrx/Kipzft0D4LA8BA4qsQ8bT3AwKtFZ7QCxKW8BJ/zYh7EoCe5mvzbnNtzqscvCK
 kawkOuStjAd5D9es7tST4QCE38sWscfsDcbnh7R91RLQGImdqqyjF/wcPXGyl5zGcu3r
 9DCbxa9MOvYczBj1paDR3L6liwLmNrYg28BjKjV5uJXtui0mxol+PLvn9zUnbn7muw/w
 kgPU8mbwLjweP6INvE0kiz79eT8JB/a+5G1KblIn77/rOE6OsqnP5kXiErkOpsokqiJH xw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cbea8m6cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 13:15:55 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 13:15:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 15 Nov 2021 13:15:53 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 74A333F7066;
        Mon, 15 Nov 2021 13:15:53 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <rric@kernel.org>, <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <wbartczak@marvell.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: cavium: Improve request handling by proper use of API
Date:   Mon, 15 Nov 2021 13:15:33 -0800
Message-ID: <20211115211533.6971-1-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -b3q8VeK3NLyoKBr-buD9F8UofQMalgO
X-Proofpoint-ORIG-GUID: -b3q8VeK3NLyoKBr-buD9F8UofQMalgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_15,2021-11-15_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver for cavium/marvell platforms uses directly mrq->done() callback
to signalize the request completion. This method to finalize request
processing is not correct.

Following fix introduces proper use of mmc_request_done() API for
all paths involved into handling MMC core requests.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 drivers/mmc/host/cavium.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 95a41983c6c0..7f82b5fde1f4 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -493,8 +493,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	    (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
 		cleanup_dma(host, rsp_sts);
 
+	mmc_request_done(slot->mmc, req);
 	host->current_req = NULL;
-	req->done(req);
 
 no_req_done:
 	if (host->dmar_fixup_done)
@@ -699,8 +699,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 
 error:
 	mrq->cmd->error = -EINVAL;
-	if (mrq->done)
-		mrq->done(mrq);
+	mmc_request_done(mmc, mrq);
 	host->release_bus(host);
 }
 
-- 
2.17.1

