Return-Path: <SRS0=C2IL=4Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A364C3F2D1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Feb 2020 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725062084E
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Feb 2020 11:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="u0VIClq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1LvZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:51:25 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:45141 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgB1LvY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2020 06:51:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582890684; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QtBKCgEQ0CxITEJwVveTi/5MS0rgKf7c6wwhfsLlxqo=; b=u0VIClq5fRj9tdoVgfOfr25PYdYhVwdFXxpfMRkQRphsnDuofVJy/7ffFsSVQzLk3sy3dqrB
 xwqOSnI48W7Fsj3GlgrWWZfo6paGU2bmttaq2WYg4d+fQdnmh58UeXN7s0OUz0Zz1isLKDl6
 M5iVzRR1zPx3HWb22FPJQyOQQLo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e58feab.7fdbe0aac570-smtp-out-n01;
 Fri, 28 Feb 2020 11:51:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC5D3C433A2; Fri, 28 Feb 2020 11:51:07 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1759CC43383;
        Fri, 28 Feb 2020 11:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1759CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Disable CQE during SDHC reset
Date:   Fri, 28 Feb 2020 17:20:32 +0530
Message-Id: <1582890639-32072-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When SDHC gets reset (E.g. in suspend/resume path), CQE also gets
reset and goes to disable state. But s/w state still points it as
CQE is in enabled state. Since s/w and h/w states goes out of sync,
it results in s/w request timeout for subsequent CQE requests.

To synchronize CQE s/w and h/w state during SDHC reset,
explicitly disable CQE after reset.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 53b79ee..d7ba3b2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1823,6 +1823,13 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		cqhci_suspend(host->mmc);
+}
+
 static const struct sdhci_msm_variant_ops mci_var_ops = {
 	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
 	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
@@ -1861,7 +1868,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
-	.reset = sdhci_reset,
+	.reset = sdhci_msm_reset,
 	.set_clock = sdhci_msm_set_clock,
 	.get_min_clock = sdhci_msm_get_min_clock,
 	.get_max_clock = sdhci_msm_get_max_clock,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
