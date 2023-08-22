Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AABEE49AF
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Aug 2023 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHVWpy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Aug 2023 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjHVWpx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2023 18:45:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E9CF1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2023 15:45:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-649921ec030so28717386d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2023 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692744351; x=1693349151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IA+F9ijfpdDdMdFFKNzTJ+HhXSTDp2+LPFf3LSuVukc=;
        b=MZmfQU/jF6hti+j8QBpEKlF4/1F4b+iSStWbr2ZoCz6SSGNdQeD68dNaIX1JnISuVz
         5VSa57ZNlt+IZelO4/UCkawz9J0W/USJEp3jhiBT+V8buguwF54PJX1LJR+EmS8kjrOI
         PWbRwknIVX3y+aZFGygj/fXwc3KV0wUJvEQBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692744351; x=1693349151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA+F9ijfpdDdMdFFKNzTJ+HhXSTDp2+LPFf3LSuVukc=;
        b=eNcxxtUo0YGrfAXnhGrinT+e5rP+Q+DzEAD0M47msLGdcv4d5TRrWOPEx31NsQw5fn
         7vNd4gmQNnB1//nJnsHnwQF7mFnqfQpQgRFSDOpUBHwTbHW+bKuMJcMU5AivVwIRC+CY
         2/rNxXJsA1w34tH0IP95WoKAobZ6W8+IIECbAZUy6aG5Njo4CIdAmHBkG8OylwZNcjE4
         tIC21fCbqvoUsuh/sYu0C+dXSmf0baA49lAGm8iauLgI8a2xBrX61nK+XTIxwIzShe9/
         vgpOjIbC0GvreKlLfbblnhfihlOjGmSox8bDXCOTv8RvW/SGjKtQCBYnXZq9FNrIO5n3
         gJxA==
X-Gm-Message-State: AOJu0Yzp41nH8SHthAl1OrZo9MtiM8uGYUr/u4xMUw1aBXp1pVPh0edz
        A2fxmPM3nBc6h9EKxFRzSBRPmg==
X-Google-Smtp-Source: AGHT+IHjE45w2hhTJuEBWNipjgPO63SVpzysUBrY5TQ77WJroBOdxkSOhmVHywFsmr+Xq8LpQcQ5WA==
X-Received: by 2002:a0c:dc12:0:b0:64b:fdf0:48a3 with SMTP id s18-20020a0cdc12000000b0064bfdf048a3mr11731188qvk.10.1692744350854;
        Tue, 22 Aug 2023 15:45:50 -0700 (PDT)
Received: from trappist.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a109000b0076ceb5eb309sm3532667qkk.74.2023.08.22.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 15:45:50 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     SeanHY.chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, greg.tu@genesyslogic.com.tw,
        linux-mmc@vger.kernel.org, Renius Chen <reniuschengl@gmail.com>,
        ben.chuang@genesyslogic.com.tw, skardach@google.com,
        victor.shih@genesyslogic.com.tw, stable@vger.kernel.org,
        Sven van Ashbrook <svenva@chromium.org>
Subject: [PATCH v1] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Tue, 22 Aug 2023 22:45:37 +0000
Message-ID: <20230822224536.v1.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To improve the r/w performance of GL9763E, the current driver inhibits LPM
negotiation while the device is active.

This prevents a large number of SoCs from suspending, notably x86 systems
which use S0ix as the suspend mechanism:
1. Userspace initiates s2idle suspend (e.g. via writing to
   /sys/power/state)
2. This switches the runtime_pm device state to active, which disables
   LPM negotiation, then calls the "regular" suspend callback
3. With LPM negotiation disabled, the bus cannot enter low-power state
4. On a large number of SoCs, if the bus not in a low-power state, S0ix
   cannot be entered, which in turn prevents the SoC from entering
   suspend.

Fix by re-enabling LPM negotiation in the device's suspend callback.

Suggested-by: Stanislaw Kardach <skardach@google.com>
Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

 drivers/mmc/host/sdhci-pci-gli.c | 96 +++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 1792665c9494a..bc148276cc001 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 	return value;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-
-	pci_free_irq_vectors(slot->chip->pdev);
-	gli_pcie_enable_msi(slot);
-
-	return sdhci_pci_resume_host(chip);
-}
-
-static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = sdhci_pci_gli_resume(chip);
-	if (ret)
-		return ret;
-
-	return cqhci_resume(slot->host->mmc);
-}
-
-static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = cqhci_suspend(slot->host->mmc);
-	if (ret)
-		return ret;
-
-	return sdhci_suspend_host(slot->host);
-}
-#endif
-
 static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -1029,6 +993,62 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+
+	pci_free_irq_vectors(slot->chip->pdev);
+	gli_pcie_enable_msi(slot);
+
+	return sdhci_pci_resume_host(chip);
+}
+
+static int gl9763e_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	ret = cqhci_resume(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	/* Disable LPM negotiation to bring device back in sync
+	 * with its runtime_pm state.
+	 */
+	gl9763e_set_low_power_negotiation(slot, false);
+
+	return 0;
+}
+
+static int gl9763e_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = cqhci_suspend(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	ret = sdhci_suspend_host(slot->host);
+	if (ret)
+		return ret;
+
+	/* Certain SoCs can suspend only with the bus in low-
+	 * power state, notably x86 SoCs when using S0ix.
+	 * Re-enable LPM negotiation to allow entering L1 state
+	 * and entering system suspend.
+	 */
+	gl9763e_set_low_power_negotiation(slot, true);
+
+	return 0;
+}
+#endif
+
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1113,8 +1133,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.probe_slot	= gli_probe_slot_gl9763e,
 	.ops            = &sdhci_gl9763e_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume		= sdhci_cqhci_gli_resume,
-	.suspend	= sdhci_cqhci_gli_suspend,
+	.resume		= gl9763e_resume,
+	.suspend	= gl9763e_suspend,
 #endif
 #ifdef CONFIG_PM
 	.runtime_suspend = gl9763e_runtime_suspend,
-- 
2.42.0.rc1.204.g551eb34607-goog

