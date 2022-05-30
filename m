Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45AFC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 30 May 2022 08:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiE3IrO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 May 2022 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiE3IrN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2022 04:47:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC225C46
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 01:47:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y199so10007496pfb.9
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzd+KkHLNZDyPHzHqIoBJsbUm/fcdDPTocfJsfo8woI=;
        b=mm3RVKuuTFvZ/z7ATjYTOqpYAmZt4snjjLiRboYCgNWZDqBaAPCqiJb8joTGR2iVM2
         CU64AHARfFDu+VoCjQLfiqPQbhn7Zm1GhpJvBaHRgEmes8g8G573dH/Bb/6va43Cso+3
         SfCzq9Cm2Zu/85umuz3krplmTqum2QaGb1v+Y6xoO7IoSaR+nn79zkVIvO67XuDlSdd0
         ZwA+MsbxJ72Cm4O3bLnDbCX4lMtOktJb9s27Mo0t8z3AoFWb/WElklvL1soBKItwDK96
         RBOi9VBuJZg8HnvkHQTvJRCGqAK6lEqdIPbGJFW4frUs+FWwyKcoMDDLPJIMGcjY+ai4
         6Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzd+KkHLNZDyPHzHqIoBJsbUm/fcdDPTocfJsfo8woI=;
        b=YVGmyI6fZaYP1JNBuyeOpCKKVSvYHJ21wVN43CDCKMgueJrY0c9J57p3tB8JSBYqHU
         eklUFTRScO0YLuuzqfiUh4LmzaTCFSC9u9lqL8UeKDw4qw0WNyUCdRC0b4dLJhXxl1h4
         ww84bNMGJUm8AO8LW+SP/IMycxSNSLnNSMMtpxSCcG1cE08s3B4TwEplAAi03gC0VDim
         rfF0DpwPRyc8QxgWfxwSxxYgqdGWPzBfV8gAcqkkKGrceOxBmePuGoQHtFYGyEwsO998
         l4RQQbcGGl2Ze/yEngEwUvR/3CkXaxatTsu86zjlV5POMxXQDTABO0DE18IKD02XbGR3
         F8Eg==
X-Gm-Message-State: AOAM531rHO8zl04NlbCeiK6hmqeJCGRmYVJE3MGuH1MboSjwDhh7md4o
        ewn5jai6KbUjeZNdQw/oIYWGhu2Wv7A=
X-Google-Smtp-Source: ABdhPJyJRD7sx7+YXdxWVZiWH13ozP1g8VTjfvd9Hc3BTkhT+brPVqIABzFJIPf03bTrEKB+pAde1g==
X-Received: by 2002:a63:4387:0:b0:3c6:9490:4e4b with SMTP id q129-20020a634387000000b003c694904e4bmr47137773pga.438.1653900432273;
        Mon, 30 May 2022 01:47:12 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b00162037fbacdsm8490909pln.187.2022.05.30.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:47:11 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [V2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Mon, 30 May 2022 16:47:02 +0800
Message-Id: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is based on patch [1] and adopt Adrian's comment.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter
and exit L1 state.

Unfortunately, entering and exiting L1 state is signal handshake in
physical layer, software knows nothiong about it. The only way to stop
entering L1 state is to disable hardware LPM negotiation on GL9763E.

To improve read performance and take battery life into account, we reject
L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable
L1 negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=645165

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 86200b73c0b0..13c09202da9c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -850,24 +850,29 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
+static void gl9763e_set_lpm_negotiation(struct sdhci_pci_slot *slot, bool enable)
+{
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
+
+	if (gli_host->lpm_negotiation_enabled == enable)
+		return;
+
+	gli_host->lpm_negotiation_enabled = enable;
+
+	gl9763e_set_low_power_negotiation(slot, enable);
+}
+
 static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct mmc_command *cmd;
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
-	struct gli_host *gli_host = sdhci_pci_priv(slot);
 
 	cmd = mrq->cmd;
-
-	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
-		gl9763e_set_low_power_negotiation(slot, false);
-		gli_host->lpm_negotiation_enabled = false;
-	} else {
-		if (gli_host->lpm_negotiation_enabled == false) {
-			gl9763e_set_low_power_negotiation(slot, true);
-			gli_host->lpm_negotiation_enabled = true;
-		}
-	}
+	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK))
+		gl9763e_set_lpm_negotiation(slot, false);
+	else
+		gl9763e_set_lpm_negotiation(slot, true);
 
 	sdhci_request(mmc, mrq);
 }
@@ -975,6 +980,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
@@ -995,6 +1001,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
+	/* Default setting of LPM negotiation is enabled. */
+	gli_host->lpm_negotiation_enabled = true;
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
 	value &= ~GLI_9763E_HS400_RXDLY;
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
-- 
2.36.1

