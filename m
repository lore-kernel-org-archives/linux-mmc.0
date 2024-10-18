Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06D2076A5;
	Fri, 18 Oct 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248898; cv=none; b=PGYljJVF5oIsmL0/p9A7yIa/5iwrkVZ0gyiYCBQQ9q7dEl1JN/l4ciWH8JRcGw9F+wmI23n07nvhYJnNKNICAQeUViR2V6RmKgOjlxSCbq85jL/npMYzS0xSrp72YnIGrIcy1rfx9zG9sVzygo3jp7Ajdo5nBvv4Z2aa/c+TlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248898; c=relaxed/simple;
	bh=qmf9WfIviTtJwSgU5Q0mUQTSQ+PhALIXkUuHCsZsb04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWatHwIZsFuUeBrLtrRUcqWi2SdUJ1gFpfgqBLX1yUmEgUbMFl4AEJ4DyYH+uvO7+RjcHBWlPLqU4wJ1M6SrRqPLNYdkNzwo/wSsOyN5c3+5iop4qpVbZAF2lBWtztKQwxDg+fc4Ka9WjodMl8NJVp+U+aQsRdEUBBGOolP7WAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyoCebT0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyoCebT0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c693b68f5so21566425ad.1;
        Fri, 18 Oct 2024 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248896; x=1729853696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbe7qhvT8ntO58X7PAXaQ3B+VwyPxi6oPgIOkOOFc4A=;
        b=DyoCebT0qhdsaQoYcj36G2CTx/ueX0SImtsaFYGbPHPpN4zRhGpqWto3/Y0cNGYYnm
         xia8ZXgzxWlAckLmrQS6Ujt2o7jJrc3eeGt1WYA0sw4NYznbhAhV91LiVGKnimklag4q
         CvMhWNmiOCopow3UQH8dw+heO4eXupxPZiM3Q88OFT4bMlQrMMeYMmpWjgk3sjRciLe1
         1mY/1J7JG4lIAmuDpfAKifLycnJtnAoTmUldKCQNi3bSwUiNte5y5nk5C4sQJ+j902h6
         M+wZXSixSAyT3/dZF58WifcrXsBfxZMAKGywCpV2viN0IkLVzQyyRhGhrdYrL1bZhpHv
         Xjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248896; x=1729853696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbe7qhvT8ntO58X7PAXaQ3B+VwyPxi6oPgIOkOOFc4A=;
        b=CHHprBemU+V9nplmUcMi6tFXabmmrS/Flz+L4MaJC547kx6ou49NdNGElpgbTxoCC2
         E3yEadYvJar+UH+8t2pYJG6gmTDrLFtLlcVt+n1u49TMtJvXMJLRkfk52zuEbRtQRb0H
         utCRQbNKH+atuASOsFlPPuV08WJsbss0UeqRD/zfLic0PETVJekW2VUQ4js9GKDyKo3e
         PkqbkShEL5KCQERBMefP3Mi+hxSvUEY3eaol9Xop2NC/1KQCkbIsSoul8435HLzgNqpX
         5v6sZ7+GV4lVuASHuJkOn+I3HsjT7FkUEWadDenpIjyOx2wRFgrpUb8f1+xC9doS8Kdt
         O91A==
X-Forwarded-Encrypted: i=1; AJvYcCUmz8m+SRoMX/ytQYTV2WYCzfJua+JRKm3T4YKANzZ+Y6xmcWBMC1N8JUclP56SBJ41qjNdzi6XYHEYMZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmuAf44mqQv0Mmkt55VnDPgKZGHzUZwNVIUx+aPaidnPswKJA
	nMCWRIBJcbzYmLtnS5okVhrcds9IwX8/E3MRnLSyElrfjQuGpxU6
