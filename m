Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5AC352A4
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08BF2080C
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJIxF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:53:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:33384 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJIxF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Feb 2020 03:53:05 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F67F1A7073;
        Mon, 10 Feb 2020 09:53:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E0251A7076;
        Mon, 10 Feb 2020 09:53:00 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BC8954030E;
        Mon, 10 Feb 2020 16:52:50 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v3 04/14] mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
Date:   Mon, 10 Feb 2020 16:47:14 +0800
Message-Id: <1581324434-30903-5-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581324434-30903-1-git-send-email-haibo.chen@nxp.com>
References: <1581324434-30903-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When pm_runtime_suspend is run, a call to SCFW power off the SS (SS is a
power domain, usdhc belong to this SS power domain) in which the resource
resides is made. The SCFW can power off the SS if no other resource in
active in that SS. If so, all state associated with all the resources within
the SS that is powered off is lost, this includes the clock rates, clock state
etc. When pm_runtime_resume is called, the SS associated with that resource
is powered up. But the clocks are left in the default state.

This patch restore clock rate in pm_runtime_resume, make sure the
clock is right rather than depending on the default state setting
by SCFW.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b5afa2514c6..6bcdc5743d94 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -162,6 +162,8 @@
 #define ESDHC_FLAG_PMQOS		BIT(13)
 /* The IP state got lost in low power mode */
 #define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
+/* The IP lost clock rate in PM_RUNTIME */
+#define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -225,7 +227,8 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_CQHCI
-			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
 };
 
 struct pltfm_imx_data {
@@ -1698,6 +1701,9 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		pm_qos_add_request(&imx_data->pm_qos_req,
 			PM_QOS_CPU_DMA_LATENCY, 0);
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME)
+		clk_set_rate(imx_data->clk_per, pltfm_host->clock);
+
 	err = clk_prepare_enable(imx_data->clk_ahb);
 	if (err)
 		goto remove_pm_qos_request;
-- 
2.17.1

