Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293C82D72;
	Wed, 22 May 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376174; cv=none; b=iP3CAq2/wBi14vIa0N1c78aYG5MiwSymbH0dXFjl4uWuw0mSYcye75ugOx3N08k/yS043iVBCjtZN4TubnwjeFtSnHon7JUq5PD0JgRwTFRSSL7fZVEfoCWpqko9aiMQ00h1MPKRIBMXKh7lhgcXSj4FY8TI77gVxo+vLLPLpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376174; c=relaxed/simple;
	bh=Lt1nFZ8VwQDqcdcvZHEXzl3FPeDt6SmnxVVK6tvED9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yv+aZ82FXpkdk0GGVGKUzInkJ3bfPWzQq8SvXP4ZnhOlw3FUFv9dxmvuMhney92jQ7Z9yy9QlZMbTYwDuohqQRj893HRYV+mcc3udUErSE06emdTnTCVO9j1+p4dxw12oGAEPRAjJjv/AOcmbbM26D8rGEfModLwkTinw5xQu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaRgVD8Y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaRgVD8Y"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4603237e0so583506b3a.0;
        Wed, 22 May 2024 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376172; x=1716980972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0O7T2yJ5pHgmNgm6vNSvjG0SyzCguoIApl75+ur4PI=;
        b=eaRgVD8YpxPWFUdnKbz9ym5Tv8Rfwmt6m565x9+NXekB6ir9Jr/5JwE8V1GRkcenfp
         zwn21jGttcwOhD7mTyb+xNGkzpZTqQKAf2n3LmKyKoCH6m685sfXOzHF+/aXalIHB/I7
         BJ5F0A4hQHQq9tfnULvyJmH8HggaLPvjojwe6wM9+y5jAGcDRMMs3XM+1IrcldpSVkO1
         /ys6BsLxHhFDeBFjX9WTw7O7cbXNk2FufB37Hc+SuC6SmIuWbp2B6+d47p+jKCG61sDK
         NPh73Nncm8jk3EQty4OphYFcKDy3EEDAHDZplC1fu+wSaVqYaS0+PEPSGQCpbPY4VuLU
         q5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376172; x=1716980972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0O7T2yJ5pHgmNgm6vNSvjG0SyzCguoIApl75+ur4PI=;
        b=k6xJVDWHy+KOyYr+0UFcqb6wapxhQBiWJY7alzb/W2y1Qf/XoPjhUdINcIDibayYzt
         8HAmiEbCAMKZo4SSlqlGchPVfwPFbPXu06Mc++ooRgi7TwIQSbxh2SrpEWUWcqz0soVV
         LAUJSlmljRwrd1IEtwlQIzzFZMRT09Qfitm44kdP57eQfKHIVUSO9aEBak7QmTHDrCa5
         GcbU8EqensBbjWt7O4Spy5s/I6R5eEi3TEz4W7BEi2mge9A+GSfwlSVCIV+P/NHIYVEs
         JQqwoPrQKUmrODj+9Chk+A8iPBx4wuAbaFlYdsPEZTGr5fkjKq1TlTMfaZy4EQBHtLCK
         j0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTGlvfQ2SDQpLS+cEviYAHy7KTlisqnqPPveYaBOy1KMWSO5ZPdM74bQ13Q1uFkUJNJjJpnuIjRpkSeWIEnCbzjCBheEYpnX2Ottqs
X-Gm-Message-State: AOJu0Yz4X82r+j2wBFl2doicXcp8nt7jzZd2zeGPnhvMS/EVAZXXXCk/
	NbM8kiEN7+0w4Ss3Wa6oelmqregL52BG3+WQnYH8PgIbQYW6MPTz
X-Google-Smtp-Source: AGHT+IGF0zHUCvYxYuJksXJqPTw0tgyCbIt7Q2iNBwfLWanNp3O2diLyuGexy+6sYguZmn8BbOneAw==
X-Received: by 2002:a05:6a00:6281:b0:6f4:74b8:3d57 with SMTP id d2e1a72fcca58-6f69fb9c0c9mr14495625b3a.7.1716376172167;
        Wed, 22 May 2024 04:09:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:31 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V16 04/23] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Wed, 22 May 2024 19:08:50 +0800
Message-Id: <20240522110909.10060-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
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
index 3e823ef5f672..f60cce75af57 100644
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

