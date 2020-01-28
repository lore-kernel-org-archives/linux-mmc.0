Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A120C35246
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138B24685
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mcU2eJYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgA1JG4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:06:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgA1JGy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 04:06:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S93bVb014413;
        Tue, 28 Jan 2020 10:06:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=zSO43Ydnuqcl10iVBmC1jcT/MTvx9uPvlQZoKvLctkI=;
 b=mcU2eJYcLZwerH5KPHQ5LvMME/kra2pdV2CUts17IzBUQMtwuqWaEPrRT0lIlCvRWkkX
 iPXjzHvMu8n6lVGljXUu4Xb7jXGmtQmcvaOpApXSR3Kt4kksjLWwPZT27SkEIOmm+/Hl
 eZ+Y3obrEQRqb5V/Li9BAkom12ZQ9GuCzg2sXrVMNQSQBiUsqbqdf0ZSpj7QBBg5ySMN
 B6mpcMMtZylyKW8rWPO8RELou2lRU/RlOCBL/eiiNlhwVYp2z5YMhArNGotOt8biKJ1v
 UFm+s3/Tz6DMXvHbBNnlz/kr3qlRYe+CADFUQJxS92d9cAkrAtckZu3nWKJV56Ne8L7H bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpaw4se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B21210003D;
        Tue, 28 Jan 2020 10:06:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CDA0212A35;
        Tue, 28 Jan 2020 10:06:41 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:41
 +0100
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
Subject: [PATCH V2 2/9] mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
Date:   Tue, 28 Jan 2020 10:06:29 +0100
Message-ID: <20200128090636.13689-3-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch renames sdmmc_priv struct to sdmmc_idma
which is assigned to host->dma_priv.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 6ccfbbc82c77..df08f6662431 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -20,7 +20,7 @@ struct sdmmc_lli_desc {
 	u32 idmasize;
 };
 
-struct sdmmc_priv {
+struct sdmmc_idma {
 	dma_addr_t sg_dma;
 	void *sg_cpu;
 };
@@ -92,7 +92,7 @@ static void sdmmc_idma_unprep_data(struct mmci_host *host,
 
 static int sdmmc_idma_setup(struct mmci_host *host)
 {
-	struct sdmmc_priv *idma;
+	struct sdmmc_idma *idma;
 
 	idma = devm_kzalloc(mmc_dev(host->mmc), sizeof(*idma), GFP_KERNEL);
 	if (!idma)
@@ -123,7 +123,7 @@ static int sdmmc_idma_setup(struct mmci_host *host)
 static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 
 {
-	struct sdmmc_priv *idma = host->dma_priv;
+	struct sdmmc_idma *idma = host->dma_priv;
 	struct sdmmc_lli_desc *desc = (struct sdmmc_lli_desc *)idma->sg_cpu;
 	struct mmc_data *data = host->data;
 	struct scatterlist *sg;
-- 
2.17.1

