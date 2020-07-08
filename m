Return-Path: <SRS0=AGpe=AT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAAAC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C087A20772
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGHNM1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:12:27 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24034 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHNM0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jul 2020 09:12:26 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Jul 2020 06:12:25 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 08 Jul 2020 06:12:24 -0700
Received: from vbadigan-linux.qualcomm.com ([10.206.24.109])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Jul 2020 18:42:11 +0530
Received: by vbadigan-linux.qualcomm.com (Postfix, from userid 76677)
        id F1CAF4D31; Wed,  8 Jul 2020 18:42:10 +0530 (IST)
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V1] mmc: sdhci-msm: Set IO pins in low power state during suspend
Date:   Wed,  8 Jul 2020 18:41:20 +0530
Message-Id: <1594213888-2780-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Configure SDHC IO pins with low power configuration when the driver
is in suspend state.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 392d41d57a6e..efd2bae1430c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
 #include <linux/interconnect.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -1352,6 +1353,19 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_msm_hs400(host, &mmc->ios);
 }
 
+static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
+{
+	struct platform_device *pdev = msm_host->pdev;
+	int ret;
+
+	if (level)
+		ret = pinctrl_pm_select_default_state(&pdev->dev);
+	else
+		ret = pinctrl_pm_select_sleep_state(&pdev->dev);
+
+	return ret;
+}
+
 static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
 {
 	if (IS_ERR(mmc->supply.vmmc))
@@ -1596,6 +1610,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 			ret = sdhci_msm_set_vqmmc(msm_host, mmc,
 					pwr_state & REQ_BUS_ON);
 		if (!ret)
+			ret = sdhci_msm_set_pincfg(msm_host,
+					pwr_state & REQ_BUS_ON);
+		if (!ret)
 			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
 		else
 			irq_ack |= CORE_PWRCTL_BUS_FAIL;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

