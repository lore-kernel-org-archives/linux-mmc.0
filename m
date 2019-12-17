Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0736C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD21207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ealmZETn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLQL2r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:28:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39534 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfLQL2r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:28:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBSZh1071148;
        Tue, 17 Dec 2019 05:28:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582115;
        bh=WL0T9j68qwDD2LuB0VajA7vfBQNu8J+ddVt41j8JUFw=;
        h=From:To:CC:Subject:Date;
        b=ealmZETnusIhW6fnlwU3yO/8BlRM0TFyfgAJluEMsyDAjcm4KrI/fQp985xeyjOAi
         1htmq6faMHMj7nrTa/04EygPzDB6CMSk1rK2Nw+7Cu3ce8rCK61UiEs9zde4Fu4Co/
         F01Ji5Qjv/ro7PDj3juublEsNUNvR9Vs5m09bTjc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBSZMD124925;
        Tue, 17 Dec 2019 05:28:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:28:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:28:35 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBSWdS090173;
        Tue, 17 Dec 2019 05:28:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] mmc: mxs: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:28:47 +0200
Message-ID: <20191217112847.31351-1-peter.ujfalusi@ti.com>
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
 drivers/mmc/host/mxs-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4031217d21c3..d82674aed447 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -623,11 +623,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!ssp->dmach) {
+	ssp->dmach = dma_request_chan(&pdev->dev, "rx-tx");
+	if (IS_ERR(ssp->dmach)) {
 		dev_err(mmc_dev(host->mmc),
 			"%s: failed to request dma\n", __func__);
-		ret = -ENODEV;
+		ret = PTR_ERR(ssp->dmach);
 		goto out_clk_disable;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

