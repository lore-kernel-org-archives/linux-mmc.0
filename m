Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62EC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745A864F4D
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhBDMJc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:09:32 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48254 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235780AbhBDMJW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 07:09:22 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114C6Zi0001073;
        Thu, 4 Feb 2021 13:08:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=hKdh8j5aVw57wAARGdh1edMyPc08Kuhr9x92Z86r6lk=;
 b=GrXsxFMnZeyvxBMea7KFLU8rl6PfdCEcEtvvkt1dfwJ+kXsQdpNR0kICu2U0a59k8yE8
 ie4USfrnhD2oTWrok6O+pUZkjomSWDlrMW/cfMsfNkAmUr6FjDrNl3VN2WHc8aMGhSqU
 XlwLwO5MkhEqCWAZhCUc/SLwgWSxko/Bi8ttgeUwnKdBQlMeCwu/nBogZXFYiWofHoJ7
 0XmDFUUkREvl8PYhQ0z1BfY7qJb4/8bYtDK2KMjnE31oR4L6TXPwAI44PMJ6aitwpGRV
 pIoRhhoO077efZDbIPinXPgM1b+2pOd5F+EHv2kBdS7hZPMyc3e6iRqw6Zf203XaoK06 QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ey7h8q53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:08:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A7EC100038;
        Thu,  4 Feb 2021 13:08:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 658D9244FA0;
        Thu,  4 Feb 2021 13:08:16 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb 2021 13:08:16
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
Subject: [PATCH 2/2] mmc: mmc_test: use erase_arg for mmc_erase command
Date:   Thu, 4 Feb 2021 13:05:47 +0100
Message-ID: <20210204120547.15381-3-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204120547.15381-1-yann.gautier@foss.st.com>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yann Gautier <yann.gautier@foss.st.com>

Since [1], the erase argument for mmc_erase() function is saved in
erase_arg field of card structure. It is preferable to use it instead of
hard-coded MMC_SECURE_ERASE_ARG, which from eMMC 4.51 spec is not
recommended:
"6.6.16 Secure Erase
NOTE Secure Erase is included for backwards compatibility. New system
level implementations (based on v4.51 devices and beyond) should use
Erase combined with Sanitize instead of secure erase."

 [1] commit 01904ff77676 ("mmc: core: Calculate the discard arg only once")

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/core/mmc_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 39a478874ca3..63524551a13a 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2110,7 +2110,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
 	if (mmc_can_erase(test->card) &&
 	    tdata->prepare & MMC_TEST_PREP_ERASE) {
 		ret = mmc_erase(test->card, dev_addr,
-				size / 512, MMC_SECURE_ERASE_ARG);
+				size / 512, test->card->erase_arg);
 		if (ret)
 			ret = mmc_erase(test->card, dev_addr,
 					size / 512, MMC_ERASE_ARG);
-- 
2.17.1

