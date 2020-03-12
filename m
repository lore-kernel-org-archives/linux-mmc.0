Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594FC1975A
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB1F20724
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nNTIzEET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCLKn2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:43:28 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:50275 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKn2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 06:43:28 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 02CAh4cj016228;
        Thu, 12 Mar 2020 19:43:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 02CAh4cj016228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584009786;
        bh=cUZIHu3WpQthGwKHqTfTR6+eqUmRT0xXwV9Ie8yoyFU=;
        h=From:To:Cc:Subject:Date:From;
        b=nNTIzEETvbJTWfCjfCJ09nCj2Z/kFOqzqEWTxJskoSFJn6XJkaJPq0crXYAxhHJ3N
         p/uuqKfASY3y7q0pgFDHnaaw7YAlWFNtE1i0K0HSsCbNnyMHYqIB+27lVFQtc+CLGg
         rTDwR7gKjLfaQW37M8Cx7Vqfp/Zfxamg/54NcFTP68R63aTRP2JhmpDy1GyKb+NW74
         n51XS/ednndCiU33z39zNB6N3Kc4q6BlBvOoPeSmhGAhGvHNdxzdhS+YmOWWLXMiWm
         qS8z2+9WGjKjFvLIQs8PHR8VpO0xKPDrEeNHR8JA33w7dhJVOHsLFfmQSck3Pn12Hl
         yYwK70uMdPlKw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN for UniPhier
Date:   Thu, 12 Mar 2020 19:42:57 +0900
Message-Id: <20200312104257.21017-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI_PRESET_FOR_* registers are not set for the UniPhier platform
integration. (They are all read as zeros).

Set the SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk flag. Otherwise, the
High Speed DDR mode on the eMMC controller (MMC_TIMING_MMC_DDR52)
would not work.

I split the platform data to give no impact to other platforms,
although the UniPhier platform is currently only the upstream user
of this IP.

The SDHCI_QUIRK2_PRESET_VALUE_BROKEN flag is set if the compatible
string matches to "socionext,uniphier-sd4hc".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 5827d3751b81..e573495f8726 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -11,6 +11,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "sdhci-pltfm.h"
 
@@ -235,6 +236,11 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
+	.ops = &sdhci_cdns_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
 static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
 	.ops = &sdhci_cdns_ops,
 };
@@ -334,6 +340,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
+	const struct sdhci_pltfm_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
@@ -350,8 +357,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		data = &sdhci_cdns_pltfm_data;
+
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
+	host = sdhci_pltfm_init(pdev, data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -431,7 +442,10 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 };
 
 static const struct of_device_id sdhci_cdns_match[] = {
-	{ .compatible = "socionext,uniphier-sd4hc" },
+	{
+		.compatible = "socionext,uniphier-sd4hc",
+		.data = &sdhci_cdns_uniphier_pltfm_data,
+	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
-- 
2.17.1

