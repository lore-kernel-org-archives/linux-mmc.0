Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29538624E;
	Wed, 22 May 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376246; cv=none; b=J6fE3T0BuZdbB/sJuohW/fKfX117Eltr9L0KVcu2FQaFbgLYIHbZIDKjBfyEWgBlNJ6zM2kSXps9aKcXeRC4lnVbCfC3Aqp0ffR2fgG9ULyXWg0BHkNONrGr8UB1qm1crH0/Z0HjQBqNphCPEGj0x7M/DJoVII4osHTFLcZI3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376246; c=relaxed/simple;
	bh=O2I8lWiIa+e3vWwQXk4xKH/yJO1rty4U17nEZLqK42g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWSIgRZtpcDO91VNkfBWzVlH5pk2Gx9eCpKjJXrDA2dhsajPvgE8+PSMwAiyt46j6q9cbLXvLXVqVLl1e2QSCQ01SoWq7wp8Y5hm2apa31z16UcbBGTvMyEqyVae1uZLvcANALjQApoKV+Zv72/RvkcnSU/2hrC5vCuoAJoTfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP+QnvT4; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP+QnvT4"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36d93568a58so22004395ab.3;
        Wed, 22 May 2024 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376244; x=1716981044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE0H2RxssWQXN9aqLMp8xQYjZc1ttCR56vJVWiJ8IzQ=;
        b=NP+QnvT49+z6R7n41kuf4aCZhQInwHxjXhTwpKUbSAMnPs4ggr9fj6a4XQLlutfiHt
         L/gJg/0ARx9MotVfVREuWePd27LVcngsuC++4gobvo+c++OzMctMej0dLKwjzET2dOeh
         ppmdvrOHzBjKU3m6Vz7HVvdwAGH4smEnulkDeEDKTsXYnpLTsXf7OYGpQFZdRiI6APLO
         Efgbaye4Mjj5ZXxb4dSFWZyBPPGnr6GZN6NZ+pZ1JpSk6uZo6H9VMYrju7QjxQtCrT4R
         EcJIROYjlDBqJElHhZK7aYoKeolKRjxgrn+ExSR88G5atnZLfLjQDAzQcMxJ7XO1d12K
         SEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376244; x=1716981044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE0H2RxssWQXN9aqLMp8xQYjZc1ttCR56vJVWiJ8IzQ=;
        b=hwFcTZ0uIAtO8eIE4exHD2kTa8ub2FV+JJb1NF253FzXXndFo791Z2fo0tyL8zPNzs
         IQV7s790jch3MLvvE3ksnec6dU0iD8aHEiq2TEYWm5CLKwqtdklZxIqMAQv+NNSYMJux
         OBPiTJvgmgPjnNMt8Bml5RJOYKXoqwuFvV/aYIHeRMm8NvWGpvxINIn22OSiurkzisGz
         1azRPypVLBK4eupexscQ4xNVj8DLSvTau+TNaN/6Hu1ElbKYgqEV/60i+NRAsbK2cP+5
         RBXpz/wtTRfni+jb0S9SyvOcf67k30dbB/t+WNCovk1HB8mR71e+YtulIuQeRmUHMw1x
         9u2w==
X-Forwarded-Encrypted: i=1; AJvYcCVtjJHhp7YdkJ1tFrXuDVddHsOnTqTZJWYpQ7o+Tkx2h8EEwnNGDm3hvqQavjVAzR069Y3vxlZP4dBFfqQPHr1heUiTLT7QUQSwaPUA
X-Gm-Message-State: AOJu0YzUBlHgdw8lr9+7l9DVeYQAiLOfZ8R0qGlmFbqEQtssmgUof8Cd
	s1NODj5F7MsAED2j8UDs+Lol8SOtyrNp1Wtc0nU9kAG2CUJ48Dzb
X-Google-Smtp-Source: AGHT+IFzV5YoBiaL3MVAsDlkwPV26N8tC8bxwOuQVLuhDcMnM3QrpFkdup09u4nH7SyRq2CxwtX2wg==
X-Received: by 2002:a05:6e02:1c21:b0:36b:3a3b:b2c0 with SMTP id e9e14a558f8ab-371faf4ee6cmr13340055ab.32.1716376243755;
        Wed, 22 May 2024 04:10:43 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:43 -0700 (PDT)
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
Subject: [PATCH V16 23/23] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
Date: Wed, 22 May 2024 19:09:09 +0800
Message-Id: <20240522110909.10060-24-victorshihgli@gmail.com>
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

Changes are:
 * Enable the internal clock when do reset on UHS-II mode.
 * Increase timeout value before detecting UHS-II interface.
 * Add vendor settings for UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V15:
 - Add gl9767 to support uhs2 function.

---

 drivers/mmc/host/sdhci-pci-gli.c | 152 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-uhs2.c    |   3 +-
 drivers/mmc/host/sdhci-uhs2.h    |   1 +
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 5df6be758b06..20f19cec6e64 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -210,6 +210,10 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_UHS2_PHY_SET_REG1				0x90C
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR		  GENMASK(31, 29)
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE	  0x3
+
 #define PCIE_GLI_9767_SDHC_CAP			0x91C
 #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
 
@@ -228,9 +232,15 @@
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
 
@@ -240,6 +250,28 @@
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
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE	  0x3
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
@@ -1198,8 +1230,35 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
 
 static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
-	gli_set_9767(host);
+	u16 clk_ctrl;
+	u16 ctrl2;
+
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
+		/* need internal clock */
+		if (mask & SDHCI_RESET_ALL) {
+			ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+			if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHCI_CTRL_UHS2_ENABLE)) {
+				sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
+			} else {
+				sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
+				sdhci_wait_clock_stable(host);
+				sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL2);
+			}
+		}
+		if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
+			sdhci_gli_uhs2_reset_sd_tran(host);
+
+		sdhci_uhs2_reset(host, mask);
+		gli_set_9767(host);
+	} else {
+		sdhci_reset(host, mask);
+		gli_set_9767(host);
+	}
 }
 
 static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -1289,6 +1348,87 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
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
+	struct pci_dev *pdev;
+	u32 value;
+
+	pdev = slot->chip->pdev;
+
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+		value |= PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
+			 PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+		gl9767_vhs_read(pdev);
+
+		sdhci_uhs2_set_power(host, mode, vdd);
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
+		sdhci_set_power(host, mode, vdd);
+	}
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -1325,6 +1465,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
 	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
+	gl9767_vendor_init(host);
 
 	return 0;
 }
@@ -1828,12 +1969,19 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
 	.reset			 = sdhci_gl9767_reset,
 	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
 	.voltage_switch		 = sdhci_gl9767_voltage_switch,
+	.dump_uhs2_regs		 = sdhci_uhs2_dump_regs,
+	.set_timeout		 = sdhci_uhs2_set_timeout,
+	.irq			 = sdhci_uhs2_irq,
+	.set_power		 = sdhci_gl9767_set_power,
+	.uhs2_pre_detect_init	 = sdhci_gli_pre_detect_init,
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
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c830ee352504..47180429448b 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -125,7 +125,7 @@ static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
 	}
 }
 
-static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = 0;
@@ -165,6 +165,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 		mdelay(5);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
 static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
 {
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 42f34ca75275..c4a860f4e1e0 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -185,5 +185,6 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
 int sdhci_uhs2_add_host(struct sdhci_host *host);
 void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
+void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

