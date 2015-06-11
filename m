From: Wan ZongShun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 1/3] pci_ids: Add AMD KERNCZ device ID support
Date: Thu, 11 Jun 2015 20:11:45 +0800
Message-ID: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Wan ZongShun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The KERNCZ is new AMD SB/FCH generation name, like HUDSON2.
We will adopt 0x790b as device ID since from this gereration.

Signed-off-by: Wan ZongShun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
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
