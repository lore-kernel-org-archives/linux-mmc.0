Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE6C636D7
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 00:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAaAqo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAaAqn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 19:46:43 -0500
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4A2A14D
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 16:46:42 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 827F2280194;
        Tue, 31 Jan 2023 08:46:40 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/3] mmc: sdhci-of-dwcmshc: Add host software queue support
Date:   Tue, 31 Jan 2023 08:46:31 +0800
Message-Id: <1675125991-189452-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675125991-189452-1-git-send-email-shawn.lin@rock-chips.com>
References: <1675125991-189452-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkkYVhlISkhPSB9DT0NJSFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6HBw*GT0IGD8zUSNODBFC
        DzkaC0xVSlVKTUxOSklNS0tKS0NKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhMT0w3Bg++
X-HM-Tid: 0a86054a4c022eb1kusn827f2280194
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index fc917ed..e90fa69 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -20,6 +20,7 @@
 #include <linux/sizes.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
 
@@ -331,6 +332,14 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static void sdhci_dwcmshc_request_done(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
+		return;
+
+	mmc_request_done(host->mmc, mrq);
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -347,6 +356,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
 	.reset			= rk35xx_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.request_done		= sdhci_dwcmshc_request_done,
 };
 
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
@@ -462,6 +472,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct dwcmshc_priv *priv;
 	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
+	struct mmc_hsq *hsq;
 	int err;
 	u32 extra;
 
@@ -515,6 +526,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.request = dwcmshc_request;
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		err = -ENOMEM;
+		goto err_clk;
+	}
+
+	err = mmc_hsq_init(hsq, host->mmc);
+	if (err)
+		goto err_clk;
+
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
 		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
 		if (!rk_priv) {
@@ -607,6 +628,8 @@ static int dwcmshc_suspend(struct device *dev)
 	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
+	mmc_hsq_suspend(host->mmc);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -647,7 +670,11 @@ static int dwcmshc_resume(struct device *dev)
 			return ret;
 	}
 
-	return sdhci_resume_host(host);
+	ret = sdhci_resume_host(host);
+	if (ret)
+		return ret;
+
+	return mmc_hsq_resume(host->mmc);
 }
 #endif
 
-- 
2.7.4

