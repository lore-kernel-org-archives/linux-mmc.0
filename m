Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B1C433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D01022CAF
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgH0PWS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:22:18 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56536 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH0PWN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 11:22:13 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 Aug 2020 08:22:12 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Aug 2020 08:22:10 -0700
Received: from vbadigan-linux.qualcomm.com ([10.206.24.109])
  by ironmsg02-blr.qualcomm.com with ESMTP; 27 Aug 2020 20:51:52 +0530
Received: by vbadigan-linux.qualcomm.com (Postfix, from userid 76677)
        id C251C4F12; Thu, 27 Aug 2020 20:51:49 +0530 (IST)
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        dianders@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Enable restore_dll_config flag for sc7180 target
Date:   Thu, 27 Aug 2020 20:51:28 +0530
Message-Id: <1598541694-15694-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On sc7180 target, issues are observed with HS400 mode due to a
hardware limitation. If sdcc clock is dynamically gated and ungated,
the very next command is failing with command CRC/timeout errors.

To mitigate this issue, DLL phase has to be restored whenever sdcc
clock is gated dynamically. The restore_dll_config ensures this.
Enabling this flag with this change. And simply re-using the sdm845
target configuration for this flag.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a33389037cd..d4c02884cca8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2151,6 +2151,7 @@ static void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sm8250-sdhci", .data = &sm8250_sdhci_var},
+	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
 };
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

