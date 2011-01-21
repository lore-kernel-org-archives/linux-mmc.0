From: Philip Rakity <prakity@marvell.com>
Subject: Subject: [PATCH 1/3] sdhci: register defs for sd 3.0 HOST CONTROL 2
Date: Thu, 20 Jan 2011 20:28:20 -0800
Message-ID: <815F7E0F-C8B0-4362-8DAD-0EB667EB7BBA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54348 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753656Ab1AUEdD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jan 2011 23:33:03 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Mark Brown <markb@marvell.com>

Resend

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.h |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..36f3861 100644
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


