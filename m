Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498EAC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA88207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WnSGRRC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLQL0r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:26:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53884 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLQL0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:26:47 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBQh7t095669;
        Tue, 17 Dec 2019 05:26:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582003;
        bh=UcXYwCK20UsHhTPz8x7aYSI30oLjPmwYTl2MyT+hcGE=;
        h=From:To:CC:Subject:Date;
        b=WnSGRRC0w7Smlfn1eNmhbWeevy4dBEcqHLZznmKghrdmTZza8ERysPrvPnOXkBz6q
         JRr/ff/Vl+C9g/d66j6+IJDCYui1N6Ps1cS2HxWFpF33DkbpD9seLxx1b7DQ1SPoWA
         PjgUIUFM1uOLnVtu7CMJuZ8ZNl7ozSk3MIuweCLA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHBQh2S066437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 05:26:43 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:26:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:26:42 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBQetu104681;
        Tue, 17 Dec 2019 05:26:41 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <jh80.chung@samsung.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:26:56 +0200
Message-ID: <20191217112656.30860-1-peter.ujfalusi@ti.com>
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
 drivers/mmc/host/dw_mmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fc9d4d000f97..bc5278ab5707 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -833,12 +833,14 @@ static int dw_mci_edmac_init(struct dw_mci *host)
 	if (!host->dms)
 		return -ENOMEM;
 
-	host->dms->ch = dma_request_slave_channel(host->dev, "rx-tx");
-	if (!host->dms->ch) {
+	host->dms->ch = dma_request_chan(host->dev, "rx-tx");
+	if (IS_ERR(host->dms->ch)) {
+		int ret = PTR_ERR(host->dms->ch);
+
 		dev_err(host->dev, "Failed to get external DMA channel.\n");
 		kfree(host->dms);
 		host->dms = NULL;
-		return -ENXIO;
+		return ret;
 	}
 
 	return 0;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

