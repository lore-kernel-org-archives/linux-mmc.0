Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F92C07E98
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 09:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E6461260
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGEJDg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEJDf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 05:03:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582DCC061574;
        Mon,  5 Jul 2021 02:00:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so16110120pfa.13;
        Mon, 05 Jul 2021 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHOc9bMVKoqm+NvC6FFa+oLqE9OfPnAlc6OXJXSBlr4=;
        b=arXkm6K4q8szDA8QUlC/LWXrZ0jK1xMx4CmSn30PFLk1XUy6aClRHxeVQ4ye+UmBnR
         QjLHZUMnztqyf7QK8HTU6fAXa4XOBEnX90f+if0zNidy3fVhHWQi1bgKA7ecguMMh+ea
         GCVBMrO5YkhdE9YBMYf4vJ/HgGdGQyT88AYqLh+2+zUOWvpW+TZ03gd7mdt3R5/J7imY
         DHa2HtMb0yECYJuRb+HlDXCWNoe6czeXpGqSQ05MYFEUDkg/1bdBDnOnc9CDpD20AuIn
         ip4OhN5eod9xnM7qFbUyHP1WILzghWqniUZPnrPFWbGOqIlZieWMlL6efSigv2Vc1yDK
         uydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHOc9bMVKoqm+NvC6FFa+oLqE9OfPnAlc6OXJXSBlr4=;
        b=TIzNsv7V6mfiwOIdhtZ4biMXY9WRlkZhG9HuMZnIiB5axvSzPPYIYv5edtcDDKHSuA
         QZc1323hGGWaxm56lYIEQ/Zk9J8W+6F54by82HeZBA/fmAbRzMN+Hb/wyd3ZuXU4CXKE
         hQoQ8wKG186wDAgEk1k5bQXf6fwnTiC3AJ+l+HmpK/x3sGHDeLAA3mi455KH9ih+FPvl
         8MjFWB3Ztdw+jC2Mdsr+rdzlH2YHN9KW25ZfaZxF7EDwdWkqFuCE1/bArDot2Li42UyE
         v6g1IRSa5ID+9SDPeW6uqnDn2mWpW4K4oDb1sR3yMtlcsz0qfP+MgoPbqyzn1gFkQm+8
         J7qw==
X-Gm-Message-State: AOAM533glNw5LcfjBeq2xseUAw52oJaSFEIaqVm/MqaRcPImVS39xsos
        H07gGBShwyYaAfjNwoGeHYY=
X-Google-Smtp-Source: ABdhPJygkcnBmIDszIHhdojfZ+eMpUUaJLDB2Z8TEpuJycRkWTdxv9PNzkeRGNl95UDT0xlVuxawTQ==
X-Received: by 2002:a63:164c:: with SMTP id 12mr14709144pgw.141.1625475657922;
        Mon, 05 Jul 2021 02:00:57 -0700 (PDT)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id j16sm13570816pgh.69.2021.07.05.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:00:57 -0700 (PDT)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Mon,  5 Jul 2021 17:00:50 +0800
Message-Id: <20210705090050.15077-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

During a sequence of random 4K read operations, the performance will be
reduced due to spending much time on entering/exiting the low power state
between requests. We disable the low power state negotiation of GL9763E
during a sequence of random 4K read operations to improve the performance
and enable it again after the operations have finished.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 302a7579a9b3..5f1f332b4241 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -88,6 +88,9 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG       0x8A0
+#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
+
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
 #define   GLI_9763E_CFG2_L1DLY_MID 0x54
@@ -128,6 +131,11 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+struct gli_host {
+	bool start_4k_r;
+	int continuous_4k_r;
+};
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
+	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && (cmd->data->blocks == 8)) {
+		gli_host->continuous_4k_r++;
+
+		if ((!gli_host->start_4k_r) && (gli_host->continuous_4k_r >= 3)) {
+			gl9763e_set_low_power_negotiation(slot, false);
+
+			gli_host->start_4k_r = true;
+		}
+	} else {
+		gli_host->continuous_4k_r = 0;
+
+		if (gli_host->start_4k_r)	{
+			gl9763e_set_low_power_negotiation(slot, true);
+
+			gli_host->start_4k_r = false;
+		}
+	}
+
+	sdhci_request(mmc, mrq);
+}
+
+
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -848,6 +912,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
+
+	host->mmc_host_ops.request = gl9763e_request;
+
 	gli_set_gl9763e(slot);
 	sdhci_enable_v4_mode(host);
 
@@ -913,4 +980,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.suspend	= sdhci_cqhci_gli_suspend,
 #endif
 	.add_host       = gl9763e_add_host,
+	.priv_size      = sizeof(struct gli_host),
 };
-- 
2.27.0