X-Google-Smtp-Source: AGHT+IFgvOo4jI1IkmyMPwudwrlZSTUtS0Cp+rO5DDOEKe6bcfUVkFDpC5zoHRcT1p1Vt/zjNsaMdA==
X-Received: by 2002:a17:902:f68f:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-20e5a75a5b9mr22736325ad.18.1729248896001;
        Fri, 18 Oct 2024 03:54:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:55 -0700 (PDT)
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
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Lucas Lai <lucas.lai@genesyslogic.com.tw>
Subject: [PATCH V23 16/16] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
Date: Fri, 18 Oct 2024 18:53:33 +0800
Message-Id: <20241018105333.4569-17-victorshihgli@gmail.com>
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

Changes are:
 * Enable the internal clock when do reset on UHS-II mode.
 * Increase timeout value before detecting UHS-II interface.
 * Add vendor settings for UHS-II mode.
 * Use the function sdhci_gli_wait_software_reset_done() for gl9767 reset.
 * Remove unnecessary code from sdhci_gl9767_reset().

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
--

Updates in V21:
 - Remove unnecessary code from sdhci_gl9767_reset().

Updates in V20:
 - Use the function sdhci_gli_wait_software_reset_done() for gl9767 reset.

Updates in V19:
 - Use sdhci_gli_enable_internal_clock() to simplify the code
   in the sdhci_gl9767_reset().
 - Directly reading the SDHCI_PRESENT_STATE register to replace
   the get_cd() avoids the possibility of the get_cd() sleeping
   in the sdhci_gl9767_set_card_detect_debounce_time().
 - Refine the position of gli_set_9767() in the sdhci_gl9767_reset().

Updates in V18:
 - Add new register settings for gl9767.
 - Add card_event in the sdhci_ops for gl9767.
 - Add sdhci_gl9767_set_card_detect_debounce_time()
   to configure the gl9767.
 - Adjust the sdhci_gl9767_reset() process for gl9767.

Updates in V17:
 - Use mmc_card_uhs2() to simplify the code in the sdhci_gl9767_reset().
 - Use mmc_card_uhs2() to simplify the code in the
   sdhci_gl9767_set_power().
 - Add sdhci_gli_overcurrent_event_enable() to sdhci_gl9767_set_power().

Updates in V15:
 - Add gl9767 to support uhs2 function.

---

 drivers/mmc/host/sdhci-pci-gli.c | 202 ++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 708138eecaa7..cf2486ec7b9a 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -174,6 +174,15 @@
 #define PCI_GLI_9755_MISC	    0x78
 #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
 
+#define SDHCI_GLI_9767_SD_HOST_OPERATION_CTL				0x508
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK	  BIT(0)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE			  GENMASK(21, 16)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE	  0x05
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE	  0x3F
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE		  GENMASK(23, 22)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS	  0x2
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS	  0x3
+
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -210,6 +219,13 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_RESET_REG				0x8E4
+#define   PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET	  BIT(0)
+
+#define PCIE_GLI_9767_UHS2_PHY_SET_REG1				0x90C
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR		  GENMASK(31, 29)
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE	  0x3
+
 #define PCIE_GLI_9767_SDHC_CAP			0x91C
 #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
 
@@ -228,9 +244,15 @@
 #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
 
 #define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2		  BIT(5)
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL	  BIT(8)
 #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
 #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
 
+#define PCIE_GLI_9767_UHS2_PHY_SET_REG2					0x948
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING		  GENMASK(22, 21)
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE		  0x0
+
 #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
 #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
 
@@ -240,6 +262,28 @@
 #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
 #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
 
+#define PCIE_GLI_9767_UHS2_CTL1				0x95C
+#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS		  BIT(5)
+#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL		  BIT(6)
+#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN		  GENMASK(10, 7)
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE	  0x3
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV		  GENMASK(14, 11)
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE	  0xf
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS		  GENMASK(16, 15)
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE	  0x0
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV		  GENMASK(18, 17)
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE	  0x0
+#define   PCIE_GLI_9767_UHS2_CTL1_PDRST			  BIT(25)
+#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE		  0x1
+
+#define PCIE_GLI_9767_UHS2_CTL2			0x964
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC		  GENMASK(3, 0)
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -1155,6 +1199,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	gl9767_vhs_read(pdev);
 }
 
