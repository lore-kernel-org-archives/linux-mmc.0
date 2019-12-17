Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E83C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABED2146E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h2xG2Gwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfLQL3y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:29:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQL3y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:29:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBTqdr071453;
        Tue, 17 Dec 2019 05:29:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582192;
        bh=W8foQHg2N98HNpKe6MWnzh4yOZcYkjym+oBf1iZB36U=;
        h=From:To:CC:Subject:Date;
        b=h2xG2GwiAe0wBy+XNNFuPRybIEq5++un7EFuMkOmeAi3k1qvNPDCGsQjEYkVGNLJs
         tlW/O62DVP4jmok+WQCLAqW/+zNO2m7qYe7a98iIyT1iCTDFm+i2DFI54Gw+mV6AM+
         C/XWJOPVKvVLwjkSscnSD31zlVuJ2An6x+Nc4U9E=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHBTqqd021063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 05:29:52 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:29:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:29:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBTnII086939;
        Tue, 17 Dec 2019 05:29:50 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: pxamci: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:30:04 +0200
Message-ID: <20191217113004.31688-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/pxamci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 024acc1b0a2e..cf36e4e05f46 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -710,17 +710,19 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	host->dma_chan_rx = dma_request_slave_channel(dev, "rx");
-	if (host->dma_chan_rx == NULL) {
+	host->dma_chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_chan_rx)) {
 		dev_err(dev, "unable to request rx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(host->dma_chan_rx);
+		host->dma_chan_rx = NULL;
 		goto out;
 	}
 
-	host->dma_chan_tx = dma_request_slave_channel(dev, "tx");
-	if (host->dma_chan_tx == NULL) {
+	host->dma_chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_chan_tx)) {
 		dev_err(dev, "unable to request tx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(host->dma_chan_tx);
+		host->dma_chan_tx = NULL;
 		goto out;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

