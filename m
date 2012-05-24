From: Viswanath Puttagunta <vishp@ti.com>
Subject: [PATCH 3/3] mfd: Enable Debounce logic for SD hotplug detection
Date: Thu, 24 May 2012 15:14:27 -0500
Message-ID: <1337890467-32573-4-git-send-email-vishp@ti.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758006Ab2EXUOc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 May 2012 16:14:32 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4OKEVHQ020497
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4OKEVZ7010808
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
In-Reply-To: <1337890467-32573-1-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux-mmc <linux-mmc@vger.kernel.org>
Cc: T Krishnamoorthy Balaji <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>, Viswanath Puttagunta <vishp@ti.com>

Enable debounce logic in TWL6030 so that erroneous
disconnect/connect interrupts will be suppressed.

This will fix issue where SD card is either plugged
or unplugged very slowly.

Change-Id: Icc3afa4c66b3bc7920f27ff9c9a3f32e67d5833c
Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
---
 drivers/mfd/twl6030-irq.c |    8 ++++++++
 include/linux/i2c/twl.h   |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index b76902f..05bb6e1 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -317,6 +317,14 @@ int twl6030_mmc_card_detect_config(void)
 									ret);
 		return ret;
 	}
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
+				(MMC_MINS_DEB_MASK | MMC_MEXT_DEB_MASK),
+				TWL6030_MMCDEBOUNCING);
+	if (ret < 0) {
+		pr_err("twl6030: Failed to write MMC_MEXT_DEB_MASK %d\n",
+								ret);
+		return ret;
+	}
 
 	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
 }
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 1f90de0..672dcfb 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -147,6 +147,11 @@
 #define SW_FC				(0x1 << 2)
 #define STS_MMC			0x1
 
+#define TWL6030_MMCDEBOUNCING		0xED
+#define MMC_DEB_BYPASS			(0x1 << 7)
+#define MMC_MINS_DEB_MASK		(0xF << 3)
+#define MMC_MEXT_DEB_MASK		(0x7 << 0)
+
 #define TWL6030_CFG_INPUT_PUPD3	0xF2
 #define MMC_PU				(0x1 << 3)
 #define MMC_PD				(0x1 << 2)
-- 
1.7.4.1

