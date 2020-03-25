Return-Path: <SRS0=m4Hf=5K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D7C54FD5
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Mar 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD92166E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Mar 2020 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Qnz3PVl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCYOeg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:34:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbgCYOef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2020 10:34:35 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PEXpoT028153;
        Wed, 25 Mar 2020 15:34:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=VEAFtOcNCvy1cdPVdvmkbIGYrS+dcDQPVJdYDZN9sAE=;
 b=Qnz3PVl1O1O6t5UoRQDG0sZ7dh0akxGExXfSZJW0wxquZTC5KBhR1INkYQzgO6c73ZTc
 LE0VH97DiiSaPMdTcHiBuZUVlLUs5sHLRYIK54CnKELEG59c5Es9y+qjbpL8iB3V7TPr
 qFTkl3WzPB6CG+xpedT+Fc6IfWaby3EIdsflItj8fJWyFnGyzY73G5OlNR91UBS3vpvd
 o1nScjliW7MO75YgsAak0tHGLrReXqNZ0apZrBTSSZE5BS5vdglqqqm+wOZLjHO2Xy9S
 D7O+lKfD9gV4TuYMKHRlqmFsCqLNm3hnqH/6ams+yaYHZmwnC1a/Luyi2bhgdVngUMzP +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw995p99d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 15:34:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE701100038;
        Wed, 25 Mar 2020 15:34:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0C562B2527;
        Wed, 25 Mar 2020 15:34:21 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar 2020 15:34:21
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
Subject: [PATCH V2 2/2] mmc: mmci: initialize pwr|clk|datactrl_reg with their hardware values
Date:   Wed, 25 Mar 2020 15:34:09 +0100
Message-ID: <20200325143409.13005-3-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325143409.13005-1-ludovic.barre@st.com>
References: <20200325143409.13005-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_07:2020-03-24,2020-03-25 signatures=0
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

