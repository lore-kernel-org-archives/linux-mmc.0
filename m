Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31946C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Feb 2021 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E990264E5A
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Feb 2021 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBIOxT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:53:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34736 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230333AbhBIOxS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2021 09:53:18 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119EqOVg010365;
        Tue, 9 Feb 2021 15:52:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=jkq+126ZdVjemrv4dU/imBXG1k5/ptSo3tF+bVxG1F0=;
 b=iW2thFV+TBb6qCzxlj4CeTS/9fHQhuRZXGrQinG3klZTPcAJaMUPbUsXDHDPC2VxlLqj
 seO3kzxgZtBPyHKjhLPyilph+Gx8P7fpz/tNvZxIUGJXLkO0tGjIQp9GWWw9FgJ+nDY6
 4Frh4co2y9ADuPKgP1eHUqeEWNBGQajh6G74guFWhOlv2nsuMvK1qpm2VFUu6NTuyxD3
 GhUoMICBeaW2uE3dYCGqfZZ8oOdne5ul60EUgztPG55KQ0lwL4//2aVO46d5err9fHMX
 ObZcjhQpplD2F4il7wTaDinZzeFXManRb1OwNtw8JQIJ1xQj2hax4lyqWcVr27QTJDwa OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36hrauscfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 15:52:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E846510002A;
        Tue,  9 Feb 2021 15:52:28 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DAAE7241B0B;
        Tue,  9 Feb 2021 15:52:28 +0100 (CET)
Received: from localhost (10.75.127.116) by GPXDAG2NODE6.st.com (10.75.127.70)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021 15:52:28
 +0100
From:   <yann.gautier@foss.st.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>, <adrian.hunter@intel.com>,
        <marex@denx.de>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yann.gautier@foss.st.com>
Subject: [PATCH v2] mmc: mmc_test: use erase_arg for mmc_erase command
Date:   Tue, 9 Feb 2021 15:52:14 +0100
Message-ID: <20210209145214.10518-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG3NODE6.st.com (10.75.127.73) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
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

On STM32MP157C-EV1 board, embedding a THGBMDG5D1LBAIL eMMC, using
MMC_ERASE command with MMC_SECURE_ERASE_ARG may stuck the STM32 SDMMC IP,
if test 37 or test 38 are launched just after a write test, e.g. test 36.
Using the default MMC_ERASE argument from framework with erase_arg,
which default in our case to MMC_DISCARD_ARG does no more trig the
issue.

 [1] commit 01904ff77676 ("mmc: core: Calculate the discard arg only once")

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---

Changes in v2:
- Drop patch 1 from the previous series
- Update comment

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

