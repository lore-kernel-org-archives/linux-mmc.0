From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 0/6] mmc: sdhci-s3c: Rework platform data and add device tree
	support.
Date: Thu, 03 Nov 2011 02:05:57 +0530
Message-ID: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, ben-linux@fluff.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patchset removes all uses of 'clk_type' member from the platform data
of sdhci-s3c driver and adds device tree support for sdhci-s3c driver. This
patchset has merged the following two patchsets submitted earlier into one
patchset.

[PATCH 0/3] mmc: sdhci-s3c: Remove 'clk_type' member from platform data
[PATCH 0/3] mmc: sdhci-s3c: Add device tree support for Samsung's sdhci controller driver

This patchset is rebased over the patches for sdhci clock lookup using
generic names.

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
modifies the sdhci-s3c driver to mainatain a local copy of the platform data,
which makes it easier to add device tree support for the driver.

Fifth patch adds support for parsing of mmc host controller capabilities from a
device node. This code would be reusable across other platforms as well. The
last patch adds device tree based discovery for the sdhci-s3c driver.

In this patchset, the comments from Rob Herring for the fifth patch in this
series has been addressed.

This patchset is based on the following tree.
  https://github.com/kgene/linux-samsung.git   branch: next-samsung-dt

Thomas Abraham (6):
  mmc: sdhci-s3c: Remove usage of clk_type member in platform data
  arm: exynos4: use 'exynos4-sdhci' as device name for sdhci controllers
  arm: samsung: remove all uses of clk_type member in sdhci platform data
  mmc: sdhci-s3c: Keep a copy of platform data and use it
  mmc: Add OF bindings support for mmc host controller capabilities
  mmc: sdhci-s3c: Add device tree support

 .../devicetree/bindings/mmc/linux-mmc-host.txt     |   13 +
 .../devicetree/bindings/mmc/samsung-sdhci.txt      |   75 +++++++
 arch/arm/mach-exynos4/clock.c                      |   24 +-
 arch/arm/mach-exynos4/cpu.c                        |    5 +
 arch/arm/mach-exynos4/mach-armlex4210.c            |    3 -
 arch/arm/mach-exynos4/mach-nuri.c                  |    3 -
 arch/arm/mach-exynos4/mach-origen.c                |    2 -
 arch/arm/mach-exynos4/mach-smdk4x12.c              |    2 -
 arch/arm/mach-exynos4/mach-smdkv310.c              |    4 -
 arch/arm/mach-exynos4/mach-universal_c210.c        |    2 -
 arch/arm/plat-samsung/devs.c                       |    4 -
 arch/arm/plat-samsung/include/plat/sdhci.h         |   34 +++-
 arch/arm/plat-samsung/platformdata.c               |    2 -
 drivers/mmc/core/host.c                            |   31 +++
 drivers/mmc/host/sdhci-s3c.c                       |  231 +++++++++++++++++++-
 include/linux/mmc/host.h                           |    1 +
 16 files changed, 386 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
