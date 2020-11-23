Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF2BC63777
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 05:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5171A2068D
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 05:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzozNj1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKWFiI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 00:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWFiI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 00:38:08 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A01C0613CF;
        Sun, 22 Nov 2020 21:38:08 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l11so8306636plt.1;
        Sun, 22 Nov 2020 21:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivjo757clFR0whhjs5PVIdMjPczKMK3WkRUo0lKbdS4=;
        b=MzozNj1dAFjS9Qd6hVbs8TxJqyEiFgHZLs14qdaHPqXelOCKkgFrsVu1xCFct5gpaN
         +BbyI5aso85O8MRiXxHdAmeCnP4GZT03jxn+x12Za9fAsdXF46n2fJw1hNA5E1aQSBv2
         TULpMejAlXHrJ982DRpIwnt0rPJSd7pq7TSMPgAdk8tZccmVzbc7JpVkJR0pWdKfTLbD
         8gFQQYw1w4MZOCs8WjGol8FAO9M50s8uosrlFiKFcmT0ARxj/A4Wnds3h+zjviHCzaAU
         iWZuYPkpU/zPCjPSQFQeAUJifNIuQ0z30q5rnxub95ud0Vdtr/LIS0UKG71w3PkRx16F
         WSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivjo757clFR0whhjs5PVIdMjPczKMK3WkRUo0lKbdS4=;
        b=rfArAjL9NoPTU1u8pj9fMk80gTF4iWcOky8ix9vJGzfaPWIAhuelwIpcLHmt5io1Pc
         gGktFYFku50eQ8l1f/feeXHUh8HVOpsKI7ylZvpwBfD4xQZYewv49NJLiSNdLlPcO7ja
         3Pq4zAYZTCmahj7kSYLZrof898GBo9KMwc/S8vS+7SiB83VcOt2TcS+9iS6jD2oNz9Qz
         SibE3yAyF5Vu8YgJ2IB+DoVrHBJXNgduguSXaeLp2b1k5VZfZ9MvaUvwT2mDs6FOjviQ
         6yNcntSMIFhTRrplUyiejSq3BsXv8xW/qo6rnHBeue23oBYM0Wnjyc0lQl9uhm2enS3x
         7ChA==
X-Gm-Message-State: AOAM532hAKDNjnizxTRlim7W52CNBrxuoJ0pRFY2VG/tZpIBpLl4A4IJ
        dIngznff8znP90FuH6i/22s=
X-Google-Smtp-Source: ABdhPJy72LJpOT6zvATmsXzDOENjyQzOdXuHwjRp6lWaUaW2H+DFQNwiotnI9yn0NG1TUrt+W306hQ==
X-Received: by 2002:a17:902:ec03:b029:d7:c7c2:145a with SMTP id l3-20020a170902ec03b02900d7c7c2145amr23476385pld.33.1606109887904;
        Sun, 22 Nov 2020 21:38:07 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id m9sm10441472pfh.94.2020.11.22.21.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 21:38:07 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Reduce power consumption for GL9755
Date:   Mon, 23 Nov 2020 13:37:02 +0800
Message-Id: <20201123053702.6083-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

For GL9755, reduce power consumption by lowering the LFCLK and disabling
the DMACLK on low-power.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 9887485a4134..f10bdfbfce36 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -97,6 +97,10 @@
 #define   GLI_9755_WT_EN_ON     0x1
 #define   GLI_9755_WT_EN_OFF    0x0
 
+#define PCI_GLI_9755_PECONF   0x44
+#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
+#define   PCI_GLI_9755_DMACLK   BIT(29)
+
 #define PCI_GLI_9755_PLL            0x64
 #define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
 #define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
@@ -519,6 +523,21 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9755_wt_on(pdev);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
+	value &= ~PCI_GLI_9755_LFCLK;
+	value &= ~PCI_GLI_9755_DMACLK;
+	pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
+
+	gl9755_wt_off(pdev);
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -534,6 +553,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
 
+	gl9755_hw_setting(slot);
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
-- 
2.29.2

