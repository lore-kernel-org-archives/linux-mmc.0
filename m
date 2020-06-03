Return-Path: <SRS0=STY7=7Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F518C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Jun 2020 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8052B2068D
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Jun 2020 09:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgFCJL0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:11:26 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:25968 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgFCJL0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jun 2020 05:11:26 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jun 2020 14:40:19 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 03 Jun 2020 14:39:50 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 211865047; Wed,  3 Jun 2020 14:39:50 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc-owner@vger.kernel.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, matthias@chromium.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V1 1/2] mmc: sdhci-msm: Add interconnect bandwidth scaling support
Date:   Wed,  3 Jun 2020 14:39:35 +0530
Message-Id: <1591175376-2374-2-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1591175376-2374-1-git-send-email-ppvk@codeaurora.org>
References: <1591175376-2374-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Interconnect bandwidth scaling support is now added as a
part of OPP [1]. So, make sure interconnect driver is ready
before handling interconnect scaling.

This change is based on
[1] [Patch v8] Introduce OPP bandwidth bindings
(https://lkml.org/lkml/2020/5/12/493)

[2] [Patch v3] mmc: sdhci-msm: Fix error handling
for dev_pm_opp_of_add_table()
(https://lkml.org/lkml/2020/5/5/491)

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b277dd7..bf95484 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -1999,6 +2000,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_msm_host *msm_host;
 	struct clk *clk;
+	struct icc_path *sdhc_path;
 	int ret;
 	u16 host_version, core_minor;
 	u32 core_version, config;
@@ -2070,6 +2072,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 	msm_host->bulk_clks[0].clk = clk;
 
+	/* Make sure that ICC driver is ready for interconnect bandwdith
+	 * scaling before registering the device for OPP.
+	 */
+	sdhc_path = of_icc_get(&pdev->dev, NULL);
+	ret = PTR_ERR_OR_ZERO(sdhc_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_info(&pdev->dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(&pdev->dev, "failed to get icc path:%d\n", ret);
+		goto bus_clk_disable;
+	}
+	icc_put(sdhc_path);
+
 	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
 	if (IS_ERR(msm_host->opp_table)) {
 		ret = PTR_ERR(msm_host->opp_table);
-- 
1.9.1

