Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED1C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9288961546
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 22:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbhKOWNK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:13:10 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45478 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347665AbhKOV5j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 16:57:39 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFH92rk009780;
        Mon, 15 Nov 2021 13:54:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Fp7sSrYi12PoK34s9rxhk7i7qnnyB6M6Vl8aFstPM70=;
 b=H5XtqrIvn6p+XMwIfZS2xhwMsfGNG2lL4VD1uCdTTeXOw6IPC+wXxxzM/VauSuIRJW8m
 FyGPLUwUr7Srpya88WRDfJZXvM+OiH8bb0EFOC5boOUhHqihEpoX+Y8EK9W5knrkzAcz
 lXef1d9v8+vwD7wJfc6YC288+YkHfdHF131SG4VyEf19XwFKajyWYSyDAjswp5mKA2kC
 cBAkRsG3lsgO8Ftb94NFXqCLJB1f0fVY2Me+g4mWvTaBplLyb+RN3oaa7JvfDFd86ScB
 Qk7ucPg7HpKMA4k7xrPwW4PK+ywJVGF1rBZhvOBrAyoqv83TVQODj4fgANu2cXkKYBht Bg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cbupt946w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 13:54:36 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 13:54:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 15 Nov 2021 13:54:34 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 627CD3F7062;
        Mon, 15 Nov 2021 13:54:34 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <rric@kernel.org>, <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <wbartczak@marvell.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: cavium: Improve request handling by proper use of API
Date:   Mon, 15 Nov 2021 13:54:26 -0800
Message-ID: <20211115215426.1554-1-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115211533.6971-1-wbartczak@marvell.com>
References: <20211115211533.6971-1-wbartczak@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GUY7cQAD4Xb6VwqTTeZB42_K7-ZnQvQQ
X-Proofpoint-GUID: GUY7cQAD4Xb6VwqTTeZB42_K7-ZnQvQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver for cavium/marvell platforms uses directly mrq->done() callback
to signalize the request completion. This method to finalize request
processing is not correct.

Following fix introduces proper use of mmc_request_done() API for
all paths involved into handling MMC core requests.

Changes v1 => v2:
- Added missing variable slot and functionality to retrive
  slot base on bus_id contained in response status register.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 drivers/mmc/host/cavium.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 95a41983c6c0..674cfaf5d64e 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -435,8 +435,10 @@ static void cleanup_dma(struct cvm_mmc_host *host, u64 rsp_sts)
 irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 {
 	struct cvm_mmc_host *host = dev_id;
+	struct cvm_mmc_slot *slot;
 	struct mmc_request *req;
 	u64 emm_int, rsp_sts;
+	int bus_id;
 	bool host_done;
 
 	if (host->need_irq_handler_lock)
@@ -456,6 +458,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 		goto out;
 
 	rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
+	bus_id = get_bus_id(rsp_sts);
+	slot = host->slot[bus_id];  /* bus_id is in a range 0..2 */
 	/*
 	 * dma_val set means DMA is still in progress. Don't touch
 	 * the request and wait for the interrupt indicating that
@@ -493,8 +497,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	    (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
 		cleanup_dma(host, rsp_sts);
 
+	mmc_request_done(slot->mmc, req);
 	host->current_req = NULL;
-	req->done(req);
 
 no_req_done:
 	if (host->dmar_fixup_done)
@@ -699,8 +703,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 
 error:
 	mrq->cmd->error = -EINVAL;
-	if (mrq->done)
-		mrq->done(mrq);
+	mmc_request_done(mmc, mrq);
 	host->release_bus(host);
 }
 
-- 
2.17.1

