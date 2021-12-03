Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084EC433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhLCKyn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbhLCKym (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC7C06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q17so1810636plr.11
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xio97bElZBlPdHjQc68/Sm38Rf+bj+WcTePPCHUCVQs=;
        b=HAEz/XekFuriFfx5qqxGWcrLbs22ICF7J/zvJgq1Tjc+AFvnge+I2wxusDmOGzX5t/
         SDexWjxfrgai0nwI5dUMd4HA+zWXRCDdvWQlAFLiD06PUKAMUq+83mxGNO0rszkGBfu3
         /fRzE7K5cejB0y3RBQUWRJTqU+7CnOXVFXXaNuAQLTyFpvFvCXaFyE/1V/acI0sVdGSl
         Uzjo/3j6fDdrsO04VNYl4EMjwI2JCvDmwdqKm72pppPbjFo6X0LV7oq9N5/vBMpI7Lxv
         O3gx5GJ+TjIZ58p+54IzItUxqwefOWnmhwSbAJYRGxJZaVNV12laibeOMnbXX6gnOduy
         A/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xio97bElZBlPdHjQc68/Sm38Rf+bj+WcTePPCHUCVQs=;
        b=TrVpoXsbimmqv3sFcEKz7L4aGPbd7H0BkOTBtfjd6mW/DGQnXVo0JrKjFd0mkfydzI
         DIIj6QCXiWEjJrxINrrP/6WLz74ytuXCwVObXmLjYJsoGbIcKK0a/XWI8Ni1RPJeQIFQ
         SZ62li3glQ9P/TXfA/6ne6m6LyXb2VDlcOS1YbzGZ2YK/WscNSbLbf0CPE5xddBGebPE
         gu/OcwmnOPmb//wStzBcNLwc8bUTduRzxgzm1d5NfKQTYFqseUfAL+q21G6J9gyOtncW
         D/lFkZ50oYTyn2byGEIW29JPEi1rY0WChe47/gEtxu6Ru+EkWPWr6j48oDB7Zw3acTQv
         N7Nw==
X-Gm-Message-State: AOAM530179EOI+udjr+TqAbw+8d49OpVvHYULz96el/lV+aOjbFH+qmv
        rPLomPPYTy5W1JxgT0bc5j8=
X-Google-Smtp-Source: ABdhPJwehH0gxy8/Dgexl1p5mcq2Cagdo9wHn6V661cruZ/QWs70W67KRaTY88enk+tRBuACDjoIrQ==
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr22282989plf.72.1638528677940;
        Fri, 03 Dec 2021 02:51:17 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:17 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 4/7] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Fri,  3 Dec 2021 18:51:00 +0800
Message-Id: <20211203105103.11306-5-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

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
Signed-off-by: Jason Lai <jasonlai.genesyslogic@gmail.com>
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a46..3c1896827 100644
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
index 91065ab7f..69f8c8a8f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -303,6 +303,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -580,6 +581,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -593,6 +595,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
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
2.34.0

