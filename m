Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6820263D;
	Fri, 18 Oct 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248865; cv=none; b=t+Uixbt9GkNs6fzB3nW6JtmMsQut1bPBwBP7HNQwNU8Nefij8K93yAE69Sb+qngTlZSJXGI/P99xnu+CU4jgELJkQfHc6Sw8UsultaivrJFjwrvxd1RATDR7gZaL7fksUFJuZ5vo0dbjvPn3LvjAllp4XJGbh3xjXKp/hu66B9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248865; c=relaxed/simple;
	bh=EJUupgG1XnQ584S2GhdGx1EZTFaSKXSl/i9dudKjyag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNfqRyhLQJJmJDqe+Q2eOsvsPeJJoW1Irg7+AkPHTrF4nAXEtX+EHImB6ffMUu4lz9wjeumr/WMB4eJ8CqHT4UUIQVCl1EWWqWPA2jkgjUlBfQM7Bb5Z0Sm9kLPaozIAV6tDxziAM3aF6Dw3/aHRjN338XyY+9PHb/6sZFkdViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS3ITPcK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS3ITPcK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e576dbc42so7709415ad.0;
        Fri, 18 Oct 2024 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248863; x=1729853663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISHPEovLGmEkwcnJ/lpZjrn6I9Dt/a+/WsXG5HfNPq4=;
        b=VS3ITPcKeN6qpJzP3/eh7IvImTYESwqMUvKWvD/2s5CKGyBFkCB1+w0GCeYzNto02B
         PSMY/dCoNfnsIzy8fABKs9DvhBy2pbr5sQFHrBy6LiqqaUiMJXzM96OZOX/3+Ok7Aq5B
         GlmKQezC+Jwb4J69YDWvn+8jehWrZIbEXSGCNpempjEzKE0I1s3CWz0BJcGcWR2LFkmm
         C8CVL99SVuuZDMGbWhBzQAhpg1VYt+UyFiS2IzLq9GuPnieAeZBe5OPGkd/N+6QOpbUl
         HDu/DUSE5iDV5MXSMvBuwhieSFC/D1bQHBcSzfawnHsykJP9xuYVBrgVwlKLPmaW78P+
         FCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248863; x=1729853663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISHPEovLGmEkwcnJ/lpZjrn6I9Dt/a+/WsXG5HfNPq4=;
        b=ebRViaR2fLhnZcsaH0U20Apk20BlLLsqnKtGTrvzLxMxxBaAXV0CNvFwCaJu2lFSOX
         pfNZ8PfVHe6NPbOnAAn+7c61L1joxzvMLC7fwgxmK1AtVZtQkzFuPFdreDPJkUBVdnmZ
         Tok2RY9nNNuOA6inkL6Wr6P1LfkpyZdzhJxglu3SOxYY8MqEpZnrxGYeytrLzwWhhqAP
         WneUkBda7eDHi+nnzvJ/KmD1qB7AEDIs5HDxlUUWww0BS9LjrybgKO51OjaSTlaGhWCr
         jztBV75E0MgKQuYKKPrGNA7SJH7MpfpxizuczOT1XKYeoWoLSF3NwF+BlsjgOkmHipnc
         yghg==
X-Forwarded-Encrypted: i=1; AJvYcCWUrsgfR1Ricp7hU68os81IliyZqz0De4BXY2glbeEBD9gxuGLQsLdfGdeZhLSw9cuyb4EsylmKWPbR0mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEYjxvi8uOcanZeubix1jqPL9rUB7dYo7XPnyw88Nf313g7xz
	hwT+eYAVLO2bL+9X8/bJlNa7m/FkC2uO3KBPhVeTuARKKx88wRuX
X-Google-Smtp-Source: AGHT+IHhT0JaUTsoQVhzk/VSIGQfPK+W4nKIYYb9SgDPF2lStYGuxeWlfMlHQo8f6Mj7p6vzMjCefQ==
X-Received: by 2002:a17:903:990:b0:20c:9285:e941 with SMTP id d9443c01a7336-20e5a904f15mr25692075ad.27.1729248863437;
        Fri, 18 Oct 2024 03:54:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:23 -0700 (PDT)
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
Subject: [PATCH V23 09/16] mmc: sdhci-uhs2: add set_ios()
Date: Fri, 18 Oct 2024 18:53:26 +0800
Message-Id: <20241018105333.4569-10-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a sdhci version of mmc's set_ios operation.
This is used to handle basic IO bus setting.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V22:
 - Adjust the patch order from v21 patch#14 to v22 patch#15 and
   add necessary code to avoid defined but not used warnings.

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

 drivers/mmc/host/sdhci-uhs2.c | 128 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   1 +
 drivers/mmc/host/sdhci.c      |  55 +++++++++------
 drivers/mmc/host/sdhci.h      |   2 +
 4 files changed, 165 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index d3af620c7b68..ee46dac891e5 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -208,12 +208,136 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
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
+static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_ios *ios = &mmc->ios;
+	int err = 0;
+
+	DBG("Begin uhs2 control, act %d.\n", op);
+
+	switch (op) {
+	case UHS2_SET_IOS:
+		err = sdhci_uhs2_set_ios(mmc, ios);
+		break;
+	default:
+		pr_err("%s: input sd uhs2 operation %d is wrong!\n",
+		       mmc_hostname(host->mmc), op);
+		err = -EIO;
+		break;
+	}
+
+	return err;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
  *                                                                           *
 \*****************************************************************************/
 
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
+{
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
+
+	return 0;
+}
+
 static int __init sdhci_uhs2_mod_init(void)
 {
 	return 0;
@@ -288,6 +412,10 @@ int sdhci_uhs2_add_host(struct sdhci_host *host)
 		/* host doesn't want to enable UHS2 support */
 		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
 
+	/* overwrite ops */
+	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
 	/* LED support not implemented for UHS2 */
 	host->quirks |= SDHCI_QUIRK_NO_LED;
 
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 0e1866a6bdb6..14713a31f8a5 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -183,5 +183,6 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 int sdhci_uhs2_add_host(struct sdhci_host *host);
 void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 366c3d30dba6..63fa1714930a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
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
@@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
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
@@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -2942,7 +2954,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2970,6 +2982,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0f78708d0c70..5c66927210bd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -848,6 +848,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask);
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

