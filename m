Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB71C352B6
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02CF206E9
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XxlJNnSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02CF206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgDLQFH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgDLQFG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 12:05:06 -0400
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info [104.130.122.26])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 1D07EC0A3BF8
        for <linux-mmc@vger.kernel.org>; Sun, 12 Apr 2020 08:55:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586706908; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=G0IVSqUYz/8wJebDih7bRYd54GdC/msoqfEttLT3yok=; b=XxlJNnSZ+Q3KTtlaEyCCdFkhVhFveb/QoO8EVtaYII3PHDaLg4pGF8Pe3+FwxK8cyk4ZwEQa
 LxMGlVZdMuq5dpZZ4eOjCXFMWfM7wTtDdGfiopWaS0PUBApWyT7gi9/5L/18qNBPbkGgJDUj
 s8e1ef9JznlfGUJyFReYvuKP/Bk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9339d2.7f9f37eed6f8-smtp-out-n04;
 Sun, 12 Apr 2020 15:54:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CB64C433BA; Sun, 12 Apr 2020 15:54:57 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3332AC433F2;
        Sun, 12 Apr 2020 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3332AC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V1 3/4] mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
Date:   Sun, 12 Apr 2020 21:23:27 +0530
Message-Id: <1586706808-27337-4-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
References: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci-msm can support auto cmd12.
So enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index d826e9b..482045b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1882,7 +1882,9 @@ static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
-		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_msm_ops,
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
