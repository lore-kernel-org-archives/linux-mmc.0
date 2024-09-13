Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E91DC73E;
	Fri, 13 Sep 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223422; cv=none; b=deEOGBm/sC06TYCNi+bYED4Q3xaK1CvWjUsR8+K2Os6Q2CuFC7dacVC/ntD9Ok7fJI2ZUluIzfgN/707Sp+gBwh6bGKJPI8UYnlVahKPSEEU/3onmbr/JbI4kBmo59ajQvcPh16I+e/0zkF7wWcN0EjZFVmQIW4u0q4hpVj52C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223422; c=relaxed/simple;
	bh=qmf9WfIviTtJwSgU5Q0mUQTSQ+PhALIXkUuHCsZsb04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/Kvcxippozd3Q5aZSA7epXnCzAwtkNtrZkJMXzDWwqChNTtY8EcM+4xS+A3fHZKfGRc4oXm9YJF3ZMY/uTdaprJqLs0sV/jV7V0HnmIDUqpNt5AZuEDgkcAN7LITgkqO/e6VAS7m/FasMS+SKMXcX3q1yCQ16DlNToGePjul1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+jN4lGl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+jN4lGl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798661a52so1514827b3a.0;
        Fri, 13 Sep 2024 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223420; x=1726828220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbe7qhvT8ntO58X7PAXaQ3B+VwyPxi6oPgIOkOOFc4A=;
        b=h+jN4lGl6bRizy1wjjrVsXaYoQdpbD8ZP4kb8OTU1CoNJXc0qWuSj6h/m+HM9oxxK1
         g2QkqOvvfsuRFqRNQ2EGBkXbSZ0+6hEvOWhu2nK/pTbK5sxKAnIU9vvdu+0HjIaPG1qe
         eoFH1bbWOEbuvO7z80a8tI6sOZ6l2KFgwMHiFFrzxKl/A32A8P2/9z6iWPnIg7EiTGvM
         YLIBZhuhxfpto+wjqaNptmu2WZnlTpva7QYwGVmzn2AG47P3J2QxqNXC7O9DYSPluMZ5
         wIFoiawLnKDbJBTF4yXKw1aM+lwpM3cDNPMhzps8sHdWG/l51O1IKaLEkdzbhWjQAK60
         tH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223420; x=1726828220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbe7qhvT8ntO58X7PAXaQ3B+VwyPxi6oPgIOkOOFc4A=;
        b=FDBkZUfyD/EkIH/AQW48Sfx7tjDXh0pckdOdHitz2o/3MQF04HXh7RHlRs+51Hko6l
         8GV1qD1kmqv12g4YSOVMK5H3kU2FXpWCDLRr6cPrqc1YSjNpQQtWPCRJFJVduTDoGfpB
         50blpaQVriSBn8aBzwh6T9o2y9i48t78g8uzEQUbXGoCKY6vZJ5T02AOIr3hFAGbyqrY
         0YKHg/j/mz24b5dGanKDO7S3JAQ0VNmepns3AqWZgBRdnTwuOZ1Tuph+SIHBSFsrwq3b
         0IGya8b1EaR3e9gC8v6COX+qHnIcMsUHHZ5TM2Kr0em+HcorOTmlOele1hpcGV5iXLKZ
         3i4A==
X-Forwarded-Encrypted: i=1; AJvYcCUpqB/C1KtkE33cvbkGOGcOsgF6dRyZ9P0Ebca0L6BMgh2lBjAxVfTc/gminQf3KK4PWOCb7wXOXpW07Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpqq3p5x2+ZcCdbJFpKY2uDIW99Wzlbbn77jm2VXTgrFm/kKn
	t27n/1iPnHl7VCf/sZP+vCupymipExa/Ne62xEXhVy2C2uX18heg
X-Google-Smtp-Source: AGHT+IHxTFxmRKrnbhleEqE6JxqzNirwwJ12/WWWr2Ot9bMNvdHIfhdDoOCmOr0EuN42c59dGphWcQ==
X-Received: by 2002:a05:6a00:1d96:b0:714:2336:fa91 with SMTP id d2e1a72fcca58-71907f71a66mr24166023b3a.14.1726223420064;
        Fri, 13 Sep 2024 03:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:30:19 -0700 (PDT)
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
Subject: [PATCH V22 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
Date: Fri, 13 Sep 2024 18:28:36 +0800
Message-Id: <20240913102836.6144-23-victorshihgli@gmail.com>
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

