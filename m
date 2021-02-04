Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E67DC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EB264F51
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhBDMJX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:09:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59598 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235613AbhBDMJW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 07:09:22 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114C7OfA002463;
        Thu, 4 Feb 2021 13:08:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=knnFC5EElsl1GnCYaHjJvXkjTjuPRkzwzpeb4uOvYGk=;
 b=U+un6RgcWlk+XZgZUonXqHPw3lgDotws/lCq1dRi5+A7bW5OllpmGBfk31fvwpRq7ZB1
 UdF3CrrKb7EPlsnDS5zoNeKr0tv6TTJhDgRxim9tD+xy77XD3Ky5JMNEt7TRTPo1cqLw
 uj8dBd6QCbHJlE8Qtn/ifPGj8M6VuBggGgT2ch9cfATbAsVG4FX/L9TXJoWgDFqduPkP
 qL+Qcj7ZbTFOsqjbEUggVBqomRweieE75qE7FPdqZRyX7UbUNPj0mxmsqLOhauMoB2Jg
 BqU25HBAlc0aMYsA13KdDH6psTE5zlDHTr1heFEG6fVpzNTof7lZFb1wJlyKz6MYxvPS Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36e7x17q5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:08:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4B3B100034;
        Thu,  4 Feb 2021 13:08:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC713244F9F;
        Thu,  4 Feb 2021 13:08:15 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb 2021 13:08:15
 +0100
From:   <yann.gautier@foss.st.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>, <per.forlin@linaro.org>,
        <huyue2@yulong.com>, <wsa+renesas@sang-engineering.com>,
        <vbadigan@codeaurora.org>, <adrian.hunter@intel.com>,
        <p.zabel@pengutronix.de>, <marex@denx.de>, <swboyd@chromium.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yann.gautier@foss.st.com>
Subject: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
Date:   Thu, 4 Feb 2021 13:05:46 +0100
Message-ID: <20210204120547.15381-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204120547.15381-1-yann.gautier@foss.st.com>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yann Gautier <yann.gautier@foss.st.com>

To properly manage commands awaiting R1B responses, the capability
MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
manage busy detection.
This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
MMC_CAP_WAIT_WHILE_BUSY to be enabled together.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1bc674577ff9..bf6971fdd1a6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
 		if (variant->busy_dpsm_flag)
 			mmci_write_datactrlreg(host,
 					       host->variant->busy_dpsm_flag);
-		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 	}
 
 	/* Prepare a CMD12 - needed to clear the DPSM on some variants. */
-- 
2.17.1

