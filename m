From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH 2/3] mmc: sdhci: Add support for o2 eMMC HS200 mode and hardware tuning
Date: Thu, 28 Dec 2017 17:59:42 +0800
Message-ID: <20171228095942.3994-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:60716
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbdL1KAD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 28 Dec 2017 05:00:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com

Add register definition for eMMC HS200 mode. Add bitmask definition
for hardware tuning function.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-pci-o2micro.h
index 770f53857211..5a4671d5a511 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.h
+++ b/drivers/mmc/host/sdhci-pci-o2micro.h
@@ -49,6 +49,7 @@
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
+#define O2_SD_MISC_SETTING	0x308
 #define O2_SD_CLK_SETTING	0x328
 #define O2_SD_CAP_REG2		0x330
 #define O2_SD_CAP_REG0		0x334
@@ -62,6 +63,8 @@
 #define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
 
 #define O2_SD_VENDOR_SETTING	0x110
+#define O2_SD_HW_TUNING_ENABLE	BIT(4)
+
 #define O2_SD_VENDOR_SETTING2	0x1C8
 
 extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
-- 
2.14.1

