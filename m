Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A16C34050
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AA12464E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgBSIbu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:31:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:38464 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSIbu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:50 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45FBC20054C;
        Wed, 19 Feb 2020 09:31:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8DF4202108;
        Wed, 19 Feb 2020 09:31:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 56491402E2;
        Wed, 19 Feb 2020 16:31:40 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 08/14] mmc: sdhci-esdhc-imx: optimize the strobe dll setting
Date:   Wed, 19 Feb 2020 16:25:51 +0800
Message-Id: <1582100757-20683-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After set the STROBE SLV delay target value, it need to wait some
time to let the usdhc lock the REF and SLV clock. In normal case,
1~2us is enough for imx8/imx6 and imx7d, and 4~5us is enough for
imx7ulp, but when do reboot stress test or do the bind/unbind stress
test, sometimes need to wait about 10us to get the status lock.

This patch optimize delay handle method, only print the warning
message if the status is still not lock after 1ms delay.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6ca01b766604..1ec35cc45fc5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1019,6 +1019,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 strobe_delay;
 	u32 v;
+	int ret;
 
 	/* disable clock before enabling strobe dll */
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
@@ -1044,15 +1045,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
 		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
 	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
-	/* wait 5us to make sure strobe dll status register stable */
-	udelay(5);
-	v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
-	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
-		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status REF not lock!\n");
-	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
+
+	/* wait max 50us to get the REF/SLV lock */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_STROBE_DLL_STATUS, v,
+		((v & ESDHC_STROBE_DLL_STS_REF_LOCK) && (v & ESDHC_STROBE_DLL_STS_SLV_LOCK)), 1, 50);
+	if (ret == -ETIMEDOUT)
 		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status SLV not lock!\n");
+		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
 }
 
 static void esdhc_reset_tuning(struct sdhci_host *host)
-- 
2.17.1

