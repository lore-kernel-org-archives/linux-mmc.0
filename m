From: Vincent Wan <vincent.wan@amd.com>
Subject: [PATCH] mmc: Add a quirk for AMD SD controller doesn't support HS200
Date: Tue, 4 Nov 2014 17:27:39 +0800
Message-ID: <1415093259-5076-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0143.outbound.protection.outlook.com ([65.55.169.143]:55424
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbaKDJ2G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 04:28:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>, Huang Rui <ray.huang@amd.com>, Vincent Wan <vincent.wan@amd.com>

AMD SD controller support the SDR104 mode, but caps2 can not
be promoted to support hs200 for eMMC.

Signed-off-by: Vincent Wan <vincent.wan@amd.com>
---
 drivers/mmc/host/sdhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f5c998..6b4e84c 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -652,8 +652,10 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
 			PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
 
-	if (smbus_dev && (smbus_dev->revision < 0x51))
+	if (smbus_dev && (smbus_dev->revision < 0x51)) {
 		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
+		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+	}
 
 	return 0;
 }
-- 
1.8.1.2

