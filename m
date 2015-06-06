From: Wan ZongShun <Vincent.Wan@amd.com>
Subject: [PATCH 1/3] pci_ids: Add AMD KERNCZ device ID support
Date: Sat, 6 Jun 2015 21:13:38 +0800
Message-ID: <1433596420-5612-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0112.outbound.protection.outlook.com ([207.46.100.112]:40736
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752737AbbFFN30 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 6 Jun 2015 09:29:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, jdelvare@suse.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Wan ZongShun <Vincent.Wan@amd.com>, Wan ZongShun <mcuos.com@gmail.com>

The KERNCZ is new AMD SB/FCH generation name, like HUDSON2.
We will adopt 0x790b as device ID since from this gereration.

Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2f7b9a4..cb63a7b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
+#define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
1.9.1

