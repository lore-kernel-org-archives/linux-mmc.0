Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784FBC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E54D2176D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mE8VBR9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLQL10 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:27:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51490 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfLQL10 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:27:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBROPO034512;
        Tue, 17 Dec 2019 05:27:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582044;
        bh=uShTc3UwCCyUhD4DHsOkkHHZPds5f89U9rEuCMCBFBg=;
        h=From:To:CC:Subject:Date;
        b=mE8VBR9wDcKlPDZNBY/vEwuBDbKxIRYfnNcZFFjZpV5/hSalgfhi1FOfaQBj5/SWF
         v4BE+4bRACLl2mcNKI0X1Vr+X3azoI8gKVOT1mt7If5Z9Bi1UwHMRg8ZnuyEzxiTIm
         0gi628dCnrfyz6gYAsY8TP/U37l68JJrEnv0Mr14=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBROB9122733;
        Tue, 17 Dec 2019 05:27:24 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:27:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:27:23 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBRL37082677;
        Tue, 17 Dec 2019 05:27:22 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: mmci: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:27:37 +0200
Message-ID: <20191217112737.31024-1-peter.ujfalusi@ti.com>
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
 drivers/mmc/host/mmci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index caaa4687de93..bf9573274481 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -706,10 +706,20 @@ int mmci_dmae_setup(struct mmci_host *host)
 
 	host->dma_priv = dmae;
 
-	dmae->rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
-						     "rx");
-	dmae->tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
-						     "tx");
+	dmae->rx_channel = dma_request_chan(mmc_dev(host->mmc), "rx");
+	if (IS_ERR(dmae->rx_channel)) {
+		int ret = PTR_ERR(dmae->rx_channel);
+		dmae->rx_channel = NULL;
+		return ret;
+	}
+
+	dmae->tx_channel = dma_request_chan(mmc_dev(host->mmc), "tx");
+	if (IS_ERR(dmae->tx_channel)) {
+		if (PTR_ERR(dmae->tx_channel) == -EPROBE_DEFER)
+			dev_warn(mmc_dev(host->mmc),
+				 "Deferred probe for TX channel ignored\n");
+		dmae->tx_channel = NULL;
+	}
 
 	/*
 	 * If only an RX channel is specified, the driver will
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

