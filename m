Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983801D88BB;
	Fri, 13 Sep 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223343; cv=none; b=gesycLZ7jvbE+5x7QWUKv9gQAzjlwxzBLu8GYoX1S3Q8Sbt623HSRfZX6NZnpS/lczy1dQ4alm6F1VCIcM5D0i6OqnvBlurAf2bDK9OBVnySLYqzmw8lRs/y4FtKzUVSQCMTmbHfLRjGt4wPXgUQmcSeXiAqZqUwMlh6xCilz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223343; c=relaxed/simple;
	bh=9yNbvwz6yb/3G/OsIahUHIQ0tAuP/rL6iEJz54zI/s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2yOJOIVXlM+CXq55kQLerzg+6m/cFxCM4qenRgunenYNMMo87vnpWnjCUYXBQ+otuD3YOkjt1v0mL5gO2/Lr/5lDa1mmII82faval0ZLwmpBcFUKDB1pmCvNgw+ueh+LI9Pd569h/FYnJssL/6Xb5pFAyJ5uIYsRH6y50WaY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/SeJSFW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/SeJSFW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-205659dc63aso21108225ad.1;
        Fri, 13 Sep 2024 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223341; x=1726828141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=Y/SeJSFWv5DrpsI/lT2qYxtCKrMHoy/CEXOyGHDOR+Q+Rv0l90pQ2iTEiqpkG0J1oi
         MBFrOlVyf5bKUJOAcGzc3ILeiyV6Ezc9HyLyLqYgUH2/YPpodJbJLIupcj8PNatN/GBP
         bES+3KanCML5fP9aRnBiSWxULteP0h5tKCtji92ewd8mhMT6jkvCJdfDV/jiVX+jZiAp
         EK9n9jnV18SDBNeyXKMi3LIKsrBxkgsbyQ3ZS7IUfOpBGUyZe8osJSOeKhhlWFg3V8jJ
         26LRrktfwTe3U8MWkxORqpEeTJIOEIe6j6sdgY0ojsoN4wgxQ3EPDtGbzYB1e87mzL+V
         AVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223341; x=1726828141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=XwgPiWHC78x7sWk81of8tGcMFS9HYJWyuPPkJ+M3fAwozDnyGgGWo/B4TfmY6UaLHC
         tWrYB6kxpBIH0oXtcCjfu8Xw8mt4YxHA8knG/SfC6f60cNNFXenJM5IyoGxxn32pxIto
         1DrUFJyfH/7JCykTy2r3IhIJwxc528IaNOPIFXOiekSEXB6O+kjGi0ALa7LH0iJkyoyn
         gUow9Q3NWqM0mxk6FqGI9gxAAOr33ixasAtTvunBI4SOQ1FMzux/tD3MFnBeGuCHd+ka
         kcIDHuMhKgq13PE36NZu8nT3vTmz89fcHfoehP2JzwqsfWzodRc1gFqHiqzB5ACYhDL8
         2RWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Lr1dvJloHtekEr53sSx0ec8vs8uk15NOImKixyQ2YfaeuB9sFt/BHIzvmkk8XWdia0kSuSrQEd+lCmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYXU3tfUTze+cTWv1PYHt3PMyV+8c5USXLySUrizuphEHHfdc
	n62qQ64vx7slFFnawhU+e9LBzGOi5lbtJuiTK9cO8k4nHHc4/8Rb
X-Google-Smtp-Source: AGHT+IHXDmmXAq084Qhqwaq8dB/jcaEjQvn0hfyom5ubAEt+G+LfWJYllFRr35Jxc6HLweHHscXARg==
X-Received: by 2002:a17:902:ecc5:b0:205:43d8:710f with SMTP id d9443c01a7336-2076e4df8efmr62249875ad.58.1726223340766;
        Fri, 13 Sep 2024 03:29:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:00 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V22 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Fri, 13 Sep 2024 18:28:18 +0800
Message-Id: <20240913102836.6144-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Updates in V10:
 - Modify the commit message.

Updates in V4:
 - Moved the voltage defines into this patch.

---

 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 005247a49e51..208c27cfa505 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -226,6 +226,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -252,6 +279,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -271,6 +299,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
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
index f1cf09ea1f72..841f0ba850aa 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -74,6 +74,9 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
 #define MMC_SET_DRIVER_TYPE_B	0
@@ -307,6 +310,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -589,6 +593,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -602,6 +607,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
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
2.25.1

