From: Roger Tseng <rogerable@realtek.com>
Subject: [PATCH 2/3] mfd: rtsx: implement driving adjustment to device-dependent callbacks
Date: Mon, 4 Feb 2013 15:45:58 +0800
Message-ID: <1359963959-2305-3-git-send-email-rogerable@realtek.com>
References: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, wei_wang@realsil.com.cn, Roger Tseng <rogerable@realtek.com>
List-Id: linux-mmc@vger.kernel.org

Implement different ways of selecting driving capability(a necessary adjustment
along with voltage change). It was origionally in device-independent
mmc/host/rtsx_pci_sdmmc.c. Moving it here to support devices which may have a
different way of adjustment.

Signed-off-by: Roger Tseng <rogerable@realtek.com>
Reviewed-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mfd/rtl8411.c | 16 +++++++++++++---
 drivers/mfd/rts5209.c |  8 ++++++++
 drivers/mfd/rts5229.c |  8 ++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rtl8411.c b/drivers/mfd/rtl8411.c
index 3d3b4ad..2a2d316 100644
--- a/drivers/mfd/rtl8411.c
+++ b/drivers/mfd/rtl8411.c
@@ -115,14 +115,24 @@ static int rtl8411_card_power_off(struct rtsx_pcr *pcr, int card)
 static int rtl8411_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 {
 	u8 mask, val;
+	int err;
 
 	mask = (BPP_REG_TUNED18 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_MASK;
-	if (voltage == OUTPUT_3V3)
+	if (voltage == OUTPUT_3V3) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_D);
+		if (err < 0)
+			return err;
 		val = (BPP_ASIC_3V3 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_3V3;
-	else if (voltage == OUTPUT_1V8)
+	} else if (voltage == OUTPUT_1V8) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_B);
+		if (err < 0)
+			return err;
 		val = (BPP_ASIC_1V8 << BPP_TUNED18_SHIFT_8411) | BPP_PAD_1V8;
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	return rtsx_pci_write_register(pcr, LDO_CTL, mask, val);
 }
diff --git a/drivers/mfd/rts5209.c b/drivers/mfd/rts5209.c
index 98fe0f3..ec78d9f 100644
--- a/drivers/mfd/rts5209.c
+++ b/drivers/mfd/rts5209.c
@@ -149,10 +149,18 @@ static int rts5209_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 	int err;
 
 	if (voltage == OUTPUT_3V3) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_D);
+		if (err < 0)
+			return err;
 		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x4FC0 | 0x24);
 		if (err < 0)
 			return err;
 	} else if (voltage == OUTPUT_1V8) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_B);
+		if (err < 0)
+			return err;
 		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x4C40 | 0x24);
 		if (err < 0)
 			return err;
diff --git a/drivers/mfd/rts5229.c b/drivers/mfd/rts5229.c
index 29d889c..58af4db 100644
--- a/drivers/mfd/rts5229.c
+++ b/drivers/mfd/rts5229.c
@@ -119,10 +119,18 @@ static int rts5229_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 	int err;
 
 	if (voltage == OUTPUT_3V3) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_D);
+		if (err < 0)
+			return err;
 		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x4FC0 | 0x24);
 		if (err < 0)
 			return err;
 	} else if (voltage == OUTPUT_1V8) {
+		err = rtsx_pci_write_register(pcr,
+				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_B);
+		if (err < 0)
+			return err;
 		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x4C40 | 0x24);
 		if (err < 0)
 			return err;
-- 
1.7.12.1
