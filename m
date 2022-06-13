Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D9C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiFMJ3O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiFMJ3L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 05:29:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB318399
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 02:29:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso8270728pjl.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7Ew5S6rYNqDMYPYBCW42etEGk6gWTnH0c0DcUn+LJg=;
        b=YyoLhVzuMRhkX/aDN7qdLxl8I1AQpfljJgnV/EyWZ2G/D9WPlAI21ICRrph1zDB+cI
         cLShGnoRLFKMmf7ZeSTJJYegJjlbx9QKkxPeRietclz1flaGyXZ5uPUDZUg1KCtERahQ
         fuH3ILxWMHSjl2k6k57MB7LOefJ52h58JhBO8RwX/s+kpM3kTOej73p4U1aurflo5HGP
         Tu3qKFQzdIbl1Iaaxi+X3zPIRnPHJcHwaNHYmlAU0NlTVFt4kDDyRs6UXBj9tehJVMde
         pTW3VY6EcRIxwMRI0db4s9xOl5pA6P7A9+zAuPntxTuqpw/lvQUMfliVjMol/myLgQey
         F31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7Ew5S6rYNqDMYPYBCW42etEGk6gWTnH0c0DcUn+LJg=;
        b=g3DwNZGazF5qGh/pPbyV8c/TIGdU6GsqCCrGJHR5tU1al6cgVjSAK6q40Nu/NIp+Xc
         AySYUwtr+qV+/KtRTugeBxqHfnjqKgSGFAIHALdqNKRsjG/0qRMf3wEfS2il6QPLrF4J
         Us+CGFuJPeTaFcCX7UC4vieY0OJIET6okt1M5vdfkccMtSP0EgdAvEDg+QnKzlzROgR7
         Rj9TxvxnH7fPeR7vmwfCtV8Ml+0jslzhzyavBnN2qYN79IZs6k091HT+JXAxmFLlsz2H
         oH2Rk2R+qFkk1+Q8RgjODim3uwRg6B79poFSrDb0e2Ip7aD1s6J15CUYZMoEu4CxPlBD
         ycQA==
X-Gm-Message-State: AOAM533KXhaCAqD2bD3UCZgNGSnv+2UdaHJkofzi5+eBy7jEnOi/H1Um
        EFpgC9RTuaxIUNSen+UCQu4=
X-Google-Smtp-Source: ABdhPJxBO+qz6eKlGQcVCtuqAcOPci68nHnkiN1sT/FlhaZJY3sc2gYM25SiamXFsBF6anFGDWb+/w==
X-Received: by 2002:a17:90a:4291:b0:1e2:92f3:20d1 with SMTP id p17-20020a17090a429100b001e292f320d1mr14685247pjg.163.1655112549812;
        Mon, 13 Jun 2022 02:29:09 -0700 (PDT)
Received: from PC21-33.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id p8-20020aa79e88000000b0050dc762818csm4845635pfq.102.2022.06.13.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:29:09 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
X-Google-Original-From: Jason Lai <jason.lai@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH V2] mmc: host: Improve READ/WRITE Performance of GL9763E
Date:   Mon, 13 Jun 2022 17:29:07 +0800
Message-Id: <20220613092907.2502-1-jason.lai@genesyslogic.com.tw>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jasonlai.genesyslogic@gmail.com>

To improve READ/WRITE performance and take battery life into account, we
turn on GL9763E L1 negotiation before entering runtime suspend and turn
off GL9763E L1 negotiation while executing runtime resume. That is to say,
GL9763E will not enter L1 state when executing I/O requests and enter L1
state when PCIe bus idle.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---

This patch is the follow-up to the patch [1] and adopt Ulf's comment.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter
and exit L1 state during I/O requests.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=646869

---
 drivers/mmc/host/sdhci-pci-gli.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..69bc3d614e15 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -95,6 +95,9 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG       0x8A0
+#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
+
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
 #define   GLI_9763E_CFG2_L1DLY_MID 0x54
@@ -818,6 +821,31 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -959,6 +987,9 @@ static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
+	/* Enable LPM negotiation to allow entering L1 state */
+	gl9763e_set_low_power_negotiation(slot, true);
+
 	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
@@ -989,6 +1020,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	clock |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
 
+	/* Disable LPM negotiation to avoid entering L1 state. */
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	return 0;
 }
 #endif
-- 
2.36.1

