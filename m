Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8C2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBA32222D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgDPQhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729474AbgDPQhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 12:37:02 -0400
X-Greylist: delayed 22061 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 09:37:00 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D7C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 09:37:00 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4934cp0T3wz1ryXj;
        Thu, 16 Apr 2020 18:36:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4934cm6S0Gz1qr41;
        Thu, 16 Apr 2020 18:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id qQOePZ3Xucm9; Thu, 16 Apr 2020 18:36:55 +0200 (CEST)
X-Auth-Info: a4i2LNwtTUy3CIjQVHWOhbyQuAHbEyng2TjowzdDeF4=
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz [86.49.35.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Apr 2020 18:36:54 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2 1/3] mmc: Prepare all code for mmc_regulator_set_vqmmc() returning > 0
Date:   Thu, 16 Apr 2020 18:36:47 +0200
Message-Id: <20200416163649.336967-1-marex@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Patch all drivers which use mmc_regulator_set_vqmmc() and prepare them for
the fact that mmc_regulator_set_vqmmc() can return a value > 0, which would
happen if the signal voltage switch did NOT happen, because the voltage was
already set correctly.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Patrick Delaunay <patrick.delaunay@st.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-mmc@vger.kernel.org
---
V2: Patch only mmc_regulator_set_vqmmc()
---
 drivers/mmc/host/dw_mmc-k3.c         |  2 ++
 drivers/mmc/host/dw_mmc.c            |  2 ++
 drivers/mmc/host/meson-gx-mmc.c      |  7 ++++++-
 drivers/mmc/host/mtk-sd.c            |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c |  2 ++
 drivers/mmc/host/sdhci-sprd.c        |  2 ++
 drivers/mmc/host/sdhci.c             |  6 ++++++
 drivers/mmc/host/sunxi-mmc.c         | 10 ++++++++--
 drivers/mmc/host/usdhi6rol0.c        |  2 ++
 9 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23b6f65b3785..695e29452367 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -424,6 +424,8 @@ static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
 		if (ret) {
 			dev_err(host->dev, "Regulator set error %d\n", ret);
 			return ret;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc5278ab5707..3f82170f1d98 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1546,6 +1546,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
 
 		if (ret) {
 			dev_dbg(&mmc->class_dev,
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 35400cf2a2e4..79e15fa6f4fd 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1004,6 +1004,8 @@ static int meson_mmc_card_busy(struct mmc_host *mmc)
 
 static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	int ret;
+
 	/* vqmmc regulator is available */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		/*
@@ -1013,7 +1015,10 @@ static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * to 1.8v. Please make sure the regulator framework is aware
 		 * of your own regulator constraints
 		 */
-		return mmc_regulator_set_vqmmc(mmc, ios);
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
+		return ret;
 	}
 
 	/* no vqmmc regulator, assume fixed regulator at 3/3.3V */
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b221c02cc71f..9688797f097d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1379,6 +1379,8 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
 		if (ret) {
 			dev_dbg(host->dev, "Regulator set error %d (%d)\n",
 				ret, ios->signal_voltage);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 68432bb0255b..7ffe17bb1e62 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -237,6 +237,8 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
 
 	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
+	if (ret > 0)
+		ret = 0;
 	if (ret)
 		return ret;
 
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 60c3a4c620f9..2a27af3eceef 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -434,6 +434,8 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
 		if (ret) {
 			pr_err("%s: Switching signalling voltage failed\n",
 			       mmc_hostname(mmc));
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 344a7e0e33fe..a100fb633b40 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2411,6 +2411,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret > 0)
+				ret = 0;
 			if (ret) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
 					mmc_hostname(mmc));
@@ -2434,6 +2436,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret > 0)
+				ret = 0;
 			if (ret) {
 				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
 					mmc_hostname(mmc));
@@ -2466,6 +2470,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret > 0)
+				ret = 0;
 			if (ret) {
 				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
 					mmc_hostname(mmc));
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f87d7967457f..f70a4249b72b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -951,9 +951,15 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	int ret;
+
 	/* vqmmc regulator is available */
-	if (!IS_ERR(mmc->supply.vqmmc))
-		return mmc_regulator_set_vqmmc(mmc, ios);
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret > 0)
+			ret = 0;
+		return ret;
+	}
 
 	/* no vqmmc regulator, assume fixed regulator at 3/3.3V */
 	if (mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 9a0b1e4e405d..72e698071ddf 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1174,6 +1174,8 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	int ret;
 
 	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret > 0)
+		ret = 0;
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

