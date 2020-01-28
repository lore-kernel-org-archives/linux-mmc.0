Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0CC33CB3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B33C2467E
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="POcqSICW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgA1JG7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:06:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8612 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbgA1JG6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 04:06:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S93bVd014413;
        Tue, 28 Jan 2020 10:06:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=uwVKjFIFlaDhQtYabxIoz0B6CJflTfSuEcRda3jxomk=;
 b=POcqSICWxXBkWXwU3yLBQ4gMYEIjmvGMVpDFsQm0QJ1SuIRpDWyS8fTq2D41GMXsJXXh
 ByPep/f8kaPqPvMxhXFxveXNTwOVN0yxXNR7W4EFCbDOW0cTnzZBkjmHLGiX6qDrhMQl
 EfXz+2E3Z/StkbpnGnyZhWaqcAocPmgW6we8pQ7tyFIQof8DBOlj70ctqesWfP6mrQe1
 efQQU5+mwgaYQ+jA7ahIOdGW1rc0ai+76/CsMNZoXeEoKMuOik63c+G1kXvRtNUPX2rI
 x3CmD5fcoKghtVufNh4Yl4OZBtjTl/NzferOfwyuAOAqhN1oqEZC/exmP6itvHYvXAZ+ 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpaw4sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88D6B100044;
        Tue, 28 Jan 2020 10:06:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A0A4212A35;
        Tue, 28 Jan 2020 10:06:42 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:42
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
Subject: [PATCH V2 3/9] mmc: mmci: add a reference at mmc_host_ops in mmci struct
Date:   Tue, 28 Jan 2020 10:06:30 +0100
Message-ID: <20200128090636.13689-4-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The variant init function may need to add a mmc_host_ops,
for example to add the execute_tuning support if this feature
is available.
This patch adds mmc_host_ops pointer in mmci struct.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 4 ++--
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e9ffce8d41ea..d0a041c9e6cd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1933,6 +1933,8 @@ static int mmci_probe(struct amba_device *dev,
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->mmc_ops = &mmci_ops;
+	mmc->ops = &mmci_ops;
 
 	/*
 	 * Some variant (STM32) doesn't have opendrain bit, nevertheless
@@ -2072,8 +2074,6 @@ static int mmci_probe(struct amba_device *dev,
 	host->stop_abort.arg = 0;
 	host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
 
-	mmc->ops = &mmci_ops;
-
 	/* We support these PM capabilities. */
 	mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
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

