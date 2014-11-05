From: Vincent Wan <vincent.wan@amd.com>
Subject: [PATCH v3 3/3] mmc:sdhci-pci: enable sdhci doesn't support hs200 quirk for AMD sdhci
Date: Wed, 5 Nov 2014 14:09:28 +0800
Message-ID: <1415167768-5839-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0131.outbound.protection.outlook.com ([157.56.111.131]:28919
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751369AbaKEGJ6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Nov 2014 01:09:58 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <mcuos.com@gmail.com>, Vincent Wan <vincent.wan@amd.com>

AMD SD controller supports the SDR104 mode, but caps2 can not
be promoted to support hs200 for eMMC.

Signed-off-by: Vincent Wan <vincent.wan@amd.com>
Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 5a77f18..c1ecd20 100644
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

