Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6FC43331
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3A2206F6
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgDAT5u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:57:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55144 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732780AbgDAT5u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 15:57:50 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48sxnQ0MVWz1qrLT;
        Wed,  1 Apr 2020 21:57:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48sxnP56Fpz1r0cc;
        Wed,  1 Apr 2020 21:57:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 210JVslIAnS6; Wed,  1 Apr 2020 21:57:43 +0200 (CEST)
X-Auth-Info: dPOQSMtZ/hOyv/EFlEgFhITIcVya3DR+6Zw6uASdfiA=
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz [86.49.35.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  1 Apr 2020 21:57:43 +0200 (CEST)
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
Subject: [PATCH 1/3] mmc: Prepare all code for mmc_set_signal_voltage() returning > 0
Date:   Wed,  1 Apr 2020 21:57:20 +0200
Message-Id: <20200401195722.208157-1-marex@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Patch all drivers and core code which uses mmc_set_signal_voltage()
and prepare it for the fact that mmc_set_signal_voltage() can return
a value > 0, which would happen if the signal voltage switch did NOT
happen, because the voltage was already set correctly.

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
 drivers/mmc/core/core.c              | 10 +++++-----
 drivers/mmc/core/mmc.c               | 16 ++++++++--------
 drivers/mmc/host/dw_mmc-k3.c         |  2 +-
 drivers/mmc/host/dw_mmc.c            |  3 +--
 drivers/mmc/host/mtk-sd.c            |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  2 +-
 drivers/mmc/host/sdhci-sprd.c        |  2 +-
 drivers/mmc/host/sdhci.c             |  6 +++---
 8 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c5de6d37ac7..98a3552205cb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1142,7 +1142,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	if (host->ops->start_signal_voltage_switch)
 		err = host->ops->start_signal_voltage_switch(host, &host->ios);
 
-	if (err)
+	if (err < 0)
 		host->ios.signal_voltage = old_signal_voltage;
 
 	return err;
@@ -1152,11 +1152,11 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 void mmc_set_initial_signal_voltage(struct mmc_host *host)
 {
 	/* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
-	if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330))
+	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) >= 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 3.3v\n");
-	else if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
+	else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) >= 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 1.8v\n");
-	else if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120))
+	else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) >= 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 1.2v\n");
 }
 
@@ -1172,7 +1172,7 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
 	host->ios.clock = 0;
 	mmc_set_ios(host);
 
-	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
+	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) < 0)
 		return -EAGAIN;
 
 	/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index de94fbe629bd..9f5aae051f6d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1121,7 +1121,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	 */
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
-		if (!err)
+		if (err >= 0)
 			return 0;
 	}
 
@@ -1130,7 +1130,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* make sure vccq is 3.3v after switching disaster */
-	if (err)
+	if (err < 0)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
 	return err;
@@ -1339,11 +1339,11 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
-	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
+	if (err < 0 && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* If fails try again during next card power cycle */
-	if (err)
+	if (err < 0)
 		goto out_err;
 
 	err = mmc_select_bus_width(card);
@@ -1437,11 +1437,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
-	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
+	if (err < 0 && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* If fails try again during next card power cycle */
-	if (err)
+	if (err < 0)
 		return err;
 
 	mmc_select_driver_type(card);
@@ -1480,7 +1480,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 err:
 	if (err) {
 		/* fall back to the old signal voltage, if fails report error */
-		if (mmc_set_signal_voltage(host, old_signal_voltage))
+		if (mmc_set_signal_voltage(host, old_signal_voltage) < 0)
 			err = -EIO;
 
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
@@ -1769,7 +1769,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
 			err = mmc_select_hs_ddr(card);
-			if (err)
+			if (err < 0)
 				goto free_card;
 		}
 	}
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23b6f65b3785..50977ff18074 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -424,7 +424,7 @@ static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(host->dev, "Regulator set error %d\n", ret);
 			return ret;
 		}
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc5278ab5707..5d1f8a3ec3a5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1546,8 +1546,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
-
-		if (ret) {
+		if (ret < 0) {
 			dev_dbg(&mmc->class_dev,
 					 "Regulator set error %d - %s V\n",
 					 ret, uhs & v18 ? "1.8" : "3.3");
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b221c02cc71f..dc6710f9f36f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1379,7 +1379,7 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
-		if (ret) {
+		if (ret < 0) {
 			dev_dbg(host->dev, "Regulator set error %d (%d)\n",
 				ret, ios->signal_voltage);
 		} else {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index df826661366f..08952b6681f1 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -237,7 +237,7 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
 
 	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return pinctrl_select_state(priv->pinctrl, pin_state);
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 2ab42c59e4f8..f6c7666e8fa4 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -434,7 +434,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
-		if (ret) {
+		if (ret < 0) {
 			pr_err("%s: Switching signalling voltage failed\n",
 			       mmc_hostname(mmc));
 			return ret;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..5f9d4c8d24f8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2411,7 +2411,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
-			if (ret) {
+			if (ret < 0) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
 					mmc_hostname(mmc));
 				return -EIO;
@@ -2434,7 +2434,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
-			if (ret) {
+			if (ret < 0) {
 				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
 					mmc_hostname(mmc));
 				return -EIO;
@@ -2466,7 +2466,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
-			if (ret) {
+			if (ret < 0) {
 				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
 					mmc_hostname(mmc));
 				return -EIO;
-- 
2.25.1

