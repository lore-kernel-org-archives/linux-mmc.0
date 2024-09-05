Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07419924A;
	Thu,  5 Sep 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531625; cv=none; b=iEe85intezlDWL4asUYpvhV1+pqKYIZ7HgfavU1WONfghsO+D7MLy+HY4QfO1AHDwKZ5ecgKmHc5wuMq4p8fFB8US3Qn0Pyy4jUcmDXGJylpgTgPc5Xz95fobIbBLPwdDAeYjlAWRpRU9c3LtABz2a1GVI7Do8Impk+9lcudV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531625; c=relaxed/simple;
	bh=9yNbvwz6yb/3G/OsIahUHIQ0tAuP/rL6iEJz54zI/s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nF/Ebyvob8LgIWTYQBivLWVmFjzcLFahEx9D9PD/eAM1akkCPZTfHTeHEzp4lUZxL3g79mccZ/aIbJa06qHuFnw23klAglNxV3kk9baSFKhekuDpfZM0D2QR3DoBULjKcJd8MeldMPxJI6/IHrWttxR+fFRMWdjHqnJiJdNrVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaeof84y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaeof84y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2021c08b95cso14209425ad.0;
        Thu, 05 Sep 2024 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531623; x=1726136423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=Uaeof84yNwTPqgRNoqgr3ssqD8+aA+2p9g+BdP0ZORmgLmG8qeesqdCZeV30C25wr3
         Pj86xGwm5h+1o8fErB+tMIMEFM8iCCJMFPYyVNK9lzso4FOqvQ38wM49B30VSDxbaFR8
         cuHS9CtsLFQTMY/SaR9ngSNj0uuL0LSpIDSXNTIQWjCk1f+FsrXztK4IT9nYX18yvXqK
         fiIriw+e1p9k8camWpB4j7Ma7VDEFMr7eL9yX7wgP39Y4LzGrTApbPmB896duzE0aOig
         378E9Pp6hT/U1zhZQrYRjUl96CL+Y+fdAyXUC7aEgYY0K17dn7z48wyfeCGrGoJwLEMw
         IRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531623; x=1726136423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhL+kkVUd6coagoEa7icWXpPCycMAWuDumnQ5UDpr7U=;
        b=Aea+AG5Qsqh7k6HTCWiuEgWoFrBVDNPoN3NanKDnUPWdrpwnc4xlVZPDNlTmDvPNND
         cfbdzayHnY97K7cYyMKpVVfXmlM60MyOFM0im2Ksxu5YnenHt5QyJEJrLI8E/l+k7afZ
         qZLHPDFekzbEn1Vr0RMdw2eRaL0e3xVNIfU7NTuYEqSoVsf85sl3vlQchr5H+CIvRIDb
         GnVjOtul9Q9senA3DnAUNblYrn1nXvtsWW3HSe7/LoSTw0HxEuKSz8ozERq6XPdhoZqb
         yomoUzpukMAb+NQlS1Tsn9Y0A7A+UyRyJB62jV0UXJHsFt53nzE+cATvtFd/by2UB9NJ
         imfA==
X-Forwarded-Encrypted: i=1; AJvYcCU37wr75IO2vcscFzbkEEb8+v5uoi+/22582aGJTSAq4mzRzrQll2CZKcDkoslvbuX69xKvYXluorkFlF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwBq8O+P2id77bYsR8x318GOzins0KP4KyXpl1uoECoLqLnMH
	OmQwhLmspWKx/J6x3El6oYDEL3DCaMPNXO1O7PZ+5YIbCi0H/kgp
X-Google-Smtp-Source: AGHT+IHnGt0emv6JUymfkd5299JDqC68ElnApNDQowHBgydq4VMkxcBliaL3WpNdm/XgtDfn73Vklw==
X-Received: by 2002:a17:902:ea03:b0:206:b7b8:1ef8 with SMTP id d9443c01a7336-206b7f21284mr97581105ad.11.1725531622734;
        Thu, 05 Sep 2024 03:20:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:22 -0700 (PDT)
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
Subject: [PATCH V20 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Thu,  5 Sep 2024 18:19:42 +0800
Message-Id: <20240905102000.5020-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

