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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A5C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 03:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF55611AB
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 03:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhDODYN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 23:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhDODYK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 23:24:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE9C061574;
        Wed, 14 Apr 2021 20:23:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j7so6511428pgi.3;
        Wed, 14 Apr 2021 20:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pxhi9rtG2283Pz3XgVn14Yp9v+vQoGK61+2yLSidhSg=;
        b=ZwsIfymgJ1AfhORBtxmbDezZEHneak2bkZkALQpIB5ZCQD6FJpqDrTfgtKnTw/R3K9
         u0xy4Zb7Zlw/cvFhVUva7/9bvHXvFBSw9R2KuwEneGoBsxFO8cz64usBMFcInDjeO9o7
         aer0ks07JysLwB8ds7vy/m3Rdcy6mNWWKffwfJzi0VH9AnAtNWEsRZV2kxDSMZR5V74V
         UW1NbYYwHch25hC4VFZ5RiFhLHIJveHi6Ls2LZnCfbd0EtS5FAAG60FgZzRJ8V6Ugvga
         FwLS0NQTLYix6cQz1wje4pdvAdT7FtcCOG3q+MQx8NgNliKVpND/XCn2HyM/t1mhXnDu
         cJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pxhi9rtG2283Pz3XgVn14Yp9v+vQoGK61+2yLSidhSg=;
        b=rDYEnSZBzX290iRr59cXbJDsMjbrsnzsM1gitwSMSLbMNm9szxVLAugt3HFtivBX1A
         dV9EXEuYJmkVShEH3CifgKKT6pPpqzOAKe6iDvnJOfQFIMIZ/pWdTdmgs4ftIPz6Ohle
         Sz/qsq2EDPxFnX3zoZgwuZEGTSvbV5q8unaz53y5ml4qaCwg7j5ycrQvzTrVJfTWdbc6
         E5tqKD6wciVyL2xNC42iJw1oifavQl5KE38X+TZR8W2l6V84/jWqEJorD3ahUxiHXJcq
         SdMnfW9JSJnyBNUDDUIc3J39SewlbhzGRJdilxHcFcGYI18Fd+JAvHSKdY6EaTCTTuht
         YRHg==
X-Gm-Message-State: AOAM532d7JM6XfCNoS5xE3X1FV//mA6OMxmmSeiEvVF9b/Wx63GaEZB3
        x5zEEGbRQjGpORSIQ21qXg0=
X-Google-Smtp-Source: ABdhPJw2qvc9j4KRbMtmFetqeelnOwvSAkO6zvU2LV3luboukEt0iHJIzWx4hKaYj5P6fDwvI6H7KA==
X-Received: by 2002:a65:4d4c:: with SMTP id j12mr1499644pgt.346.1618457025606;
        Wed, 14 Apr 2021 20:23:45 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id g24sm624909pfh.164.2021.04.14.20.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:23:45 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeanHY.Chen@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL975x
Date:   Thu, 15 Apr 2021 11:26:37 +0800
Message-Id: <20210415032637.5219-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

GL975x enters ASPM L1 state after a short idle in default.
Enlarge the idle period to 7.9us for improving the R/W performance.

Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index eb1ebb67e113..592d79082f58 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -22,6 +22,10 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define SDHCI_GLI_9750_CFG2          0x848
+#define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
+#define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
+
 #define SDHCI_GLI_9750_DRIVING      0x860
 #define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
 #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
@@ -113,6 +117,10 @@
 #define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
 #define   PCI_GLI_9755_DMACLK   BIT(29)
 
+#define PCI_GLI_9755_CFG2          0x48
+#define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
+#define   GLI_9755_CFG2_L1DLY_VALUE  0x1F
+
 #define PCI_GLI_9755_PLL            0x64
 #define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
 #define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
@@ -408,6 +416,22 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static void gl9750_hw_setting(struct sdhci_host *host)
+{
+	u32 value;
+
+	gl9750_wt_on(host);
+
+	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
+	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
+	/* set ASPM L1 entry delay to 7.9us */
+	value |= FIELD_PREP(SDHCI_GLI_9750_CFG2_L1DLY,
+			    GLI_9750_CFG2_L1DLY_VALUE);
+	sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
+
+	gl9750_wt_off(host);
+}
+
 static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
 {
 	int ret;
@@ -555,6 +579,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	value &= ~PCI_GLI_9755_SCP_DIS;
 	pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
 
+	pci_read_config_dword(pdev, PCI_GLI_9755_CFG2, &value);
+	value &= ~PCI_GLI_9755_CFG2_L1DLY;
+	/* set ASPM L1 entry delay to 7.9us */
+	value |= FIELD_PREP(PCI_GLI_9755_CFG2_L1DLY,
+			    GLI_9755_CFG2_L1DLY_VALUE);
+	pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
+
 	gl9755_wt_off(pdev);
 }
 
@@ -562,6 +593,7 @@ static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
 
+	gl9750_hw_setting(host);
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
-- 
2.30.0

