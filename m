Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225884FD4;
	Wed, 22 May 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376216; cv=none; b=EUUUEtVptX3n4DxBX/vnJ67kt+pQ/w+ahOB9lifWRXFIiXQDIU05TtUolQF168uxKKugvJKqggcye5kt4nT33h5TS8kf6mSp9Y32Z1Zdx0EMkAic7HCXjsasi6fa2BN387Qudg9/AIZ3RDyGqerYQUnpx3kg/tM6S07JpYGZ53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376216; c=relaxed/simple;
	bh=0TLofyjwQTQla0Rlw2T5BVQEu+UtmZifTvbEBKL72A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQ8GDQujL2fXoZ00/jPhsIolGeMpvjNnBb7qByIofJXpTIbY704bGqQ0X6HmLQrFL27xLDxBzydd9xSxiLcWfzhf40XJNf1fAEpqEeoIDjzm1z6xmpKs5Vs8KpeL8OHhHqTuZ5wxYj9aKfjgkQVv7Aj0RLHAS8Yjho6YBcUF6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYAc8VWw; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYAc8VWw"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so14313205ab.3;
        Wed, 22 May 2024 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376214; x=1716981014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Namkkd/lW9WjiC+98csAA46vC5hNkb5kr9XbgPnp2lo=;
        b=FYAc8VWwoOogbH/8NXjw5Va5TaTPt0XVAeT4DV3Nmvsn2wEI8iObkEmgQTi3vfHQcC
         oaW9pc0OdyRUL4TGrEc3pRT3Jw7m6sc7ma5wyZWVBLG2aY2s9/Q5wayZolouMBPx1JJY
         86oLdAz8b6XynhiCCUCkxZVfYsv5zzkYZFqURidrxZ08e4BJgo6BQHwlKarUfwq7zfkj
         kJTh27a4rbYs6+nIgopM4LVWZKQ1E4gPI0kLXc+sXd80Bu+efVAEZk1dVygQOFDdVK+I
         mwTlDMaKW6IU7b1flxF59hOynmkbVgU0x2YL1vr+wvq2sj4pLvy/OipVxVrlVCGOcw3h
         tm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376214; x=1716981014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Namkkd/lW9WjiC+98csAA46vC5hNkb5kr9XbgPnp2lo=;
        b=VpdNOQ03DevqTqEjb4DMsHiHqDqMMock6dKYrsxoB3YxC+YPpmWP/UclKc+JALlDRI
         Q8fF9c+ZCvekRAxsx6omg/Y5XHHGADEytx8jnRBPH/L3pUMagMUaM5DYPLGB3sOjDBTL
         QcfkUKQ5eyKGqF3ExpnbqBU5ContSOwtRftba9B0BLxDstdrCRg8xVps2sFZueXfnojp
         vJ02y5ksCZNNIYDsZbSW+yg1EIGzui8CXZ5X/SpN5du166X9GSUe8CBIKasBHg5EE2d0
         p1Dp7g3p5N0EV7FwQctb22pKOktN0EkHNnyjJ+74UwaFSuIWx82DzikmBYiXIBt6+UeW
         IzUA==
X-Forwarded-Encrypted: i=1; AJvYcCVKl9QfDAFN2REVJh9+OWWHmUXt0aMP9xqsXGass/Q++UyERFWR7MzhmKpgiuB8hg8b7gCMsBYkV7cFerDUSK6TG9JBilkH2wPTQkWL
X-Gm-Message-State: AOJu0Yz3DibPZ/BJJ3DjHB2K7pq5g27NhmhBZ/gO/P1Mrrt8rJVqNlq+
	BttRTXyEaOtEGytyWqySP7ymDFe1H7Kso/SD/BuOWk+6NRO3kh1e
