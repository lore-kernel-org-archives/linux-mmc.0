Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5056C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 14:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E5964ECE
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 14:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBYO4g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:56:36 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46633 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBYO4f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2021 09:56:35 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PEr8uX015318;
        Thu, 25 Feb 2021 15:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=qCrvlMRtCkTQFfJ0RxV1KE9Dy1D6noU5d5mt7t050ao=;
 b=5HJnUrTYv0tTf8bCqKENBWH3CnTWsFuCgp+wStuf4hd4fVGMXm95EpbzxL8tSTVtBitW
 Duf5ZO/jBMIyV9Mctefm51Pvl3h/AqyO/P+zA+JKuHVXeXeLPBlMiCCQpSxfNvq1YcaH
 7P8YyhCbqqttvdWHNvrdjwfsxw9H3/QyDeYNLGnhHqg5zFqxNfJVDfSJA8rYVDAYcdgc
 CbWv9PaoPP6w3hexZ+WWXkGrO8q4T+O1Q58XrHLEjVKRIH5DC0Y2HCd37WbmI4E1ltvi
 prmVz28kdBTRm1Plpf+4rLMVELhiL5hXnqwEchn2d2Tbe9yp+5JX7AvDCGj0r/zmxtOg Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36w66u6jjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 15:55:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03DD9100034;
        Thu, 25 Feb 2021 15:55:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD585236FDD;
        Thu, 25 Feb 2021 15:55:33 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Feb 2021 15:55:33
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     <ulf.hansson@linaro.org>, <linux@armlinux.org.uk>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <ludovic.barre@st.com>, <marex@denx.de>,
        <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <yann.gautier@foss.st.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] mmc: mmci: manage MMC_CAP_NEED_RSP_BUSY for stm32 variant
Date:   Thu, 25 Feb 2021 15:54:54 +0100
Message-ID: <20210225145454.12780-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To properly manage commands awaiting R1B responses, the capability
MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for stm32 variant.
The issue was seen on STM32MP157C-EV1 board, with an erase command,
with secure erase argument, letting the card stuck, possibly waiting
for 4 hours before timeout.

Fixes: 94fe2580a2f3 ("mmc: core: Enable erase/discard/trim support for all mmc hosts")

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
This is somehow a v2 for patch [1].
Changes:
- Only apply MMC_CAP_NEED_RSP_BUSY to stm32 variant
- Cap the used timeout written to MMCIDATATIMER (when using
MMC_CAP_NEED_RSP_BUSY, cmd->busy_timeout may be greater than
host->max_busy_timeout)

 [1] https://patchwork.kernel.org/project/linux-mmc/patch/20210204120547.15381-2-yann.gautier@foss.st.com/

 drivers/mmc/host/mmci.c             | 8 +++++++-
 drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 17dbc81c221e..89e0e9ccfb71 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1242,7 +1242,13 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;
 
-		clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+		if (host->mmc->caps & MMC_CAP_NEED_RSP_BUSY &&
+		    host->mmc->max_busy_timeout &&
+		    cmd->busy_timeout > host->mmc->max_busy_timeout)
+			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
+		else
+			clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+
 		do_div(clks, MSEC_PER_SEC);
 		writel_relaxed(clks, host->base + MMCIDATATIMER);
 	}
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 51db30acf4dc..2ad577618324 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -522,6 +522,7 @@ void sdmmc_variant_init(struct mmci_host *host)
 
 	host->ops = &sdmmc_variant_ops;
 	host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
 	base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
 	if (IS_ERR(base_dlyb))
-- 
2.17.1

