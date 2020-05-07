Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77AC38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0612075E
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 08:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGIDt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 04:03:49 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:63882 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgEGIDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 04:03:49 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 May 2020 13:33:46 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 07 May 2020 13:33:44 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 29F4D261C; Thu,  7 May 2020 13:33:43 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V1 4/7] mmc: sdhci-msm: Update DDR_CONFIG as per device tree file
Date:   Thu,  7 May 2020 13:32:11 +0530
Message-Id: <1588838535-6050-5-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Certain platforms require different settings in the
SDCC_HC_REG_DDR_CONFIG register. This setting can change from platform
to platform. So the driver should check whether a particular platform
require a different setting by reading the device tree file and use it.

Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0f7baaf..b879806 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -275,6 +275,7 @@ struct sdhci_msm_host {
 	u32 transfer_mode;
 	bool updated_ddr_cfg;
 	bool uses_tassadar_dll;
+	u32 ddr_config;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -987,7 +988,7 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 		ddr_cfg_offset = msm_offset->core_ddr_config;
 	else
 		ddr_cfg_offset = msm_offset->core_ddr_config_old;
-	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr + ddr_cfg_offset);
+	writel_relaxed(msm_host->ddr_config, host->ioaddr + ddr_cfg_offset);
 
 	if (mmc->ios.enhanced_strobe) {
 		config = readl_relaxed(host->ioaddr +
@@ -1933,6 +1934,19 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.ops = &sdhci_msm_ops,
 };
 
+static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
+		struct sdhci_host *host)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (of_property_read_u32(node, "qcom,ddr-config",
+				&msm_host->ddr_config))
+		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
+}
+
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -1975,6 +1989,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_offset = msm_host->offset;
 
 	sdhci_get_of_property(pdev);
+	sdhci_msm_get_of_property(pdev, host);
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
-- 
2.7.4

