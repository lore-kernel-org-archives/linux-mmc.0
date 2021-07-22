Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A7C07E9D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2634C61222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhGVDVy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhGVDVn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF7C061757;
        Wed, 21 Jul 2021 21:02:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so2989371plh.10;
        Wed, 21 Jul 2021 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1ztdz3rUyfvAhBD7oREx/OD58dYkmWuDzT+QQUbx2M=;
        b=UcuJ5Jddv4aYiD4yK4pfO/FlWjt9fdTokv2sVHVZ9z1h7kGvUj1bzxLK6rcsfHrreE
         pc2HuImk4yMCUohtNiwybWChnOLdG5B5e2gaTTbDgI3XznR7AUjXJkf5JPKp2HXcyC3/
         XLXarqrXG81u0k9wQJPtarC1sQpwCSlMN5+68NapQlvs+MfFE/pjY7IWxF7s5DWoLgNc
         rBEiORVr1KdyFrp2UZZm8Z7QByRinYmUoo0/xh7QzK5lqTR1UxpmkfYydQNg3Kdfbhrs
         G6sq8RJUpSteOCBKI6GWmBqx/BsMRI3UuddhZC23cz32C6DjIG3SBmbgqRGWzXAui53E
         peXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1ztdz3rUyfvAhBD7oREx/OD58dYkmWuDzT+QQUbx2M=;
        b=m+y2ATjcD+Xy8oW0q8r1sbCsCQLfa4yZhGPN6pHTI7fZJ76jqB6Sx2gVPWtW3BG8yy
         0dBAqCuHwQihLSWX+VscL4IkJuZCrWgvfa1uMBOmHb3KHJL2wQX8+hZWJOcEuPSChfQr
         MqMlmbDg8s93KOpbMTCfJDjdZao6WbctcspkiYAobry6BXo/nM3IK3x1+jpOoAVA9C+v
         9OrtKYuZyHyAfABiorMMrWZFV54GzxQcuymgkrh4Upb8h8AnKXYkVr82i0BZlFeP+T0l
         tpCdkG8h788Dd/vuUKJCa8LDX9OCd9MqLV9F9mVNZfTwZUpxSPrx2/z56MCf8szz089p
         5w9Q==
X-Gm-Message-State: AOAM533ERF7HJ2GjrciKT3uX2uRuGsPkBrlOfz0CqDLezR/zvYik1vwb
        EKuUnrvWLdCwyntzD0jO4JE=
X-Google-Smtp-Source: ABdhPJzaxANSs7WNWViDXZyEEFec272tl1/MUCEHeKXAtTIWFCkE47c/x9UDSJtoK2WZD6JxgUkMfQ==
X-Received: by 2002:a17:903:189:b029:12b:3fd7:d95d with SMTP id z9-20020a1709030189b029012b3fd7d95dmr30124708plg.24.1626926537256;
        Wed, 21 Jul 2021 21:02:17 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:17 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 13/29] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Thu, 22 Jul 2021 12:01:08 +0800
Message-Id: <20210722040124.7573-13-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a UHS-II version of sdhci's set_power operation.
VDD2, as well as VDD, is handled here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 80 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 drivers/mmc/host/sdhci.c      | 58 +++++++++++++++----------
 drivers/mmc/host/sdhci.h      |  2 +
 4 files changed, 119 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index e2b9743fe17d..2bf78cc4e9ed 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -98,6 +98,86 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);

+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+			  unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr;
+
+	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
+	if (!(host->mmc->caps & MMC_CAP_UHS2)) {
+		sdhci_set_power(host, mode, vdd);
+		return;
+	}
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+	host ->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_off(host);
+	} else {
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
+			/* support 1.8v only for now */
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
+					      fls(MMC_VDD2_165_195) - 1);
+
+		/*
+		 * Spec says that we should clear the power reg before setting
+		 * a new value. Some controllers don't seem to like this though.
+		 */
+		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
+			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		/*
+		 * At least the Marvell CaFe chip gets confused if we set the
+		 * voltage and set turn on power at the same time, so set the
+		 * voltage first.
+		 */
+		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
+			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_on(host);
+
+		/*
+		 * Some controllers need an extra 10ms delay of 10ms before
+		 * they can apply clock after applying power
+		 */
+		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
+			mdelay(10);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 7bb7a0d67109..3c19d8e44c36 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -211,5 +211,7 @@ struct sdhci_host;

 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
+			  unsigned short vdd);

 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 78db850dc1f3..d944e5e0a30a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -186,13 +186,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }

-static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
 	if (host->bus_on)
 		return;
 	host->bus_on = true;
 	pm_runtime_get_noresume(mmc_dev(host->mmc));
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);

 void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
@@ -2018,36 +2019,47 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }

+unsigned short sdhci_get_vdd_value(unsigned short vdd)
+{
+	u8 pwr;
+
+	switch (1 << vdd) {
+	case MMC_VDD_165_195:
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v
+	 * so we only get here if the driver deliberately
+	 * added the 2.0v range to ocr_avail. Map it to 1.8v
+	 * for the purpose of turning on the power.
+	 */
+	case MMC_VDD_20_21:
+		pwr = SDHCI_POWER_180;
+		break;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		pwr = SDHCI_POWER_300;
+		break;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+		pwr = SDHCI_POWER_330;
+		break;
+	default:
+		pwr = 0;
+	}
+
+	return pwr;
+}
+EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
+
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;

 	if (mode != MMC_POWER_OFF) {
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-		/*
-		 * Without a regulator, SDHCI does not support 2.0v
-		 * so we only get here if the driver deliberately
-		 * added the 2.0v range to ocr_avail. Map it to 1.8v
-		 * for the purpose of turning on the power.
-		 */
-		case MMC_VDD_20_21:
-			pwr = SDHCI_POWER_180;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
-			break;
-		case MMC_VDD_32_33:
-		case MMC_VDD_33_34:
-			pwr = SDHCI_POWER_330;
-			break;
-		default:
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
 			WARN(1, "%s: Invalid vdd %#x\n",
 			     mmc_hostname(host->mmc), vdd);
-			break;
-		}
 	}

 	if (host->pwr == pwr)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b9932423db08..2b5b8295cf92 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }

+void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
@@ -841,6 +842,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
--
2.32.0

