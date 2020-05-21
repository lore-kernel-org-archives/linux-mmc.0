Return-Path: <SRS0=q8Wp=7D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC23C433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077D620829
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="g26+CJ6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgEUPYY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 11:24:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43322 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730346AbgEUPYX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2020 11:24:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590074663; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=JzqbmnEE661B7Lr5dD4p9+wQF60SRux+eXF7ny38bSs=; b=g26+CJ6D1ObbScfiEA5v1itKHhDHvmpJzwg8nLkvZVbQaqm7GKhqiKYI6kVNRlMq6UkVIXAs
 hhtF5fE0As28t4zMW/ncpRDGU5REwidtkNFP2UhyeXFFK3jKp9zNJiUrS9o+zQtmLWulS//F
 v4GepBJO3ZKIaNUupMWGSWK3NiY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec69d268075f6e58c8e33f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 15:24:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3046C433AF; Thu, 21 May 2020 15:24:21 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51234C433CA;
        Thu, 21 May 2020 15:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51234C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 3/3] mmc: sdhci: Allow platform controlled voltage switching
Date:   Thu, 21 May 2020 20:53:35 +0530
Message-Id: <1590074615-10787-4-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

If vendor platform drivers are controlling whole logic of voltage
switching, then sdhci driver no need control vqmmc regulator.
So skip enabling/disable vqmmc from SDHC driver.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1bb6b67..88e5312 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4098,6 +4098,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -4111,9 +4112,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
-	if (ret)
-		return ret;
+	if (!mmc->supply.vqmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		if (ret)
+			return ret;
+		enable_vqmmc  = true;
+	}
 
 	DBG("Version:   0x%08x | Present:  0x%08x\n",
 	    sdhci_readw(host, SDHCI_HOST_VERSION),
@@ -4373,7 +4377,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret) {
+				pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
+					mmc_hostname(mmc), ret);
+				mmc->supply.vqmmc = ERR_PTR(-EINVAL);
+			}
+			host->sdhci_core_to_disable_vqmmc = !ret;
+		}
 
 		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
@@ -4386,12 +4398,6 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
 						    3600000))
 			host->flags &= ~SDHCI_SIGNALING_330;
-
-		if (ret) {
-			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
-				mmc_hostname(mmc), ret);
-			mmc->supply.vqmmc = ERR_PTR(-EINVAL);
-		}
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
@@ -4625,7 +4631,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->sdhci_core_to_disable_vqmmc)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4643,7 +4649,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->sdhci_core_to_disable_vqmmc)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4780,7 +4786,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	destroy_workqueue(host->complete_wq);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->sdhci_core_to_disable_vqmmc)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8d2a096..c7dbc68 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -570,6 +570,7 @@ struct sdhci_host {
 	u32 caps1;		/* CAPABILITY_1 */
 	bool read_caps;		/* Capability flags have been read */
 
+	bool sdhci_core_to_disable_vqmmc;  /* sdhci core can disable vqmmc */
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

