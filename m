From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V4  3/4] mmc: add support for H/W clock gating of SD
 controller
Date: Wed, 8 Dec 2010 16:18:28 -0800
Message-ID: <A5CE2481-538A-4691-9753-215E27AF9FC1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40432 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753905Ab0LIASc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Dec 2010 19:18:32 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

Define Register values for host controller 2.  All register values defined
but  SDCTRL_2_ASYNC_INT_EN is used in patch 4/4

>From 1bfe8b89642cecc8fa5e22f135e4a92f7f3b83ff Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 8 Dec 2010 15:20:19 -0800
Subject: [PATCH] sdhci: added register defintions for sd host 3.0 HOST CONTROL 2

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.h |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 26a8c09..d8526ae 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -144,7 +144,22 @@
 
 #define SDHCI_ACMD12_ERR	0x3C
 
-/* 3E-3F reserved */
+#define HOST_CTRL_2             0x3E
+#define SDCTRL_2_UHS_MODE_SEL_SDR12		0x0000
+#define SDCTRL_2_UHS_MODE_SEL_SDR25		0x0001
+#define SDCTRL_2_UHS_MODE_SEL_SDR50		0x0002
+#define SDCTRL_2_UHS_MODE_SEL_SDR104		0x0003
+#define SDCTRL_2_UHS_MODE_SEL_DDR50		0x0004
+#define SDCTRL_2_UHS_MODE_MASK			7
+#define SDCTRL_2_SDH_V18_EN			0x0008
+#define SDCTRL_2_DRV_STRENGTH_SEL_B		0x0000
+#define SDCTRL_2_DRV_STRENGTH_SEL_A		0x0010
+#define SDCTRL_2_DRV_STRENGTH_SEL_C		0x0020
+#define SDCTRL_2_DRV_STRENGTH_SEL_D		0x0030
+#define SDCTRL_2_EXE_TUNING			0x0040
+#define SDCTRL_2_SAMPLING_CLK_SEL		0x0080
+#define SDCTRL_2_ASYNC_INT_EN			0x4000
+#define SDCTRL_2_PRESET_VAL_EN			0x8000
 
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -164,6 +179,7 @@
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 
-- 
1.6.0.4

