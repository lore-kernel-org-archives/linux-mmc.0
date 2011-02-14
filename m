From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/4] sdhci: register defs for sd 3.0 HOST CONTROL 2
Date: Sun, 13 Feb 2011 23:16:51 -0800
Message-ID: <A1CE777F-10EC-488F-9A25-877DC39B6271@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46497 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab1BNHUZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:20:25 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.h |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 2477118..f4a71fd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -145,7 +145,22 @@
 
 #define SDHCI_ACMD12_ERR	0x3C
 
-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL_2             0x3E
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
-- 
1.7.0.4


