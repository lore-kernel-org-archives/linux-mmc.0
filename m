Return-Path: <SRS0=Bxak=7Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25FC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Jun 2020 13:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A561020823
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Jun 2020 13:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KtRUV29z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgFKN3K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:29:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40832 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgFKN3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jun 2020 09:29:09 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BDNNup014789;
        Thu, 11 Jun 2020 15:28:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=XL9z7/V+U5HkKeCU7/wVDcDZ122tdikkkBnJhib8NcA=;
 b=KtRUV29zz7edVwBG9SxLneT9I1w3neuWasapJHAnklsh3/HW/669sT+tG7cANv17zqXB
 MH+C/GXnJM73SVT8kfe2PGBy5+kNmrvUQyxUXVYibmnhFS2zPcfj4po/VSfNHUvIWlLc
 O5F6JwUdpMo2UYvwt9hEId2B6mFPmwq70iMijmRwYcpRGqGKgOux6RJPdhR0X3BCH+wZ
 wn6ky1hEVNi8Ds2niTQyz9gBWxR4rNCLiyp8nFBSuMzypiDVS4KTo5m7XxHLpiGODWb3
 LLflgi5PkKAP0tECF+bitleKiWtj9dJiwcZJChTvhb43CW87rNTJFPQSdpo6kH+8WiiA Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31jppp0cf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 15:28:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0100E10002A;
        Thu, 11 Jun 2020 15:28:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1F542A48CC;
        Thu, 11 Jun 2020 15:28:52 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Jun 2020 15:28:52
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
Subject: [PATCH] mmc: mmci: add sdio datactrl mask for sdmmc revisions
Date:   Thu, 11 Jun 2020 15:28:39 +0200
Message-ID: <20200611132839.4515-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_14:2020-06-11,2020-06-11 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds datactrl_mask_sdio for sdmmc revisions.
sdmmc revisions used same bit of previous ST variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a69d6a0c2e15..b5a41a7ce165 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -267,6 +267,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.datactrl_any_blocksz	= true,
+	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.busy_timeout		= true,
 	.busy_detect		= true,
@@ -292,6 +293,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.datactrl_any_blocksz	= true,
+	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 5),
 	.dma_lli		= true,
 	.busy_timeout		= true,
-- 
2.17.1

