From: Adam Lee <adam.lee@canonical.com>
Subject: [PATCH] mmc: sdhci-pci: set the clear transfer mode register quirk for O2Micro
Date: Mon,  3 Aug 2015 14:33:28 +0800
Message-ID: <1438583608-17777-1-git-send-email-adam.lee@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33319 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbHCGdt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2015 02:33:49 -0400
Received: by pdbnt7 with SMTP id nt7so69845214pdb.0
        for <linux-mmc@vger.kernel.org>; Sun, 02 Aug 2015 23:33:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Peter Guo <peter.guo@bayhubtech.com>

This patch fixes MMC not working issue on O2Micro/BayHub Host, which
requires transfer mode register to be cleared when sending no DMA
command.

Signed-off-by: Peter Guo <peter.guo@bayhubtech.com>
Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/mmc/host/sdhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 94f54d2..b3b0a3e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -618,6 +618,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 static const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe = sdhci_pci_o2_probe,
 	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
 	.probe_slot = sdhci_pci_o2_probe_slot,
 	.resume = sdhci_pci_o2_resume,
 };
-- 
2.5.0

