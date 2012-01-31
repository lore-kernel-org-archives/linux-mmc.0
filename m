From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
Date: Tue, 31 Jan 2012 23:26:10 +0530
Message-ID: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

This patchset removes all uses of 'clk_type' member from the platform data
of sdhci-s3c driver and adds device tree support for sdhci-s3c driver.

In this patchset, all uses of 'clk_type' member from the platform data are
removed from the sdhci-s3c driver and platform code. The clk_type is a SoC
specific information and not a board/machine specific information. Hence, this
information can be more aptly represented using SoC specific driver data in the
sdhci-s3c driver.

Hence all uses of 'clk_type' member in sdhci-s3c driver's platform data is
removed. In place of that, the sdhci host qurik 'SDHCI_QUIRK_NONSTANDARD_CLOCK'
is used to handle controllers that do not have a standard sdclk division
(like those in the exynos4 SoC's).

This is a pre-requisite for adding device tree support for sdhci-s3c driver.
While migrating towards device tree support, retreving 'clk_type' information
from device tree information does not seem correct and hence it has been added
as SoC specific driver data. All this is handled in patches 1 to 3.

Patch 4 to 6 add device tree support for sdhci-s3c driver. The fourth patch
derives the maximum transfer width host capability from the max_width member
in platform data. The fifth patch modifies the sdhci-s3c driver to mainatain
a local copy of the platform data, which makes it easier to add device tree
support for the driver. The last patch adds device tree based discovery for
the sdhci-s3c driver.

This patchset is based on the following tree.
  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]

Thomas Abraham (6):
  mmc: sdhci-s3c: Remove usage of clk_type member in platform data
  arm: exynos4: use 'exynos4-sdhci' as device name for sdhci controllers
  arm: samsung: remove all uses of clk_type member in sdhci platform data
  mmc: sdhci-s3c: derive transfer width host capability from max_width in platform data
  mmc: sdhci-s3c: Keep a copy of platform data and use it
  mmc: sdhci-s3c: Add device tree support

 .../devicetree/bindings/mmc/samsung-sdhci.txt      |   70 ++++++
 arch/arm/mach-exynos/clock.c                       |   24 +-
 arch/arm/mach-exynos/common.c                      |    5 +
 arch/arm/mach-exynos/mach-armlex4210.c             |    3 -
 arch/arm/mach-exynos/mach-nuri.c                   |    3 -
 arch/arm/mach-exynos/mach-origen.c                 |    2 -
 arch/arm/mach-exynos/mach-smdk4x12.c               |    2 -
 arch/arm/mach-exynos/mach-smdkv310.c               |    4 -
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 -
 arch/arm/plat-samsung/devs.c                       |    4 -
 arch/arm/plat-samsung/include/plat/sdhci.h         |   35 +++-
 arch/arm/plat-samsung/platformdata.c               |    2 -
 drivers/mmc/host/sdhci-s3c.c                       |  235 +++++++++++++++++++-
 13 files changed, 341 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
