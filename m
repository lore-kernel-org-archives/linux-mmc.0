Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058BC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7487C2146E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tnFIA5jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfLQL1y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:27:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39476 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQL1y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:27:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBRqda070976;
        Tue, 17 Dec 2019 05:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582072;
        bh=oFT2vKaK/f9ASvdOK2ke2gYmYaB30b49K4lQJ8g+btU=;
        h=From:To:CC:Subject:Date;
        b=tnFIA5jbEh1gN1a2eL0w9MR3q5VhCmgRO6fA9Zq6xWIzmSjSyP3xZ6q8lrpU0HsDw
         ZGJHhF8IdMk/aT1T1FXrZlX4vQTGNDO5M0kJ03Fo1uBHJ26Hr+JOIdv87p72Y1Q38V
         kFXtxPU+c71rcdYlky6g6eKkt2vXVoVLdJk8qLk4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHBRqao117370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 05:27:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:27:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:27:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBRmNu083008;
        Tue, 17 Dec 2019 05:27:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: mxcmmc: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:28:03 +0200
Message-ID: <20191217112803.31161-1-peter.ujfalusi@ti.com>
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
 drivers/mmc/host/mxcmmc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 011b59a3602e..b3d654c688e5 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1121,7 +1121,16 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mxcmci_writel(host, host->default_irq_mask, MMC_REG_INT_CNTR);
 
 	if (!host->pdata) {
-		host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
+		host->dma = dma_request_chan(&pdev->dev, "rx-tx");
+		if (IS_ERR(host->dma)) {
+			if (PTR_ERR(host->dma) == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto out_clk_put;
+			}
+
+			/* Ignore errors to fall back to PIO mode */
+			host->dma = NULL;
+		}
 	} else {
 		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 		if (res) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

