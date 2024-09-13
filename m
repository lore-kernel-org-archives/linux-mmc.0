Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A971D7E52;
	Fri, 13 Sep 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223396; cv=none; b=hxpfVOcaKZrZq6GwUX7zFlZ/XWKVUKblyDQk+RUPLEz1ToosSHJPibar6UQAUDNYGob/fWyYtCgZrA2cGd7puDHl7+nDBERvLc+GPj565z9V+L5hb7Ezs6G2Y9yJOrMQ92pjhIHsZbsgMmjgHygWFFZ6CWqV54LQ1ZN6PGoljCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223396; c=relaxed/simple;
	bh=Yf9c/+P80QvztzSDSZc5+mOLmfL0EsrfDRKcNyiiles=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPkW3qhQSs1/IOHAEH2rx/rtK6UDAZnoZYqo+gjleeU2CqaQtRpFYF5N3ldgjK0nX81orHQAt6AM+ktHWeHYQOizIV18Icgq00hDrdTBxpNIK4WyKFCnhVuP8BgcComHUleUtBe0C9B079Bm8EDKRsIAvGXVW4JrggbeXa5pTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbAzN/3a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbAzN/3a"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1723367a12.2;
        Fri, 13 Sep 2024 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223394; x=1726828194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRafvWR7zGbZF3TAjHo6lxtfuVouUGY2HW+1bCf77G0=;
        b=fbAzN/3aeCy2KlMzTqMaaoUIz5QTgUa8ZggybgrcCKAxyM8ZnHgs7otQzYIq/F/jMq
         WICTO5B0ChaDjLnrZRHiiERlGLTVQSJreSIyhWktEK5u1oOoNmyDis1FfnP8J7WpDLp/
         3HQztqRYTJ7cObnX5z1IaHVKbdrhSJA2rhtWWnA6ja3m5xpFgv6QpD9TDuHLS8pN2WCI
         5dfxLKvfJ5TVCg65TNt+TyRX2hZn4fFC7379Ei6JjiHsjB3cAa2QI6YaaaF5lWB5fKyb
         je6ePlnOkFrbSHf8gvIQ9M6w7Jkb3Z5kjx7Ql/m3R0MKc4RYA/ssdmfblxhL5hM6anNv
         HJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223394; x=1726828194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRafvWR7zGbZF3TAjHo6lxtfuVouUGY2HW+1bCf77G0=;
        b=obECjshe/PkW+CfAxMFxqARpAxv/HvdYq+XttPSPQTKavUJECKxPN63DoPjDS77lfA
         CUBSzEMTfKNSYQg3x7FxXf48ydDTa2nxLrX9XcjYGpMEu6V+lsQGP+VJ4Z925nzkL47x
         +ZUfqCoIRPfqCoFY2ecILgmbPGy/CvM9h0uuo3k1E8ZpYdDARGxy59gzcJW3mwI58FqD
         nvA861uHQLGfwr67c+ntc6Kg2Im1qzrXrZ+fd3d/gKty6qfOwlJp1bbMeJiE3H+u3y+y
         YzGTeWsOamoVmt8qLVoy+MIt2yX7PQB42UquAvp7N9gdvf9kpseHr08RONagx+tezvm4
         Na2A==
X-Forwarded-Encrypted: i=1; AJvYcCXTysN5LihUo6GOlsM9jYi15yygHP7GmdQuCb+sUfBKPSuXJP/8DW0jP3EgEMWpFTUVQCErpS0nN9QKexU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11G4t7VVzPRCE8F3oF5XJ6T/4KkfhOMry8IVR1j1d8bqxzqKL
	X4NIXWrxIT7XojehIE7J8RPlROdPHdO8n9xvdukWk/r0esYvnG/NVRYTb7kz
