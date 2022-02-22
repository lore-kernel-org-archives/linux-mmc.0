Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA42C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 03:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiBVDkj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:40:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDki (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2022 22:40:38 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F33240B8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:13 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 12so12367535pgd.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejhGfYhEFe0sow+Ti+BIjLRrK683vxciwz2GFrR2geI=;
        b=kycwWPK775fgRt3XTnVI8eYhlnnrQWcUq/0h2TPDBkKqXl8iM4l6Kza+Cx0onfdiDp
         aQkefpn0IToiatTtddNtEG8W/OdBpYBPxjPudWJU54e6iY9z87vrZYCNUG6v2m3XKox0
         xXSvO/t81eCfryWP43v6Q9y132vxOX8oowym+H18FezFeWckkYBWc2w3dvadrorEjpYq
         Vfy6w+JwD/f6XUMJPl24xo+hsvzub3wWbjye0MqTPHWrXqhdNrVtCFGvo1dZgJRG5Vqq
         h5DIAiR12UVDB8HVifG0VB98A/q1y5N7IgNpHrTJKWbh2/TleMgfdXevVUKeOh7z0+fy
         Ujxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejhGfYhEFe0sow+Ti+BIjLRrK683vxciwz2GFrR2geI=;
        b=sECkM6m5sqqkDCKYluGt897ag8vGL4iQbwMrxsIW4ay9CdRloggenPT9uBABs20ZN/
         jM/LpYNfRgXBzmIavXQ9R3+wbv9M55VpAsYYJI+9ku6sOa4/hXs8uYCE+MvZ3Jxs44TU
         0l27g9C1uEkLZSzB5SCiop3hlxHA7eEt9X+LSOH2kjUqIPM/2wKAKXcJ5n10rlsPdimU
         r9EsYO/+tBr954WwequGltsI8Wj8JZ3wCYgzpiaSSuW1NVNUJIOdxy9T66iv3E6RObRq
         7GW5D03BNGcWKHrfqTRB1/IIPidyuVKQ1T/c775QVZ+M4TwCmACPSgemzddWWPBmwJ3K
         4b4w==
X-Gm-Message-State: AOAM532+7/0LjWceDtXKtWrX8OE97OwLjNmD10Ee5eJMBURwyJ4o/OdL
        9G0lD8Go0Uf5Y/t+8YhrnRk=
X-Google-Smtp-Source: ABdhPJwhu0yCj2eXVe3NHzpbmTU8/MZPzgz/5GdN0dyUj0PABXza7MRfpGJw6sH/rL0I03m4epziUQ==
X-Received: by 2002:aa7:9902:0:b0:4cb:95a7:a4c4 with SMTP id z2-20020aa79902000000b004cb95a7a4c4mr22546148pff.85.1645501213084;
        Mon, 21 Feb 2022 19:40:13 -0800 (PST)
Received: from localhost.localdomain (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id ng16sm703542pjb.12.2022.02.21.19.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:40:12 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Subject: [PATCH V3 4/7] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Tue, 22 Feb 2022 11:39:28 +0800
Message-Id: <20220222033931.237638-5-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
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
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  8 ++++++++
 2 files changed, 42 insertions(+)

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
index 16ccfb61fc58..d770941f05c7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -305,6 +305,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -583,6 +584,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -596,6 +598,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
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

