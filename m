Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C595DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 07:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiEZHI7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 May 2022 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiEZHI6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 03:08:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420673191C
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 00:08:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x143so972777pfc.11
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iU8b9CKWY+pBhc9zvETEGADsdNBeh9PzyRIeJQgvAuo=;
        b=CJ+yqoIV4xo4KUoNB6vSNjar1HzLovQrOduR3NDsk/i2xIesqmT5RkKPEEc0Ksar9Z
         /u/TPUUlOA6hEAbBKGPLIskRwTKZAcEIK0kCKTXEMYV12jnOeSS3ClqNvg0jL/2mVbAI
         kfSvZiXMIMkyES0Djdoc1KSI/pBwUgu5awoILnEYvX4uvur1huUV/VDF/NpTS3myFn3L
         rKn+Tbms0vJZdvmqvBiGmeYYJY0uN1GdC1tHyfBPcuzhIT7Upk2rFnw18rJLf8jTuR/y
         TlUwQpHkik7HxqxNh5Wbs6+yzrpi3HztFLu6MO3ZgB+y5jyxnMeYqSDdTp/ZmyPdqoUM
         wyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iU8b9CKWY+pBhc9zvETEGADsdNBeh9PzyRIeJQgvAuo=;
        b=E8bxULkBW0O3UYhIkGsG/2JZ6ct1q+hCBywtoukqJugxOll0Tzd0LZlCEa6Ixxnzom
         3ulCJeGirn6fLFR6Mo96UHwVYpvwjZva5nSnjEK8GSFQKOZY0W9gfpF4MOBb4wUKhREe
         kfzJuCx2rdPYPq9lm3pxNlpH0zq8Dv8aYVkwvx2zo/WOisDZU0ulmPbz7Ddwfchejm/k
         DRyt8pS8A6zO+F0lSGA46hi+6qttoj5ULVrplJYOetgxyUqXX4Mh7hLK6Q9X0RtXTvwC
         U6JwMv/8Ndem92J23pkyZdAtnbx1mHZqpnS4ZlPkU0of0NOAbELmDj9aoQyMXtURk49H
         LRIA==
X-Gm-Message-State: AOAM532WeVTemd08AbYkBcTc3kHOIDUdYH9VWyUnJ9tx+4d3Fef1PNog
        eCJAkqEXPkkUgGPAPqaEswzwsF/1bgA=
X-Google-Smtp-Source: ABdhPJwb+XjMWzC+q981YYxUJODtPqdynnqQVI/r9xGlERSIwSXrbyM1syuG/w+GhEyTUBcoxi+lXg==
X-Received: by 2002:a63:31d0:0:b0:3f6:2299:cd20 with SMTP id x199-20020a6331d0000000b003f62299cd20mr31850221pgx.27.1653548936723;
        Thu, 26 May 2022 00:08:56 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id m8-20020aa79008000000b0050dc76281d3sm623593pfo.173.2022.05.26.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:08:55 -0700 (PDT)
From:   jasonlai.genesyslogic@gmail.com
X-Google-Original-From: jason.lai@genesyslogic.com.tw
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Thu, 26 May 2022 15:08:19 +0800
Message-Id: <20220526070819.22151-1-jason.lai@genesyslogic.com.tw>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jasonlai.genesyslogic@gmail.com>

Resend this patch due to code base updated to 5.18.0-rc3.

This patch is based on patch [1] and remove data transfer length checking.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter and
and exit L1 state.

Unfortunately, entering and exiting L1 state is signal handshake in
physical layer, software knows nothiong about it. The only way to stop
entering L1 state is to disable hardware LPM negotiation on GL9763E.

To improve read performance and take battery life into account, we reject
L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable L1
negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=510801&archive
=both

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 60 +++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..86200b73c0b0 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -95,9 +95,12 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG       0x8A0
+#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
+
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MID 0x54
+#define   GLI_9763E_CFG2_L1DLY_MID 0x54		// Set L1 entry delay time to 21us
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -144,6 +147,10 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+struct gli_host {
+	bool lpm_negotiation_enabled;
+};
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -818,6 +825,53 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+
+	if (enable)
+		value &= ~GLI_9763E_CFG_LPSN_DIS;
+	else
+		value |= GLI_9763E_CFG_LPSN_DIS;
+
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
+static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
+
+	cmd = mrq->cmd;
+
+	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
+		gl9763e_set_low_power_negotiation(slot, false);
+		gli_host->lpm_negotiation_enabled = false;
+	} else {
+		if (gli_host->lpm_negotiation_enabled == false) {
+			gl9763e_set_low_power_negotiation(slot, true);
+			gli_host->lpm_negotiation_enabled = true;
+		}
+	}
+
+	sdhci_request(mmc, mrq);
+}
+
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -1016,6 +1070,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
+
+	host->mmc_host_ops.request = gl9763e_request;
+
 	gli_set_gl9763e(slot);
 	sdhci_enable_v4_mode(host);
 
@@ -1109,4 +1166,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.allow_runtime_pm = true,
 #endif
 	.add_host       = gl9763e_add_host,
+	.priv_size      = sizeof(struct gli_host),
 };
-- 
2.36.1

