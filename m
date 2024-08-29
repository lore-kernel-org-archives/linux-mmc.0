Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35818EFFB;
	Thu, 29 Aug 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926565; cv=none; b=Krefl9XTjQbgrpfsg6Zghi/zvZgKshsBeFA2qRs9wlk+wOhIWJY93ICIvvHNfYzxe1zC5rK4UL866A8Fyn02eCGqhdBIe8AxTz/CxkpPh/ch0BYziVH3EInIvnixP9UtQ3EUyn2nsNTTJNXAxnky2Vwz4Iz/J3fWtxluk4FC8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926565; c=relaxed/simple;
	bh=0m6HnpSARb6NuAPzWqHPdVg75XXnN2DTK8mw/1r+o5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQXhuWcWQVBWSEeucbl/8Y/vdgc8tmE+gv7ZeK4MWa6W4lJLygWOJcLyRg+U3lvfA3/GAuhgELz8k3pFFSc4ML0XiXyl38NLgfkKys0fAMR9ohQJWVcsFSHvvyL0p70BdETjv13YEbA1dkaVZgVkZxZUCnSX9+o8lqgfnrpOOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke8wsa7T; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke8wsa7T"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7141285db14so435910b3a.1;
        Thu, 29 Aug 2024 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926563; x=1725531363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdDyBblMWCupMWFERyPDqc26OCC10FbJgPPEbke3u90=;
        b=Ke8wsa7TqrEMu7m4pM1nbNH2Xj7qBnmOuXSRE7TZPSxc1QoIugVYqdxRD35ZAzlyFa
         aW75/tzn1uU2pmk5PwUdmAnJ5IvspaGlv+lQhx6peID1RXq3g35O8zgZ5CKc9+NmKbe3
         MxX1OV7IIb+JUQ8R7zdKdZIS533YbnnUcz3RiGnVb+wss1DoM8tbF8anKpeurAqrqGzb
         B4CglQhAH7fdSbHoIFi8ZE2WJ/W65x+WDDmQ8cCHOh1ReYYD3dspBnU+tskTwphuEuka
         Cc2NgcN3uvPrLzGI7WGn/EyQwpDbPuMM7HpCaphjX2WR+Xt20vKLcpi5tSIMhThn3hiB
         JiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926563; x=1725531363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdDyBblMWCupMWFERyPDqc26OCC10FbJgPPEbke3u90=;
        b=K2FYoMPn3XeK6E8hWxZp6F8zJet2P+F8ZR5PE0mAoRZgUdl4V9ZhPLbC7xXBruA8Au
         w0Jb+K4XWjNs7UmzYu0ATgEuOkFj6fXfx5p4x14WZmskQD3195XCu5tlKK2pBK5U4EpL
         0obasEXBIiG+1Jwe0KzI5YpO+T6JzBcNlFRZSoefw+kpEW6LLeA4xyONSrDreHn3LORV
         /iOZ+Ye7v2sS8vGAPwwswzjsiSdyki0YAcSNuUM+MpfBQlxhqm+9twmY/6ZueO+ZiUsL
         cJvQ/If4oe72KZpRrfDRzr8w3r/9iN6RDRCiSEghX1KQ7eUqnwIT0Ig0qzgLd8TuH0KB
         VYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7s2W/evw9AKp2dPzYcTHWuSXk3UjpNbZHuKYgDp9Me98qT5YVF1La7ym7YvUjtnvCheyWbCkqqiYyec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSM3/upwO7FHc5+dPr6v/FZ1uqxKhxe+cG2SyVRIEkBy83LRaG
	VqXEjU8L5DfMesvbpQzmPSQcKNnKxoyl7YsIH9AoUoXASQz52+V7
X-Google-Smtp-Source: AGHT+IGSCvTNXDeNRYe30eBE3dkXMD8BMIO17BiTnfwIH/rnRBHQAnzBrULkax1MeumDXLZHaVYH4A==
X-Received: by 2002:a05:6a20:9d92:b0:1cc:9f24:42 with SMTP id adf61e73a8af0-1cce1027549mr2275755637.20.1724926562872;
        Thu, 29 Aug 2024 03:16:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:02 -0700 (PDT)
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
Subject: [PATCH V19 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Thu, 29 Aug 2024 18:15:21 +0800
Message-Id: <20240829101539.5058-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
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
index ca67b086684f..b31f6673c5c4 100644
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

