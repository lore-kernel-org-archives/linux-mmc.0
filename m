Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1D1A3BB3;
	Thu, 29 Aug 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926645; cv=none; b=GG/iDpisrZcfg6aUkinc07ONorwkLgGFOGrbIgqvo0LEu2AeN/gp/AqolKFSYcOYn1J4GUuB8L+tw5NyuEi66n8QU8ANo97QgfYFgeBvEhIfhD8tyGhS23fl43AI6nEtb6e9CfOm+5VeF4zhmJH6Kh8eCEKlEw/9fNLZcMKH9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926645; c=relaxed/simple;
	bh=13cusoizEQTAQsXjlv8RWYwKmqCzF28m48Il+Khv+so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkXHNoQ7HtvviftE5csyDFo8QpxUAIGFFcsUQFbquuvMi51ZoSsYoP2/QX3IMxYMVjVAz6cYPYVbl3Q1TOihqXwPTb62ZewRlbrKPBx27OGtEHEoHlnqwfLcKFb+dow7GNxoe8I26xNbQ1WkI5jHgC/gWG8whYR0nS7zjBdlbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLGzyvUo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLGzyvUo"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70930972e19so171145a34.3;
        Thu, 29 Aug 2024 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926643; x=1725531443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/GadsYN5V+df+VWiVoi4r4UKYiJV6Ck1jQ2/akC0Cs=;
        b=PLGzyvUoVbxHHv2cZu73LLNkYdy4L+ghqC1GJ9LGqI9WTyQLz7XbYDdeh2cGRcnwyO
         OQZwDYf9Fmreac6rfb2RN8Y6n+p+OK+dXqE9WAQhEU+N1vuDSRe3+rM8GiQ/nBiAiaaQ
         B2zgJ20FN1hwIUEqyYjbftzh5Xf5Vq46GFvyLHEd79coSXln+DzRiYz4BsbxURxY7ilh
         Oa+/YSMK0MwwhfVghdEJHmu/zKNKhr6FIjnNZZMShlLqzXE1mzXp1uDpX42NSznzT4QO
         6T6Aybzyse1tNGvx/oxrcpX8ak+Jmpclu/htDFDnGFdqzbQvq894mgGkHwBS6UmsT09l
         44pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926643; x=1725531443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/GadsYN5V+df+VWiVoi4r4UKYiJV6Ck1jQ2/akC0Cs=;
        b=v3MXULhxX7CK2nO31xkmmqfieidD+vEpVNTG6YdciOFtwoQB0cpQzI5rXYorysBDFB
         H45hEnwn9UiiNcOqzJoG3d2uC2iHuw6dQA2/6h/a7AC7uMMJVyefTUxW6BtX4LdZQbac
         x8llvDIwBWL3nzUPkYqaEOI7ulwT6ML4c5vFL5UwFer8V6cFksc/L8J0mjOwC5HkHrVe
         BiGesBZCq68mUN0KbqKL0Lw+2BMkNcz7lFfRoO5NIIzCeFa0nb898qM74V8Om7rFswmt
         ZQCNtEhOf9B7GwyF+70ehzjI2sz/OwJ58+Tb4mwtZulXw6arJKR92rQP2CYw7+Uf5gwt
         AmHA==
X-Forwarded-Encrypted: i=1; AJvYcCUwid4BoyMGl8cHPO/mMN2lDpMC85rICvfGB0OdutTglY1th8muTUhHDlzD93O1MQVNL8l07rwJibwoRfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/NNoaB+b20a7pg6oqjrGiDE/97PT9IJ1kvsHtkuavrS8JhDF
	ldwJ2JT0LjFqYRCJVuSDAjAbpFOInZopBP1phTuVbr3yGoJfs81o
X-Google-Smtp-Source: AGHT+IHJb7gSLrQxG+WWuSmqXR0cNcDS9tf5q1guLPUSWAVXuMICqjlJ7egRbeG/G+3CSuSpbyd18g==
X-Received: by 2002:a05:6358:78a:b0:1ac:671a:f39f with SMTP id e5c5f4694b2df-1b603c14850mr285760555d.11.1724926642985;
        Thu, 29 Aug 2024 03:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:17:22 -0700 (PDT)
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
Subject: [PATCH V19 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
Date: Thu, 29 Aug 2024 18:15:39 +0800
Message-Id: <20240829101539.5058-23-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
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

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
---

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

 drivers/mmc/host/sdhci-pci-gli.c | 211 ++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index e826e02a0d52..2375a810c2b8 100644
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
@@ -1150,6 +1194,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
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
@@ -1157,6 +1226,12 @@ static void gli_set_9767(struct sdhci_host *host)
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
@@ -1195,7 +1270,52 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
 
 static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+	u8 rst;
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
+			if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask), 10, 100000,
+						     false, host, SDHCI_SOFTWARE_RESET)) {
+				pr_err("%s: Reset 0x%x never completed.\n",
+				       mmc_hostname(host->mmc), (int)mask);
+				sdhci_dumpregs(host);
+				/* manual clear */
+				sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
+				return;
+			}
+		} else {
+			sdhci_uhs2_reset(host, mask);
+		}
+	} else {
+		sdhci_reset(host, mask);
+	}
+
 	gli_set_9767(host);
 }
 
@@ -1286,6 +1406,86 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1322,6 +1522,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
 	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
+	gl9767_vendor_init(host);
 
 	return 0;
 }
@@ -1825,12 +2026,20 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
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

