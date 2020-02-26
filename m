Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBAC4BA0B
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665062467A
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FyH2pgdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBZIkq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:40:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56302 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbgBZIkn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 03:40:43 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q8crEh027973;
        Wed, 26 Feb 2020 09:40:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=VEAFtOcNCvy1cdPVdvmkbIGYrS+dcDQPVJdYDZN9sAE=;
 b=FyH2pgdDDcpAAXkYwgY31MYgs0vVva2fmMSJCNmTUyw44sN6seW887qiZQdiXKQhik8h
 zt+6KcPvCc04VhY5c193CewEcnHOxQB/bYhe4JuHVGQS+HymJ+6jZxlIAQe0fL4t37Fc
 qTHEl9iERwPBbBDPdWx6FCJkCtycYnNa8My2aCKCDyYNnEQ41trAk4ozCD0+vxB2E/PA
 Jho8l1Vn2t5IEtlenhE0jKyBcw6/xf6sBmsWeptf82t8ShG3dpD/R03+JrzQzGaxXYOJ
 0JzN7wDGqghHPbjZ5KtnReY4k+1yWbsDiARDGV5Evs4IWxkEuw+kAmN79f3eiYRi4MhW tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ydcpgagt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 09:40:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 889ED10002A;
        Wed, 26 Feb 2020 09:40:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BCDC2AC906;
        Wed, 26 Feb 2020 09:40:21 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb 2020 09:40:21
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
Subject: [PATCH 4/4] mmc: mmci: initialize pwr|clk|datactrl_reg with their hardware values
Date:   Wed, 26 Feb 2020 09:40:14 +0100
Message-ID: <20200226084014.5242-5-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226084014.5242-1-ludovic.barre@st.com>
References: <20200226084014.5242-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmci_write_pwr|clk|datactrlreg functions, if the desired value
is equal to corresponding variable (pwr_reg|clk_reg|datactrl_reg),
the value is not written in the register.

At probe pwr|clk|datactrl_reg of mmci_host structure are initialized
to 0 (kzalloc of mmc_alloc_host). But they does not necessarily reflect
hardware value of these registers, if they are used while boot level.
This is problematic, if we want to write 0 in these registers.

This patch initializes pwr|clk|datactrl_reg variables with their
hardware values while probing.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 647567def612..f378ae18d5dc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2085,6 +2085,10 @@ static int mmci_probe(struct amba_device *dev,
 	else if (plat->ocr_mask)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 
+	host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
+	host->clk_reg = readl_relaxed(host->base + MMCICLOCK);
+	host->datactrl_reg = readl_relaxed(host->base + MMCIDATACTRL);
+
 	/* We support these capabilities. */
 	mmc->caps |= MMC_CAP_CMD23;
 
-- 
2.17.1

