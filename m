Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A531991D8;
	Thu,  5 Sep 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531659; cv=none; b=c4EBJXvpFWdleiY84QFAiiYjBL+al7TH7Q541SHZ7vxCv1RFZ9hkX3/FRWXjpLRC1bdA/wMkAj59/N6WS5Lw/8RkRULP3LeTTI+L0IJ0Rb5gZ/o12UCjGo1N06zNQraKfYkn7Zvui/KLQ/mOv54jf8B9R/ow7i0ZPzSCnWhrS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531659; c=relaxed/simple;
	bh=ZXGEzaz3HiWknyeUmK9tPtLjvRCZ9IuLbN+IF8lFSPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdaQdXUnm8Otvdadjzzr0ifB75Ef2TiMHLTS6eQT30atdBVWCzIRoNtNSE6qLznbeZlvs0IG/DMsddJqs3WgY+4iwq64L0u/pd9YY8alrN8COdcKkgRF0yzRkaPFE2TSNg6KAkmuFV5LGPprB9ktWkDwwAhO/YuloZkpw9vezNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/BD4XYO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/BD4XYO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206b9455460so5153515ad.0;
        Thu, 05 Sep 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531657; x=1726136457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frHRewf0pkcu1synjclcnqgZV+fZOIZRmQD7b9toY3A=;
        b=i/BD4XYOk2mr6b75UgyK2qOJi7O3RNEiQRfJhOWVeC7Lq/yUV3oLiT1qo+gYZ93Vdv
         lKQxLnsxx9mZIvbB76NwS2ZMIeTTe/YI+A0lgsKICz4hiwl1joPXn/C4qgxt8S6Ak2H8
         mXHKDgAgqKVnfjU4QE54t0dzu6H9j5QgxoZvXYTzIOjYIy2VLc8/l8eLXvfGbbG5n/Zg
         ZZFy8SXqiHAGvLuTmK4egP+0GjoqAtkqWO7qeV8Cni0B9zU28LdUSMUFbpA8L9tZESWm
         GuK49YaN+EPusz3zyusBKgExSp0t+qtUer9h1alE1CBdN+fFzR5WlEVwCPvotEaCbPbi
         HMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531657; x=1726136457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frHRewf0pkcu1synjclcnqgZV+fZOIZRmQD7b9toY3A=;
        b=FRfSKbrwraz+LXOJFOCzJVT1lUDVybsPUkmnM0mmOsRawDHWFeGtiCMKqPwRHfiiS/
         8uX8B+nquvznzVPI8M538RMCXboVzB0aAYWq8JrycSgPxUhUr3kirHjeesKpb54rgl6q
         aWbGwI7fylHJ/1pyMXuuFlWC9mOlR9kVHQfqBFnTHyExFImJF2tDc0AgugN8dUIo9ZeP
         kIHl8LNcigHIfi0AQxGPHfhEzJ8JT4af4iBdYTy8hSa+ii91VB5kTbVPgmH9lddZQeBE
         Yc62zvHCiFVYzN9PmNw4hRYlhMfAxmxn4O4RpLKhv7Ws9TmEMoxkflGUVy5TvZVkml+h
         CVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUCmGG0q4ZGg4+G01c1jPb37Il/c7KSr4TGriNiJ1Py+5fnQOnni1D0tlEd0Ay228y9vKNdX6LwG5zl9sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jFXjwvWZQz5ZWF6Q0xj2pifYId3eSdEMz12JfZfBU/VooAS8
	aUEpDKp6wEsGzvBYaXZMMDox4/B7AT54uZzG5pu+GDKciDjRsKM7
X-Google-Smtp-Source: AGHT+IHZLoMlXOfyW2mNTRs9ez4MqvIOXcSUowil4v898UmLMImD+UeuAJv/gAKpuozjFZKuAhiUxA==
X-Received: by 2002:a17:903:32c5:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-206b840d26emr68704755ad.22.1725531657334;
        Thu, 05 Sep 2024 03:20:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:57 -0700 (PDT)
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
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V20 12/22] mmc: sdhci-uhs2: add set_power() to support vdd2
Date: Thu,  5 Sep 2024 18:19:50 +0800
Message-Id: <20240905102000.5020-13-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_power operation.
Use sdhci_uhs2_set_power() to set VDD2 for support UHS2 interface.
VDD2, as well as VDD, is handled here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V17:
 - Export sdhci_uhs2_set_power() function.

Updates in V13:
 - Drop use vmmc2.
 - Modify comment message.

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[11/23].

Updates in V9:
 - Modify annotations in sdhci_get_vdd_value().

Updates in V8:
 - Adjust the position of matching brackets.
 - Add the initial value of the pwr in sdhci_uhs2_set_power().

Updates in V7:
 - Add clear the power reg before setting a new value
   in sdhci_uhs2_set_power().
 - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value().
 - Drop pwr variable in sdhci_get_vdd_value().

Updates in V6:
 - Add mmc_opt_regulator_set_ocr().
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 49 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 3d16f1ef9344..0cfe9a3f91f7 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -59,6 +59,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
+					    struct regulator *supply,
+					    unsigned short vdd_bit)
+{
+	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
+}
+
 /**
  * sdhci_uhs2_reset - invoke SW reset
  * @host: SDHCI host
@@ -86,6 +93,48 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
 
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
+	} else {
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		/* support 1.8v only for now */
+		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
+
+		/* Clear the power reg before setting a new value */
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index caaf9fba4975..3efa8dd690bf 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -178,5 +178,6 @@ struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5a5fe3528bb4..366c3d30dba6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -23,7 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-
+#include <linux/bug.h>
 #include <linux/leds.h>
 
 #include <linux/mmc/mmc.h>
@@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
+unsigned short sdhci_get_vdd_value(unsigned short vdd)
+{
+	switch (1 << vdd) {
+	case MMC_VDD_165_195:
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v
+	 * so we only get here if the driver deliberately
+	 * added the 2.0v range to ocr_avail. Map it to 1.8v
+	 * for the purpose of turning on the power.
+	 */
+	case MMC_VDD_20_21:
+		return SDHCI_POWER_180;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		return SDHCI_POWER_300;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+	/*
+	 * 3.4V ~ 3.6V are valid only for those platforms where it's
+	 * known that the voltage range is supported by hardware.
+	 */
+	case MMC_VDD_34_35:
+	case MMC_VDD_35_36:
+		return SDHCI_POWER_330;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
+
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-		/*
-		 * Without a regulator, SDHCI does not support 2.0v
-		 * so we only get here if the driver deliberately
-		 * added the 2.0v range to ocr_avail. Map it to 1.8v
-		 * for the purpose of turning on the power.
-		 */
-		case MMC_VDD_20_21:
-			pwr = SDHCI_POWER_180;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
-			break;
-		case MMC_VDD_32_33:
-		case MMC_VDD_33_34:
-		/*
-		 * 3.4 ~ 3.6V are valid only for those platforms where it's
-		 * known that the voltage range is supported by hardware.
-		 */
-		case MMC_VDD_34_35:
-		case MMC_VDD_35_36:
-			pwr = SDHCI_POWER_330;
-			break;
-		default:
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr) {
 			WARN(1, "%s: Invalid vdd %#x\n",
 			     mmc_hostname(host->mmc), vdd);
-			break;
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 66ab90bd4017..0f78708d0c70 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -836,6 +836,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
-- 
2.25.1

