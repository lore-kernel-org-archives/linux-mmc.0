Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93A1C9EB1;
	Fri,  6 Sep 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618075; cv=none; b=m7wmE1UdjFHuLNdFWZDNaUPrZYBVT+8/5kkO00jaENPsvx7DylaxKVegjoWCKU2xbK29dKdnOvzKqJnjsyGx4pKuPFd8nqqMyy6uV57YjeBbf/xryEUP6yFEdzF9kSDfVqTKt9EPkmyNNsNkdJuj7/6C1V7+qEthpfGpypu2Zyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618075; c=relaxed/simple;
	bh=9yNbvwz6yb/3G/OsIahUHIQ0tAuP/rL6iEJz54zI/s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qm75wFlJIjrS7THMSuNJgS+Lke8XcV2CZLvWhT7f/mbHpBNpeHvzm+xuAZzIObwwx9NYmnjbvQ45VwxYov3YPr99jIi6oqk9OPjbHBWaBY0gR2SYBFagYHhR/w9vPOhNZv1MZ18usbIyNGnhrcycG/Sj7mkfDxtD1O1MQ/Ep190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffVksJvw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffVksJvw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715abede256so1506667b3a.3;
        Fri, 06 Sep 2024 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618073; x=1726222873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=ffVksJvw7QBjMbOFSaW5YlK28qq8X0OecI/phBvIhUPRzfYVOylKBzY35xTsjhppzr
         QD3WM9JjToworQ2C09zd93Wts3OaKNSTT1oyrCC7HSws1ebs2WiCF+jJmQaxiaKcPrBi
         FlRukVF7sPK46l321+/rXnGBrOksqRnjKT33AbFKk4n/7Ab7kJRhbB9jSY1ZxptB7/fi
         VZGx44OrLvxU9mTQmt1+pJUkgQdFax+Du7jTZoWX7awrAiu3AZCss8cayjh8Iof5kvFi
         Sy1EXl0pUOpwzbJ/Yya+gfMVighcHdMKfPvTk7zS1kzyHxbN+D2isvfzSYVq+29zub5h
         hjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618073; x=1726222873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=YQqGxSc+x5IHoo7R5ML2d+7Ch1JvodNVA1ME92ImutcnR9gDbOGvHzKS2MwXzIqvvu
         TNc0yxZNAS5UqovBecJ9svrl6Ah/STxdzUOaQ1ROODxrR7kKm2B7+hcxw29IxWRgpQUm
         nRSuzWp00X79Oe507QK6Lwd9CZovH2NPg80hyAvOiXsEbOLe3VawcP/gGWeHW8GxteoY
         ONN9NpFGzG78XxHwEfPfb2APSUQnmSkkyC9A1V353eJD5ElwR0Y8vS2DfV1j1ynq9OH4
         kiTNuWaW3n3a8QJP94oCjUjfSIU1ah3+noz5ImKZ1+p4aCDcJKYakGa3PQxfHBPAwhYM
         CEmg==
X-Forwarded-Encrypted: i=1; AJvYcCV9eULnufcVR8a5/19STVtABe/UCjjT70q/RzoQ5976nVKdkt7Khfz4VRu/fDZ7qhi3wo2oOS3JGHnyd34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjztzjN7E35mI9tptMFyM5Dpv+q4y4dxmXYSI6NaIRwaxT83M
	aT9RqicEWMUiv1r9G1fr/8rlxhvEJTrhRv6J1EznQ18somtRCkP6
X-Google-Smtp-Source: AGHT+IE79YIxS26Kor10DefIkp5oSEeb+r31f7ZV5+CBQeRJI731xMw6NzhKlBduqtxq55T0eFhEPQ==
X-Received: by 2002:a05:6a20:9d90:b0:1c8:b849:c605 with SMTP id adf61e73a8af0-1cf1d1e0feamr1886394637.44.1725618072954;
        Fri, 06 Sep 2024 03:21:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:12 -0700 (PDT)
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
Subject: [PATCH V21 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Fri,  6 Sep 2024 18:20:31 +0800
Message-Id: <20240906102049.7059-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
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

