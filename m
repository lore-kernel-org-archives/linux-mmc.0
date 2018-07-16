From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
Date: Mon, 16 Jul 2018 14:26:52 +0800
Message-ID: <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com, chevron.li@bayhubtech.com, shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

O2 SD Host HS200 mode clock frequency current is 208MHz, should be changed
to 200MHz to meet specification.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Change in V7:
	Change HS200 mode clock frequency from 208MHz to 200MHz to meet
	Specification.

Change in V1~V6:
	N/A
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ba59db6a126c..94cf3cd75dd3 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -311,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 
 			/* Check Whether subId is 0x11 or 0x12 */
 			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
-				scratch_32 = 0x2c280000;
+				scratch_32 = 0x25100000;
 
 				/* Set Base Clock to 208MZ */
 				o2_pci_set_baseclk(chip, scratch_32);
@@ -406,7 +406,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 					       O2_SD_PLL_SETTING, scratch_32);
 		} else {
 			scratch_32 &= 0x0000FFFF;
-			scratch_32 |= 0x2c280000;
+			scratch_32 |= 0x25100000;
 
 			pci_write_config_dword(chip->pdev,
 					       O2_SD_PLL_SETTING, scratch_32);
-- 
2.17.1
