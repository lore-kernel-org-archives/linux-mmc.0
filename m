Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B84C34050
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ACC24656
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHwOhxWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBSJ3G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:29:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgBSJ3G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2020 04:29:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so9316942plp.7;
        Wed, 19 Feb 2020 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGZFHykmacRws9g1ibYcZy4WBII6dR0ReLzZflarpww=;
        b=iHwOhxWnv23qjancjEwQgMRD415ItyxCW7wjeOb+M/owCxhLY1Lsr2zu9SRiOdx8m8
         0RMcGKXlKDSgsCzrJtjC3ARD0J8OfI23G0l+1SnnMff7PqtMHBpMnyhtS907tDE15u+x
         L2gFf5iciDXv9HUTyeFz+aHGbFO0W87NW4xORvdHoo4XtNWXgVBuUawE9ktnKp7lga8D
         H2HmN36oM4xmrYt92QuBlneU8vdF5gaXNaP2dGcMxNa5XcIzB0h1uLQGnt5kUfD5AQu3
         cOgC+0yqPHp/QcqHgTWkljjiiPSeLBo+qvDhGf/BXXrwB4F4LkRYO9jqdAVBr6pl3Vwz
         2MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGZFHykmacRws9g1ibYcZy4WBII6dR0ReLzZflarpww=;
        b=NrcojZQl3eUVD82t+OIDWXlR3tJVUN91Vgg8mbvVrwXMTn+8QnvCADLKSBz+L1NYrY
         3+PW4q4g9M5zTsVtz/NuzDSyaKZConwSTNUbTrz3v7f2XAZz4YwRioUpHB8lNHAyX3/W
         HkQyTi0ieLGfOvGiH63AuZDR2hZpFm0PxuLY0KsM1/VPOSlE6Twi5UZwjCb7fAPIwhpX
         C0ehy78Vg8wqWUhSFQWxXqGO7VAPfAfGFcCmfMQION+uvT1v/wc8k9vE+L+SUQrT9Cx+
         RzA8krS4TILhGg2GlQYD616VUmjoLL5+90UVpQ2fqfYLxlm8YPdhDMGaxo9CWhZfstKT
         XUOQ==
X-Gm-Message-State: APjAAAU6Q6sQmBT8Dkps7gYdWErmhMHzm2fQsyMXPZ8GARIbGrunZ2f6
        AikrFLoSKjpTNfA7Lk47zdU=
X-Google-Smtp-Source: APXvYqyIL5b3vMOqwMxAClKJObQUkn/YDeATGh+8ttJQtNuKpdrGcbzlgvs0JxNlcHFevts6s6yRYA==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr24884354pll.240.1582104545897;
        Wed, 19 Feb 2020 01:29:05 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id m18sm1839461pgd.39.2020.02.19.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:29:05 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x
Date:   Wed, 19 Feb 2020 17:29:00 +0800
Message-Id: <20200219092900.9151-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Enable MSI interrupt for GL9750/GL9755. Some platforms
do not support PCI INTx and devices can not work without
interrupt. Like messages below:

[    4.487132] sdhci-pci 0000:01:00.0: SDHCI controller found [17a0:9755] (rev 0)
[    4.487198] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.PBR2._PRT.APS2], AE_NOT_FOUND (20190816/psargs-330)
[    4.487397] ACPI Error: Aborting method \_SB.PCI0.PBR2._PRT due to previous error (AE_NOT_FOUND) (20190816/psparse-529)
[    4.487707] pcieport 0000:00:01.3: can't derive routing for PCI INT A
[    4.487709] sdhci-pci 0000:01:00.0: PCI INT A: no GSI

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 5eea8d70a85d..ce15a05f23d4 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -262,10 +262,26 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return 0;
 }
 
+static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		pr_warn("%s: enable PCI MSI failed, error=%d\n",
+		       mmc_hostname(slot->host->mmc), ret);
+		return;
+	}
+
+	slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
 
+	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
 
@@ -276,6 +292,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
 
+	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
 
-- 
2.25.0

