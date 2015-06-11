From: Wan ZongShun <Vincent.Wan@amd.com>
Subject: [PATCH V2 2/3] i2c-piix4: Use Macro for AMD CZ SMBus device ID
Date: Thu, 11 Jun 2015 20:11:46 +0800
Message-ID: <1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0141.outbound.protection.outlook.com ([207.46.100.141]:25728
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753160AbbFKMKt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Jun 2015 08:10:49 -0400
In-Reply-To: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, jdelvare@suse.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mcuos.com@gmail.com, Wan ZongShun <Vincent.Wan@amd.com>

Change AMD CZ SMBUS device ID from 0x790b to
use Macro definition

Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
---
 drivers/i2c/busses/i2c-piix4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 67cbec6..630bce6 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -245,7 +245,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
 	     PIIX4_dev->revision >= 0x41) ||
 	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
-	     PIIX4_dev->device == 0x790b &&
+	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	     PIIX4_dev->revision >= 0x49))
 		smb_en = 0x00;
 	else
@@ -545,7 +545,7 @@ static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x790b) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
-- 
1.9.1

