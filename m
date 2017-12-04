From: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>
Subject: [PATCH 2/3] mmc: sdhci-pci-o2micro: Add eMMC HS200 support
Date: Mon, 4 Dec 2017 10:10:10 +0000
Message-ID: <CY4PR04MB047374AC40568EF03031F49CED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:51904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752922AbdLDKKN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 05:10:13 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>

Dear all,

Add register definition for eMMC HS200 mode.
Add hardware tuning for eMMC HS200 mode.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-=
pci-o2micro.h
index 770f53857211..3fb957729315 100644
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
=20
 #define O2_SD_VENDOR_SETTING	0x110
+#define O2_SD_HW_TUNING_ENABLE BIT(4)
+
 #define O2_SD_VENDOR_SETTING2	0x1C8
=20
 extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
--=20
2.14.1
