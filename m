From: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V4 1/2] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Date: Fri, 2 Aug 2019 17:39:34 +0000
Message-ID: <1564767547-4515-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
---
change in V4:
 1. add a bug fix in V3

change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count to O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count to sdhci-pci-o2micro.c

chagne in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retuning HS200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..186a33d 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,7 +51,7 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
--=20
2.7.4
