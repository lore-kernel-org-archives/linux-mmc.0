Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC6FC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E6261BE1
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 16:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhKOQIf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:08:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35860 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236643AbhKOQHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 11:07:52 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFB0QTG014964;
        Mon, 15 Nov 2021 08:04:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=8+4pwPrKISBXsKXOqqXMdZkX46tBf57hggQl4pDKRTs=;
 b=TMCOWZbpdHN1vEnBJjtXjHD3lwBqt3s8Tkl6ts3qxH0FpPwYvpXj9z1OGfxDuSVrAox6
 6sjDKOrJV7YpNnr98X2Dy1ZqmofGg7d++rQXIqO9fDjExxnQq2xTeyK2tiQl6hoAPh+U
 Yaf0WrU7uv7rB4F/ObMDHgLES7pMb/I9GVAWzW+3RQN2YODGQ9Uty2oU3NPhI7SLaok3
 ggYLXfRSmTFE5sf5jR2RJo/7D7PSsMyBrkSR1lomw7jr0TXSuYX2RpIuXHM2qA6vfM3F
 pCZxjAr/47XHQdcAILZiTDpPNx4YW7acyOoebNiarVxi+BFnhZHXhRVha9ugTN6ZnRZV aQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cbea8k0dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 08:04:35 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 08:04:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 15 Nov 2021 08:04:33 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 859723F7041;
        Mon, 15 Nov 2021 08:04:33 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <rric@kernel.org>, <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <wbartczak@marvell.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: cavium: Ensure proper mapping between request and interrupt
Date:   Mon, 15 Nov 2021 08:02:26 -0800
Message-ID: <20211115160226.20885-1-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T7eKzbIN6KJ3Abv2qg-jF2OYp4oWMIhy
X-Proofpoint-ORIG-GUID: T7eKzbIN6KJ3Abv2qg-jF2OYp4oWMIhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_10,2021-11-15_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMC block in octeontx2 uses architecture, where data lines are
shared between up to three supported cards. To keep the track of the
request hardware reports bus_id for the command complete interrupt.
At the same time the driver keeps information about the request on the
fly. This change combines these information to ensure proper mapping
between the request and the response.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 drivers/mmc/host/cavium.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 95a41983c6c0..24ea03f5a7c0 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -438,6 +438,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	struct mmc_request *req;
 	u64 emm_int, rsp_sts;
 	bool host_done;
+	struct cvm_mmc_slot *slot;
+	int bus_id;
 
 	if (host->need_irq_handler_lock)
 		spin_lock(&host->irq_handler_lock);
@@ -455,7 +457,19 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	if (!req)
 		goto out;
 
+	slot = mmc_priv(req->host);
+
+	/* Get response */
 	rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
+	/* Map request to cvm_mmc_slot */
+	bus_id = FIELD_GET(MIO_EMM_RSP_STS_BUS_ID, rsp_sts);
+	if (bus_id != slot->bus_id) {
+		dev_err(mmc_classdev(slot->mmc),
+			"Remapping, request for slot %d, interrupt for %d!\n",
+			slot->bus_id, bus_id);
+		slot = host->slot[bus_id];
+	}
+
 	/*
 	 * dma_val set means DMA is still in progress. Don't touch
 	 * the request and wait for the interrupt indicating that
@@ -493,8 +507,9 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	    (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
 		cleanup_dma(host, rsp_sts);
 
+	if (mrq->done)
+		mrq->done(mrq);
 	host->current_req = NULL;
-	req->done(req);
 
 no_req_done:
 	if (host->dmar_fixup_done)
@@ -669,6 +684,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 		set_wdog(slot, data->timeout_ns);
 
 	WARN_ON(host->current_req);
+	mrq->host = mmc;
 	host->current_req = mrq;
 
 	emm_dma = prepare_ext_dma(mmc, mrq);
@@ -776,6 +792,7 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	mods = cvm_mmc_get_cr_mods(cmd);
 
 	WARN_ON(host->current_req);
+	mrq->host = mmc;
 	host->current_req = mrq;
 
 	if (cmd->data) {
-- 
2.17.1

