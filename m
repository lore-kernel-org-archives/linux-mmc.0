Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393421DE840;
	Fri,  2 Aug 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594180; cv=none; b=GMLs6vEn4luOiLshFER+cTV9XcNQDagimMn6yAbLG9P/54T40+lvahHAkT/c6tt65M+JK0vwdnUeOIdt04MKfoC4Wik34/Xka/nPrZHPztQpzS/8mqcJCOOyGjiyPNvg90wdbVg9WXXEye2QZIWxSGgjNJu82zWlzBgJDcdoPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594180; c=relaxed/simple;
	bh=BZzG/yfxZD3MsLcfbb+9GMVajc8sZOl6vyznOhakx2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAEMwVWNGEu0wcTkMl+sRH+SattH8kwZjNtXJ4yIYPPjXGqWSBBZxP9w7gS3SU9clwYMEXU6H5dguidYevOkD6uYGF2pK5B1nytPmdKMDFlXL0HrAt+DbBVgJO3HQJY1fY/Nfu4SNTx27C7n89/DmQysdYn5g1ie7/3GXN/OTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R57cIMEw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R57cIMEw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7094468d392so3516769a34.0;
        Fri, 02 Aug 2024 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594178; x=1723198978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTuQwzcne7raU+i/r15DCByDdBg+S2gNDstRhF5gdO4=;
        b=R57cIMEwo2YgEuH365HYmYQjboRDLz+j20hqlRUK5+fOgjWLxZsA/5j4h+tUOwogk7
         2KRFTjnLunaPjHYjBEEMcFVAkXbGiBI6ePHAI1bShH99i3yojXr/ki2oZhLwFso+dB0j
         9LLoxErgEJ6aOI0ENNQr74Ql1D6wc/zPPb28i4R/gvqaqv5p5VrooKvDmp5kntpbPHeK
         gNbMVNP4ioECjimfYPFyvyXjwH2Bak0Pw6HdxjPgAH0XXV5kOyJydx960yiLdOgYvLm1
         mDtAJ9Lo3bzdVzjob5FGyz6HeucaAMovcE+B68EN1R6IQ6oM6/pJ1fGQVgihocHsdpvx
         /6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594178; x=1723198978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTuQwzcne7raU+i/r15DCByDdBg+S2gNDstRhF5gdO4=;
        b=lzNiNUdf9IZWJpLoU+t+g/+RuZ5udYD0HmKaVmO5/9KzW1yeFIPf8pTf0Sqz9y/GbZ
         Mt3iVI8PJiEs5ar0wkL+7B760X86wQbpOl1LgkLroNBarZSIFJeyiYZhEPo7Ei2K7TWu
         VKm9qyZEFrx36Rwm0V7TcgSdGSmRwSVZ1PBVwUPFPZuk/VCbIh+cOCgadT7vEL9LVJOg
         3Hx+yvpQZOp+PDbufNep9phiDGE1XY2uWar5Pruy83BBDOxUC4pmntUdbcjUUWwcX27o
         /i4gD7tOngQE/cbAbotZu3I4CqN+knKD1sp4QaCfN40Molv5Zj76Vw6qm6rsnmaaXjoN
         MqUw==
X-Forwarded-Encrypted: i=1; AJvYcCW0zAQF6pkNm/VfcL1EM5TRn4aV2tNEw/O90A+Bk+pJ88Ilmz0dzdg+gCWf3gIn3S4TcjAz+kmPXrVUM1PB9kYQ2etPMJv9hlxfBeEK
X-Gm-Message-State: AOJu0Yw7RlV/YfumzAP5LIt0WU27l0479hoE+brKnvKfrVSJ4NBrvWwO
	mZcAd0WWaHg2NTe105lMG8tfIHof1a5MVhzT2OXywS3koRohWynU6fwMAo2m
X-Google-Smtp-Source: AGHT+IGDqM0TbK7Tw9LwmJXun84DF227IVXAnbYBJQRsUPp9gkVezJkdxic3stHmaJdqtU8ajFptfw==
X-Received: by 2002:a05:6830:618d:b0:709:34ca:9e3f with SMTP id 46e09a7af769-709b9988e0fmr3549692a34.33.1722594178304;
        Fri, 02 Aug 2024 03:22:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:22:58 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V18 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Fri,  2 Aug 2024 18:22:11 +0800
Message-Id: <20240802102229.10204-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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
index a744440bc276..3400f53c448e 100644
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
@@ -331,6 +334,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -613,6 +617,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -626,6 +631,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
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

