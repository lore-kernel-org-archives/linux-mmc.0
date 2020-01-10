Return-Path: <SRS0=mkSb=27=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E41C282DD
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192A320842
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CGTpbbf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgAJNtJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:49:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24874 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbgAJNtJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADlv1B031938;
        Fri, 10 Jan 2020 14:49:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=e3/+5F1+4ZDcoT1rkTHB66TYtSZtt3BJjlXvbjrPdfs=;
 b=CGTpbbf8kz7sRr9aPHV01zn091LlVWN/aSeu3HV4zreUezecGO27cx61JzEQ1cujWj5F
 WG2apU3Jgw05rCyfTPSkL95LovNkVeemJSyeQuv98/dTs3snrglPIaqu+y3BiC7EJZQs
 aPxwDmf6VdqTD9yVxASLN0jqOnvHAMXx8mB75FppH7dMHOLcP4GK7+lq1vlJ1TriaYPq
 ZuMNW7Z3WCwPN1X1+69X2F4xgcBZKxb+lqRvZl7BEyUnlW2WNVesHcv2dpO2GwpmJkyC
 H/3i/D1JKU+zQD/5F8uc3fa6SSw+nJ0mFE3myYKwUpctx3Y78TbqEc3Ev0Inf0/m6We5 /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur7dtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3099410002A;
        Fri, 10 Jan 2020 14:49:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 229E62BC7D1;
        Fri, 10 Jan 2020 14:49:00 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:48:59
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
Subject: [PATCH 3/9] mmc: mmci: add a reference at mmc_host_ops in mmci struct
Date:   Fri, 10 Jan 2020 14:48:17 +0100
Message-ID: <20200110134823.14882-4-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds mmc_host_ops pointer in mmci struct.
The variant init function may need to add a mmc_host_ops,
for example to add the execute_tuning support if this feature
is available.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 1 +
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7b13d66cbb21..00b473f57047 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1923,6 +1923,7 @@ static int mmci_probe(struct amba_device *dev,
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->mmc_ops = &mmci_ops;
 
 	/*
 	 * Some variant (STM32) doesn't have opendrain bit, nevertheless
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ea6a0b5779d4..55acc0971a44 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -407,6 +407,7 @@ struct mmci_host {
 	u32			mask1_reg;
 	u8			vqmmc_enabled:1;
 	struct mmci_platform_data *plat;
+	struct mmc_host_ops	*mmc_ops;
 	struct mmci_host_ops	*ops;
 	struct variant_data	*variant;
 	struct pinctrl		*pinctrl;
-- 
2.17.1

