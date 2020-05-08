Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB81C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 06:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA35120735
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 06:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6CBDc9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEHGmS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgEHGmR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 02:42:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFBC05BD43;
        Thu,  7 May 2020 23:42:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so3800518pjb.5;
        Thu, 07 May 2020 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A30IQk3ogggjaNOhTGYAeu+qM41YyMlQPbFUWq4qh2w=;
        b=O6CBDc9ndD8MkMZyeJvyUm+2QaRhxd6HbGpU62Nkc0F6HMGe5EKuoY/SIWvowTqzV2
         9RFZErRPWj4Dob6L4sx5FHZJNHmQDcwPnU4aCVylBxIGttY1Fh6FGCkIgFjK6YpI16pz
         wdJSMsvBnmwXQVUTed4iZjyMBKGUwkgxIEH2r0LuozltSZFFzED7z0l28jD+HCk0c354
         x5xng/WQGjU86Gov53p34oa+yJSdCpFfOL/YZS78Bttod6XtAT4hAys8TJ36qGRfyGOO
         pjAR6twiqiuPC9dNOB5x+OiRRXgsV7OAbKmgsCyMS5ndEwppj9ZLWKP1k9EhM4/Z6quR
         NsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A30IQk3ogggjaNOhTGYAeu+qM41YyMlQPbFUWq4qh2w=;
        b=M2kru1Ff7F0IT8irEA5gOAShR3NDqfVSPUbT8jB1c0MfTpqnKUB4Nc95gJD3eaR0FU
         dblXsEuoTR0Vq+kO8T8SAEeFhe+5+9orLz200Exd826ouBpe60FYu1mIu4BPgnr4+4Oa
         AT9slX++xzlnSBIVRM/+ml0jGjGlHh62eHrcYa/9IOaIO86pke146IJq4DOpEg0bbcYM
         C7xoCGL1AaCs6zCQzXsIPhLXqpQa3gyvp0jK6sUu1g9ys5SJTxfxbsy+hqQfuySUEcDy
         VYXFd/VOGDFPT9RAJuOir9SP+hwI4R/lx33DhLYsW+0bLNocSit7BqzwXaG2UNbUZQEm
         J6/Q==
X-Gm-Message-State: AGi0PuYAOJmKD1vlhXQIF8arMJRVFBrlxfLNq/ahP/2PGxOtCsvKFqZ+
        LQc2nqqfTOCk4iLTLPb9dFs=
X-Google-Smtp-Source: APiQypLmvc9pEFW7+o7bkv1LP9kbRxmb0fq3SqSTawVp/T6d4N24keL3iNPurg35R3N5Zl1XHoWAqA==
X-Received: by 2002:a17:90a:6e0f:: with SMTP id b15mr4150458pjk.129.1588920137190;
        Thu, 07 May 2020 23:42:17 -0700 (PDT)
Received: from localhost.localdomain ([106.1.102.18])
        by smtp.gmail.com with ESMTPSA id x7sm756804pfj.122.2020.05.07.23.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:42:16 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support
Date:   Fri,  8 May 2020 14:41:54 +0800
Message-Id: <20200508064154.13473-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

GL9763E supports High Speed SDR, High Speed DDR, HS200, HS400, Enhanced
Strobe in HS400 mode, 1/4/8 bits data bus and 3.3/1.8V.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 106 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 3 files changed, 109 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index af736afb4b91..bb6802448b2f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1745,6 +1745,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
 	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
 	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
+	SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index fd76aa672e02..ca0166d9bf82 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -63,6 +63,19 @@
 #define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
 #define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
 
+#define SDHCI_GLI_9763E_CTRL_HS400  0x7
+
+#define SDHCI_GLI_9763E_HS400_ES_REG      0x52C
+#define   SDHCI_GLI_9763E_HS400_ES_BIT      BIT(8)
+
+#define PCIE_GLI_9763E_VHS	 0x884
+#define   GLI_9763E_VHS_REV	   GENMASK(19, 16)
+#define   GLI_9763E_VHS_REV_R      0x0
+#define   GLI_9763E_VHS_REV_M      0x1
+#define   GLI_9763E_VHS_REV_W      0x2
+#define PCIE_GLI_9763E_SCR	 0x8E0
+#define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -351,6 +364,81 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 }
 #endif
 
+static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
+					  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 val;
+
+	val = sdhci_readl(host, SDHCI_GLI_9763E_HS400_ES_REG);
+	if (ios->enhanced_strobe)
+		val |= SDHCI_GLI_9763E_HS400_ES_BIT;
+	else
+		val &= ~SDHCI_GLI_9763E_HS400_ES_BIT;
+
+	sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
+}
+
+static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
+					unsigned int timing)
+{
+	u16 ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if (timing == MMC_TIMING_MMC_HS200)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_MMC_HS)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_MMC_DDR52)
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= SDHCI_GLI_9763E_CTRL_HS400;
+
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
+static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_SCR, &value);
+	value |= GLI_9763E_SCR_AXI_REQ;
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
+static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+
+	host->mmc->caps |= MMC_CAP_8_BIT_DATA |
+			   MMC_CAP_1_8V_DDR |
+			   MMC_CAP_NONREMOVABLE;
+	host->mmc->caps2 |= MMC_CAP2_HS200_1_8V_SDR |
+			    MMC_CAP2_HS400_1_8V |
+			    MMC_CAP2_HS400_ES |
+			    MMC_CAP2_NO_SDIO |
+			    MMC_CAP2_NO_SD;
+	gli_pcie_enable_msi(slot);
+	host->mmc_host_ops.hs400_enhanced_strobe =
+					gl9763e_hs400_enhanced_strobe;
+	gli_set_gl9763e(slot);
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_gl9755_ops = {
 	.set_clock		= sdhci_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
@@ -390,3 +478,21 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
 	.resume         = sdhci_pci_gli_resume,
 #endif
 };
+
+static const struct sdhci_ops sdhci_gl9763e_ops = {
+	.set_clock		= sdhci_set_clock,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_gl9763e_signaling,
+	.voltage_switch		= sdhci_gli_voltage_switch,
+};
+
+const struct sdhci_pci_fixes sdhci_gl9763e = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.probe_slot	= gli_probe_slot_gl9763e,
+	.ops            = &sdhci_gl9763e_ops,
+#ifdef CONFIG_PM_SLEEP
+	.resume         = sdhci_pci_gli_resume,
+#endif
+};
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 42ccd123b046..d0ed232af0eb 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -72,6 +72,7 @@
 
 #define PCI_DEVICE_ID_GLI_9755		0x9755
 #define PCI_DEVICE_ID_GLI_9750		0x9750
+#define PCI_DEVICE_ID_GLI_9763E		0xe763
 
 /*
  * PCI device class and mask
@@ -195,5 +196,6 @@ extern const struct sdhci_pci_fixes sdhci_snps;
 extern const struct sdhci_pci_fixes sdhci_o2;
 extern const struct sdhci_pci_fixes sdhci_gl9750;
 extern const struct sdhci_pci_fixes sdhci_gl9755;
+extern const struct sdhci_pci_fixes sdhci_gl9763e;
 
 #endif /* __SDHCI_PCI_H */
-- 
2.26.2

