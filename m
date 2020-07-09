Return-Path: <SRS0=IwUb=AU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B779C433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF92207BB
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGINN5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:13:57 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:52437 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGINN5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 09:13:57 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jul 2020 06:13:56 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jul 2020 06:13:54 -0700
Received: from vbadigan-linux.qualcomm.com ([10.206.24.109])
  by ironmsg02-blr.qualcomm.com with ESMTP; 09 Jul 2020 18:43:39 +0530
Received: by vbadigan-linux.qualcomm.com (Postfix, from userid 76677)
        id C0DF94D58; Thu,  9 Jul 2020 18:43:37 +0530 (IST)
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        dan.carpenter@oracle.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V1] mmc: sdhci: Fix potential null pointer access while accessing vqmmc
Date:   Thu,  9 Jul 2020 18:43:25 +0530
Message-Id: <1594300408-17658-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Don't access vqmmc regulator handler, if it's already invalidated.

Fixes: f870b6d480d3 (mmc: sdhci: Allow platform controlled voltage switching)
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e6275c2202b0..d3b62fc5c661 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4383,11 +4383,6 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		if (enable_vqmmc) {
 			ret = regulator_enable(mmc->supply.vqmmc);
-			if (ret) {
-				pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
-					mmc_hostname(mmc), ret);
-				mmc->supply.vqmmc = ERR_PTR(-EINVAL);
-			}
 			host->sdhci_core_to_disable_vqmmc = !ret;
 		}
 
@@ -4402,6 +4397,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
 						    3600000))
 			host->flags &= ~SDHCI_SIGNALING_330;
+
+		if (ret) {
+			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
+				mmc_hostname(mmc), ret);
+			mmc->supply.vqmmc = ERR_PTR(-EINVAL);
+		}
+
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