X-Google-Smtp-Source: AGHT+IFCWXc6iSi4oRGtGNsPJzrhA7Kh+5tIZ0gXps1OjU3xrrUNTAqYD8ZezKnT1e1lPNUGyn5ONw==
X-Received: by 2002:a05:6300:404c:b0:1cf:397f:b69 with SMTP id adf61e73a8af0-1cf75ee4c68mr8680295637.13.1726223394196;
        Fri, 13 Sep 2024 03:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:53 -0700 (PDT)
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
Subject: [PATCH V22 16/22] mmc: sdhci-uhs2: add related functions to initialize the interface
Date: Fri, 13 Sep 2024 18:28:30 +0800
Message-Id: <20240913102836.6144-17-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

UHS-II interface (related registers) will be initialized here.
The operations include mmc's uhs2_set_reg operations,
mmc's uhs2_detect_init operations, uhs2_[enable|disable]_clk operations.
After detected the UHS-II interface, the host's UHS-II capabilities will be set up here and
interrupts will also be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V22:
 - Adjust the patch order from v21 patch#15 to v22 patch#16 and
   remove unnecessary code to avoid defined but not used warnings.
 - Modify commit message.

Updates in V15:
 - Resolve merge conflicts and reduce unnecessary line breaks.

Updates in V13:
 - Merge Patch#15, Patch#16 and Patch#17 of v12 version into Patch#15 in v13 version.
 - Use definitions to simplify code.
 - Modify comment message.

---

 drivers/mmc/host/sdhci-uhs2.c | 204 ++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index ee46dac891e5..94e041520a54 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -26,6 +26,9 @@
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
 #define UHS2_RESET_TIMEOUT_100MS		100000
+#define UHS2_CHECK_DORMANT_TIMEOUT_100MS	100000
+#define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
+#define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
@@ -303,6 +306,186 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	u32 val;
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
+			      100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
+			      host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
+			      100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
+	    mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
+		       mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET);
+	caps_phy = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_1_OFFSET);
+
+	/* General Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
+	mmc->uhs2_caps.gap = FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_gen);
+	mmc->uhs2_caps.n_lanes = FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, caps_gen);
+	mmc->uhs2_caps.addr64 =	(caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type = FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_MASK, caps_gen);
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range = FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANGE_MASK, caps_phy);
+	mmc->uhs2_caps.n_lss_sync = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK, caps_phy);
+	mmc->uhs2_caps.n_lss_dir = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK, caps_phy);
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev = caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK, caps_tran[0]);
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK, caps_tran[0]);
+	mmc->uhs2_caps.maxblk_len = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK, caps_tran[0]);
+	mmc->uhs2_caps.n_data_gap = caps_tran[1] & SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	DBG("Begin do uhs2 detect init.\n");
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
+		return -EIO;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		return -EIO;
+	}
+
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+	/*
+	 * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
+	 * by SDHCI_UHS2_SW_RESET_SD
+	 */
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	return 0;
+}
+
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	int timeout_us = 20000; /* 20ms */
+	u32 val;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+			      10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
+	u16 sdhci_uhs2_gen_set_reg	= sdhci_uhs2_set_ptr;
+	u16 sdhci_uhs2_phy_set_reg	= sdhci_uhs2_set_ptr + 4;
+	u16 sdhci_uhs2_tran_set_reg	= sdhci_uhs2_set_ptr + 8;
+	u16 sdhci_uhs2_tran_set_1_reg	= sdhci_uhs2_set_ptr + 12;
+
+	/* Set Gen Settings */
+	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
+	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
+		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD)
+		value |= SDHCI_UHS2_PHY_SET_SPEED_B;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
+		FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	u32 val;
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
+			      100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
+			      SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
 static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -312,6 +495,27 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
 	DBG("Begin uhs2 control, act %d.\n", op);
 
 	switch (op) {
+	case UHS2_PHY_INIT:
+		err = sdhci_uhs2_do_detect_init(mmc);
+		break;
+	case UHS2_SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case UHS2_ENABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case UHS2_DISABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case UHS2_CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	case UHS2_DISABLE_CLK:
+		err = sdhci_uhs2_disable_clk(mmc);
+		break;
+	case UHS2_ENABLE_CLK:
+		err = sdhci_uhs2_enable_clk(mmc);
+		break;
 	case UHS2_SET_IOS:
 		err = sdhci_uhs2_set_ios(mmc, ios);
 		break;
-- 
2.25.1