X-Google-Smtp-Source: AGHT+IE5QXuSY//ljDXaH77ckpoUASDVb2CIQmkUVWUEdroLeUuo5djYDfz1Mho8neTYge7MWTrlZQ==
X-Received: by 2002:a05:6e02:1c41:b0:36c:d52:e969 with SMTP id e9e14a558f8ab-371f8f21354mr18466985ab.6.1716376213612;
        Wed, 22 May 2024 04:10:13 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:13 -0700 (PDT)
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
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V16 15/23] mmc: sdhci-uhs2: add set_ios()
Date: Wed, 22 May 2024 19:09:01 +0800
Message-Id: <20240522110909.10060-16-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a sdhci version of mmc's set_ios operation.
THis is used to handle basic IO bus setting.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_set_ios().

Updates in V13:
 - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
 - Modify comment message.

Updates in V9:
 - Simplity the turning_on_clk in sdhci_set_ios().

Updates in V8:
 - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
 - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
 - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
   in sdhci_uhs2_set_ios().

Updates in V7:
 - Remove unnecessary functions.

Updates in V6:
 - Modify return value in some functions.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
 drivers/mmc/host/sdhci.h      |  2 +
 4 files changed, 132 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 8c802142e875..b663efc1c238 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -224,6 +224,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
 
+/**
+ * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
+ * @host:	SDHCI host
+ * @clear:	bit-wise clear mask
+ * @set:	bit-wise set mask
+ *
+ * Set/unset bits in UHS-II Error Interrupt Status Enable register
+ */
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
+
+static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+
+	/* change to use calculate value */
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+
+	sdhci_uhs2_clear_set_irqs(host,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
+				  0);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+	sdhci_uhs2_clear_set_irqs(host, 0,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
+
+	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->power_mode != MMC_POWER_OFF &&
+	    (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_B ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
+		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	host->timing = ios->timing;
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, ios->power_mode, ios->vdd);
+	else
+		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
+
+	sdhci_set_clock(host, host->clock);
+}
+
+static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
+		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
+
+	if (!mmc_card_uhs2(mmc)) {
+		sdhci_set_ios(mmc, ios);
+		return 0;
+	}
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return 0;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (ios->power_mode == MMC_POWER_OFF) {
+			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+			mmc_regulator_set_vqmmc2(mmc, ios);
+		}
+		return -1;
+	}
+
+	sdhci_set_ios_common(mmc, ios);
+
+	__sdhci_uhs2_set_ios(mmc, ios);
+
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 089a6c0cabda..e08aa60bf06b 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -180,5 +180,6 @@ struct mmc_command;
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b68c12655e70..e87197c9b346 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -1878,6 +1876,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_UHS2_SPEED_A:
+	case MMC_TIMING_UHS2_SPEED_A_HD:
+	case MMC_TIMING_UHS2_SPEED_B:
+	case MMC_TIMING_UHS2_SPEED_B_HD:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -2324,24 +2328,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
 	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
 }
 
-void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
-	u8 ctrl;
-
-	host->reinit_uhs = false;
-
-	if (ios->power_mode == MMC_POWER_UNDEFINED)
-		return;
-
-	if (host->flags & SDHCI_DEVICE_DEAD) {
-		if (!IS_ERR(mmc->supply.vmmc) &&
-		    ios->power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-		return;
-	}
 
 	/*
 	 * Reset the chip on each power off.
@@ -2358,8 +2347,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2375,6 +2362,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			mmc->max_busy_timeout /= host->timeout_clk;
 		}
 	}
+}
+EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
+
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	bool reinit_uhs = host->reinit_uhs;
+	bool turning_on_clk;
+	u8 ctrl;
+
+	host->reinit_uhs = false;
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		return;
+	}
+
+	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;
+
+	sdhci_set_ios_common(mmc, ios);
 
 	if (host->ops->set_power)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
@@ -2959,7 +2971,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2987,6 +2999,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 83caf209308e..e84e7b2c802f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -850,6 +850,8 @@ bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
-- 
2.25.1

