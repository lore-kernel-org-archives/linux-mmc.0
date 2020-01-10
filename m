Return-Path: <SRS0=mkSb=27=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01818C33CA5
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7020838
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="d6s1gU+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgAJNtV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:49:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44901 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbgAJNtT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:19 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADlv1F031938;
        Fri, 10 Jan 2020 14:49:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=pJ+w24JgyaLP7e1zcwVqY+8juR4jhF3VPSq9PUdMLDs=;
 b=d6s1gU+HpUA+w/3J0NhO2Gvv+WMnIUxtSrvSrBmSW+jaTCigaI6851ohSaJ0hmAovPSs
 iUMCLVHUSEPgXVze4mlhSNnCdvQFFFQM3l3p8vB+4RoPhngooIhOoEhEE29xSYLOzGch
 zW6bvjAME+JIjOGOUNte9YJCH6dJdiIkXUaTBWczcx6hPQx4/FgUUdT6l9z6FeVjIfWw
 OuIcc1ONFCrtt//4bTTAP3pW2APzzO9TQjBpviKH7g2I4TO4OuCxj5v7z6dGfkdzGcOc
 DKhG8wRCOdR8E0DBPgt5Zy6oZZO4/G+9yrxx7Z7g+k8OUR2RXZuD5xQ5LrWCbMDG81/l CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur7dud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9009010003D;
        Fri, 10 Jan 2020 14:49:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 827A82BC7D1;
        Fri, 10 Jan 2020 14:49:06 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:49:05
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
Subject: [PATCH 9/9] mmc: mmci: add sdmmc variant revision 2.0
Date:   Fri, 10 Jan 2020 14:48:23 +0100
Message-ID: <20200110134823.14882-10-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds a sdmmc variant revision 2.0.
This revision is backward compatible with 1.1, and adds dma
link list support.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d76a59c06cb0..2a570cbf6f69 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -275,6 +275,31 @@ static struct variant_data variant_stm32_sdmmc = {
 	.init			= sdmmc_variant_init,
 };
 
+static struct variant_data variant_stm32_sdmmcv2 = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.f_max			= 208000000,
+	.stm32_clkdiv		= true,
+	.cmdreg_cpsm_enable	= MCI_CPSM_STM32_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
+	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
+	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
+	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
+	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
+	.datactrl_first		= true,
+	.datacnt_useless	= true,
+	.datalength_bits	= 25,
+	.datactrl_blocksz	= 14,
+	.datactrl_any_blocksz	= true,
+	.stm32_idmabsize_mask	= GENMASK(16, 5),
+	.dma_lli		= true,
+	.busy_timeout		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.init			= sdmmc_variant_init,
+};
+
 static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -2334,6 +2359,11 @@ static const struct amba_id mmci_ids[] = {
 		.mask	= 0xf0ffffff,
 		.data	= &variant_stm32_sdmmc,
 	},
+	{
+		.id     = 0x00253180,
+		.mask	= 0xf0ffffff,
+		.data	= &variant_stm32_sdmmcv2,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
2.17.1

