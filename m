From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [PATCH 1/2] pci_id: add Intel Merrifield mmc pci id
Date: Tue,  1 Oct 2013 13:00:32 -0700
Message-ID: <1380657633-19543-1-git-send-email-david.a.cohen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, bhelgaas@google.com, adrian.hunter@intel.com, wfp5p@virginia.edu, gregkh@linuxfoundation.org, g.liakhovetski@gmx.de
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 97fbecd..2a89103 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2551,6 +2551,7 @@
 #define PCI_DEVICE_ID_INTEL_MFD_EMMC0	0x0823
 #define PCI_DEVICE_ID_INTEL_MFD_EMMC1	0x0824
 #define PCI_DEVICE_ID_INTEL_MRST_SD2	0x084F
+#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_CENTERTON_ILB	0x0c60
-- 
1.8.4.rc3
