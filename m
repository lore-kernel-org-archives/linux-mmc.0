Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A0C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC2120721
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KK19vmH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgEZPv0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 11:51:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728301AbgEZPvZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2020 11:51:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFoWYl020753;
        Tue, 26 May 2020 17:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=+vt4wjn/3vceANeKrjrxUTiqAmA4dZtw1P85a9Xcyh0=;
 b=KK19vmH2WM0rXEUIpXEvfQFH0XT6Z+aqHO5LHrkuXMiLXQm1tp4UmeVf8PKAVJcsbXFD
 JXclkLlr92tANo9hlNYDRliAHRO3eedcELlTA3D6JkVoaGKG6GSrA4oZ5632cYjlVk5x
 G+/vjGAUe03PcNjHUoyFT8WXlWbn5aM08o0/P2yhsFbQ8Xgt3FB9t/5Wbn3wWvq74Qnt
 tH3gJSIi1sOWcHPCsIWA3fk1U6MNGGcQ1oeosEeBHj4XsS8+517pOWF5ACSx5ALPFWTg
 8MG5oEqm6mxersBmHV2gcj76J0LG2x562pYQ9JMyJqzfJLHo+NSVG5y3qd3W4ZPMOrkR mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316skw8px6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:51:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 263EA10002A;
        Tue, 26 May 2020 17:51:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DA712C4B37;
        Tue, 26 May 2020 17:51:14 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May 2020 17:51:13
 +0200
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 2/2] mmc: mmci_sdmmc: fix DMA API warning max segment size
Date:   Tue, 26 May 2020 17:51:03 +0200
Message-ID: <20200526155103.12514-3-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526155103.12514-1-ludovic.barre@st.com>
References: <20200526155103.12514-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
WARNING: CPU: 1 PID: 85 at kernel/dma/debug.c:1302 debug_dma_map_sg+0x2a0/0x3cc
mmci-pl18x 58005000.sdmmc: DMA-API: mapping sg segment longer than device claims to support [len=126976] [max=65536]

dma api debug checks and compares the segment size to
dma_get_max_seg_size (dev->dma_parms->max_segment_size),
the sdmmc variant has an internal DMA and should define
its max_segment_size constraint to avoid this warning.

This Patch defines the dev->dma_parms->max_segment_size
with the constraint already set for mmc core
(host->mmc->max_seg_size).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 2965b1c062e1..51db30acf4dc 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -119,20 +119,19 @@ static void sdmmc_idma_unprep_data(struct mmci_host *host,
 static int sdmmc_idma_setup(struct mmci_host *host)
 {
 	struct sdmmc_idma *idma;
+	struct device *dev = mmc_dev(host->mmc);
 
-	idma = devm_kzalloc(mmc_dev(host->mmc), sizeof(*idma), GFP_KERNEL);
+	idma = devm_kzalloc(dev, sizeof(*idma), GFP_KERNEL);
 	if (!idma)
 		return -ENOMEM;
 
 	host->dma_priv = idma;
 
 	if (host->variant->dma_lli) {
-		idma->sg_cpu = dmam_alloc_coherent(mmc_dev(host->mmc),
-						   SDMMC_LLI_BUF_LEN,
+		idma->sg_cpu = dmam_alloc_coherent(dev, SDMMC_LLI_BUF_LEN,
 						   &idma->sg_dma, GFP_KERNEL);
 		if (!idma->sg_cpu) {
-			dev_err(mmc_dev(host->mmc),
-				"Failed to alloc IDMA descriptor\n");
+			dev_err(dev, "Failed to alloc IDMA descriptor\n");
 			return -ENOMEM;
 		}
 		host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
@@ -143,7 +142,7 @@ static int sdmmc_idma_setup(struct mmci_host *host)
 		host->mmc->max_seg_size = host->mmc->max_req_size;
 	}
 
-	return 0;
+	return dma_set_max_seg_size(dev, host->mmc->max_seg_size);
 }
 
 static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
-- 
2.17.1

