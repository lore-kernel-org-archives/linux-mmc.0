Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B94C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 14:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC326140D
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 14:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhGAOgn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:36:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:19028 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231698AbhGAOgn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 10:36:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161EXA0w005722;
        Thu, 1 Jul 2021 16:33:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=BhacU+lUcpiJxSRqEHPfs3juLAD8wYNzsOIExMYFlNI=;
 b=uT4sNdWhFcCrsvUggYyxpZUa4XISOwSPRl85zFMLZGaPGo+ELFn76pSh4j8Ceho443tv
 Nt+F0xD/qTbeTSC3mXqMKWpXsPzmn14TCVyRJbCK/h1aoWuORrBMsgXkB9JvID5CDpzo
 8doYEsCedyCkvfAX0Spw9Z3hwmRFsUfXFc8aoh18N5ofq3U/8179x4sntnCdM19NjvW4
 O/6cVPnX4MGwSAwswpPzLFT0nc5ULvllF1oNWO7ZQgEPSf5oPWiEBnpfsXB6kmB6hw8W
 J0KDpeYeW16XVvRw+AnqG9ZApGQrZv5x12Z3NE307ayj7bI8wawAGdL3fyVWMq9/xpMW 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39h7yj6tm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 16:33:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E53D610002A;
        Thu,  1 Jul 2021 16:33:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF93F22D62D;
        Thu,  1 Jul 2021 16:33:56 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Jul 2021 16:33:56
 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: mmci: stm32: check when the voltage switch procedure should be done
Date:   Thu, 1 Jul 2021 16:33:53 +0200
Message-ID: <20210701143353.13188-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

If the card has not been power cycled, it may still be using 1.8V
signaling. This situation is detected in mmc_sd_init_card function and
should be handled in mmci stm32 variant.
The host->pwr_reg variable is also correctly protected with spin locks.

Fixes: 94b94a93e355 ("mmc: mmci_sdmmc: Implement signal voltage callbacks")

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 51db30acf4dc..fdaa11f92fe6 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -479,8 +479,9 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
 	u32 status;
 	int ret = 0;
 
-	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
-		spin_lock_irqsave(&host->lock, flags);
+	spin_lock_irqsave(&host->lock, flags);
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 &&
+	    host->pwr_reg & MCI_STM32_VSWITCHEN) {
 		mmci_write_pwrreg(host, host->pwr_reg | MCI_STM32_VSWITCH);
 		spin_unlock_irqrestore(&host->lock, flags);
 
@@ -492,9 +493,11 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
 
 		writel_relaxed(MCI_STM32_VSWENDC | MCI_STM32_CKSTOPC,
 			       host->base + MMCICLEAR);
+		spin_lock_irqsave(&host->lock, flags);
 		mmci_write_pwrreg(host, host->pwr_reg &
 				  ~(MCI_STM32_VSWITCHEN | MCI_STM32_VSWITCH));
 	}
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	return ret;
 }
-- 
2.17.1

