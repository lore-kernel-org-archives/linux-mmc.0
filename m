Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C811AB515;
	Thu, 20 Jun 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880310; cv=none; b=LlSUQw+kao3iRJo+vYrGrnBkDZY3tjQV0SMJRUujrYi0J/w57TCZ5HvU+eunrk4HYeVeU18jCfmCa7Ync8/FhAyPlP4D1yAKDB1/z4Mb1C6+yegrSVIXIuOESASRCVxHRTS+quAp/bzaMtFQZAbAwXlyC83xvJbI2H8Y+rbpK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880310; c=relaxed/simple;
	bh=BZzG/yfxZD3MsLcfbb+9GMVajc8sZOl6vyznOhakx2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qy3IJUxoJI2W23IACElzpANrREusudOCa0hq8gDiHiBg1NK5JlZpgBM7wq9imbA0JmLuuAzEBrTRtoi+h7Vp0CiukAU13uevca61gFu9sjwwIQpTkZtmT3ypVD2cbYfySwIuq4klA36rSj4KAstxUGqw2roSLcWhf65MHK3qR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY5fBwsI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY5fBwsI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f70131063cso6472595ad.2;
        Thu, 20 Jun 2024 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880308; x=1719485108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTuQwzcne7raU+i/r15DCByDdBg+S2gNDstRhF5gdO4=;
        b=GY5fBwsIeJoagH7GfqkiXg2KWdRiOhz3nmRloSSZrLnyLuTUYio4EHUGKFyvXAYhkZ
         U7FvVkIDRzGDAI5zl6PHBmwYtB6SXz1e2l65lVxUx+OCxuwegA0IdLOcK8XKDQShj+CR
         R4gf10ObXaobqxFWl6c8QEn7RevWRHx7oECjKFd3EKoNzdpQzqNN+jGR1WocDSb9rDEX
         IztprPqjwCOKzG8PqS/2noyVRwKOK664Hd+1XJM8YbK6qQWnRyRo+gA6U42HghYWSmbW
         1sF/gBv/XQF1kqfWwuDZpf1wG92mQsMeEt0Mqq5kYiOrW3RrXTISLRKoCUpGIWb4yF2k
         lAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880308; x=1719485108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTuQwzcne7raU+i/r15DCByDdBg+S2gNDstRhF5gdO4=;
        b=cDXynIBKIuojN5LPsz8q5L3uQfyGcCPQETQappJIZSwjpoM5aLJXeXPGe5pzp+KAKC
         T4I2x0K1BLNUryMFWGQeB4Yj0A/lPcDG6exiYBzUSF29BaaZ6cUO2r81b6AMuFDnNHv5
         xxuCt4wzWOU+1yu9CxEqtGz/ZlHCmMfgEk+/bxz3g85LFvkPvJc+U0X6tZ0wQaujymnH
         U9ruTtsEIxejtjtukgQbet+VLKHJt92DBBS8DxllRy3QVdulh7BcZ02KTz8avi/2+DfD
         ewSMzrdKQJo+XVmsoNUHHDhKFwhx9DVAkkb0l+TIHU6QpKtc6DselJgHXoJKEHE0LLpI
         BoVg==
X-Forwarded-Encrypted: i=1; AJvYcCXKQHKAkKdGuWH8jv4kEE3V2K/bZP3q5IkOCSAj8i0SDSF6rU0Thxfwo5qUQMSiMukDDhAihHC5dmIzg9LJsfYNAg5PIM93H5KENO1A
X-Gm-Message-State: AOJu0YxpKLBpyLXjp4jeR6uzelDZvCwapIMPS7N10IlR9yr0s6KAxQAf
	Nqw9IUHIPlLYL/1/Rbl06/NS7jl6bmK8/3V6itFd8Xjraeu0yGi+
X-Google-Smtp-Source: AGHT+IGO9PiB09awe/DzA1SpP769P6sWRMyfvyL3uf1xdeerBb69E8AALizNAftrum4G06tA+Dsz1w==
X-Received: by 2002:a17:902:d50a:b0:1f8:6971:c35d with SMTP id d9443c01a7336-1f9aa47e82cmr52733725ad.68.1718880307941;
        Thu, 20 Jun 2024 03:45:07 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:07 -0700 (PDT)
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
Subject: [PATCH V17 04/22] mmc: core: Extend support for mmc regulators with a vqmmc2
Date: Thu, 20 Jun 2024 18:44:26 +0800
Message-Id: <20240620104444.5862-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

