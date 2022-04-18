Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8738C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiDRMB1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiDRMB0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 08:01:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7AD1A3B2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so17056161pjb.4
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbBf4c8rzEVOmrNj5jgfiwGo3Iz1lKYdArVuwED2OPI=;
        b=TlX9oTc4d6MXvmZLjnOYZCd1bzTTV+NZIruNA2VmvENZtPBzhkpX7zCaLU137hWAbH
         /fkpsJBFT6NIqHEQLrUfYtnL/jD1eUU1oKpbGb2v9O5NrYok43zDfp+FL2/ITMXFxYzL
         xn3UNmT/UZmySBNkvkNgknfy6ZGp6N5RWEnLstEzrrFEXXLv6ta2NZ343+Q1WC5m5U0K
         rxpYGG8oketl4kG3/EYIzZ6uvpAwjI8EWlgT106Ndt+MqVTrJbPy23Bbtq/108MgmvAq
         mShuaeysKP0JB8xe6feczPb1eIhi/JRePCEqwViu6diK4HmALpx11Fk+9XA0gZbyDs16
         2KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbBf4c8rzEVOmrNj5jgfiwGo3Iz1lKYdArVuwED2OPI=;
        b=4EaNh91pav21eC7SknlVu6P4dIAyoGHpEmk4cDawqOpLpDsYoP9Ihuuo9DUUUwHYOc
         +FXs0Ua0p0jxvSU9FzWFLMmeWIdunJchodJ2Nw5BuVaMroaE7eaJfByVT62QBU5A3z0N
         mjtao5kD3Vz/bj66OprN9mpvmXI89WJCv+dhUi7+N0v5VZW/G3KwchcfyYy+OzI+nbSH
         vPpId9JraYgeYXnoFy6iaJwagXxex0kcSU9NM+PJxHB8kjPZdEcPr0iw/9lrXOR9WR90
         Sd5Z15RbAggqj3Qgl19r7sZJ93eD33VFZfofrKT4+Hi7X5smo3FCpI54xX6+q2srk5/F
         /HNg==
X-Gm-Message-State: AOAM531lj22axanZ4eTS6X6VxYncIKVY/Y2YFu8f7EtCkr/EML95fbeQ
        SZ36W4bIVxec0J4sG6P8RNQ=
X-Google-Smtp-Source: ABdhPJwWPVrPTgNVqz4UQO9aAH3S3dJMZ6kxA/NZ5pigjb4Pb+mIYnbtvIq/hWmovGpf7ZuSg9BmPg==
X-Received: by 2002:a17:90b:3b43:b0:1c6:f878:ea52 with SMTP id ot3-20020a17090b3b4300b001c6f878ea52mr12679121pjb.68.1650283127359;
        Mon, 18 Apr 2022 04:58:47 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm12409749pfc.101.2022.04.18.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:58:47 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        Tim.Hsieh@genesyslogic.com.tw
Subject: [PATCH V4 4/6] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Mon, 18 Apr 2022 19:58:31 +0800
Message-Id: <20220418115833.10738-5-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Updates in V4:
 - Moved the voltage defines into this patch.

Update in previous version:
To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..3c189682797c 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -223,6 +223,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -249,6 +276,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -268,6 +296,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 765469de8650..dd073ab54c02 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -71,6 +71,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -302,6 +305,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -580,6 +584,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -593,6 +598,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.35.1

