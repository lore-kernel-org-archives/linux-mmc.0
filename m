Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F75C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD482082E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M51kOXzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLQLbL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:31:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQLbL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 06:31:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHBV4ff071868;
        Tue, 17 Dec 2019 05:31:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576582264;
        bh=b1QfEFC8XibZPfBlM2ytgyPKblISPpf+cmA5Wv2xaEQ=;
        h=From:To:CC:Subject:Date;
        b=M51kOXzhk8PhiQEHN2mA4YaE/jcZjA5n2O1mPDyCsNKUbTC2XmZRkiolbVyTDx8Td
         uvp/eloJiQl01+gh8S7ndSHKkRUvSw/kqrRt0QZ63aY+q6v9gF0J1/MqZbyZ88HplL
         Da3DLAqG03fv6bP82mMI9GM/JRIzTghHEi/ljgv0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBV4qk130069;
        Tue, 17 Dec 2019 05:31:04 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 05:31:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 05:31:02 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHBUxJR113247;
        Tue, 17 Dec 2019 05:31:00 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <jesper.nilsson@axis.com>,
        <lars.persson@axis.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH] mmc: usdhi6rol0: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 13:31:14 +0200
Message-ID: <20191217113114.32085-1-peter.ujfalusi@ti.com>
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
probing against DMA if needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/usdhi6rol0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 969a34e698f2..9a0b1e4e405d 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -676,12 +676,14 @@ static void usdhi6_dma_request(struct usdhi6_host *host, phys_addr_t start)
 	};
 	int ret;
 
-	host->chan_tx = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	host->chan_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
 	dev_dbg(mmc_dev(host->mmc), "%s: TX: got channel %p\n", __func__,
 		host->chan_tx);
 
-	if (!host->chan_tx)
+	if (IS_ERR(host->chan_tx)) {
+		host->chan_tx = NULL;
 		return;
+	}
 
 	cfg.direction = DMA_MEM_TO_DEV;
 	cfg.dst_addr = start + USDHI6_SD_BUF0;
@@ -691,12 +693,14 @@ static void usdhi6_dma_request(struct usdhi6_host *host, phys_addr_t start)
 	if (ret < 0)
 		goto e_release_tx;
 
-	host->chan_rx = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
+	host->chan_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
 	dev_dbg(mmc_dev(host->mmc), "%s: RX: got channel %p\n", __func__,
 		host->chan_rx);
 
-	if (!host->chan_rx)
+	if (IS_ERR(host->chan_rx)) {
+		host->chan_rx = NULL;
 		goto e_release_tx;
+	}
 
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.src_addr = cfg.dst_addr;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