+static void sdhci_gl9767_set_card_detect_debounce_time(struct sdhci_host *host)
+{
+	u32 value;
+
+	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+	value &= ~(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE |
+		   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE);
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)
+		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE) |
+			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS);
+	else
+		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE) |
+			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS);
+	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+}
+
+static void sdhci_gl9767_card_event(struct sdhci_host *host)
+{
+	sdhci_gl9767_set_card_detect_debounce_time(host);
+}
+
 static void gli_set_9767(struct sdhci_host *host)
 {
 	u32 value;
@@ -1162,6 +1231,12 @@ static void gli_set_9767(struct sdhci_host *host)
 	value = sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
 	value &= ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
 	sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
+
+	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+	value &= ~SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK;
+	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+
+	sdhci_gl9767_set_card_detect_debounce_time(host);
 }
 
 static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
@@ -1200,7 +1275,43 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
 
 static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL) {
+		sdhci_gli_enable_internal_clock(host);
+
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_RESET_REG, &value);
+		value &= ~PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_RESET_REG, value);
+
+		if (read_poll_timeout_atomic(pci_read_config_dword, value,
+					     !(value & PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET),
+					     1, 5, true, pdev, PCIE_GLI_9767_RESET_REG, &value)) {
+			pr_warn("%s: %s: Reset SDHC AHB and TL-AMBA failure.\n",
+				__func__, mmc_hostname(host->mmc));
+			gl9767_vhs_read(pdev);
+			return;
+		}
+		gl9767_vhs_read(pdev);
+	}
+
+	if (mmc_card_uhs2(host->mmc)) {
+		if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) {
+			sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+			sdhci_gli_uhs2_reset_sd_tran(host);
+			sdhci_gli_wait_software_reset_done(host, mask);
+		} else {
+			sdhci_uhs2_reset(host, mask);
+		}
+	} else {
+		sdhci_reset(host, mask);
+	}
+
 	gli_set_9767(host);
 }
 
@@ -1291,6 +1402,86 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static void gl9767_vendor_init(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR,
+			    PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING,
+			    PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
+			    PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
+			    PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
+			    PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
+			    PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
+			    PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
+			    PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
+			    PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
+			    PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
+			    PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+
+	gl9767_vhs_read(pdev);
+}
+
+static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,	unsigned short vdd)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	if (mmc_card_uhs2(host->mmc)) {
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+		value |= PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
+			 PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+		gl9767_vhs_read(pdev);
+
+		sdhci_gli_overcurrent_event_enable(host, false);
+		sdhci_uhs2_set_power(host, mode, vdd);
+		sdhci_gli_overcurrent_event_enable(host, true);
+	} else {
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+		value &= ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
+			   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL);
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+		gl9767_vhs_read(pdev);
+
+		sdhci_gli_overcurrent_event_enable(host, false);
+		sdhci_set_power(host, mode, vdd);
+		sdhci_gli_overcurrent_event_enable(host, true);
+	}
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -1327,6 +1518,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
 	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
+	gl9767_vendor_init(host);
 
 	return 0;
 }
@@ -1830,12 +2022,20 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
 	.reset			 = sdhci_gl9767_reset,
 	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
 	.voltage_switch		 = sdhci_gl9767_voltage_switch,
+	.dump_uhs2_regs		 = sdhci_uhs2_dump_regs,
+	.set_timeout		 = sdhci_uhs2_set_timeout,
+	.irq			 = sdhci_uhs2_irq,
+	.set_power		 = sdhci_gl9767_set_power,
+	.uhs2_pre_detect_init	 = sdhci_gli_pre_detect_init,
+	.card_event		 = sdhci_gl9767_card_event,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9767 = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9767,
+	.add_host	= sdhci_pci_uhs2_add_host,
+	.remove_host	= sdhci_pci_uhs2_remove_host,
 	.ops		= &sdhci_gl9767_ops,
 #ifdef CONFIG_PM_SLEEP
 	.resume		= sdhci_pci_gli_resume,
-- 
2.25.1

