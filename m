From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v3 0/5]
Date: Wed,  5 Aug 2015 16:16:54 +0800
Message-ID: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>, Govindraj Raja <govind>
List-Id: linux-mmc@vger.kernel.org

Synopsys DesignWare mobile storage host controller supports three
types of transfer mode: pio, internal dma and external dma. However,
dw_mmc can only supports pio and internal dma now. Thus some platforms
using dw-mshc integrated with generic dma can't work in dma mode. So we
submit this patch to achieve it.

And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
(commit:f95f3850) for the first version of dw_mmc and never be touched from
then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
time. Nowadays, device-tree helps us to support a variety of boards with one
kernel. That's why we need to remove it and decide the transfer mode at runtime.

This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
to make the running.

Patch does the following things:
- remove CONFIG_MMC_DW_IDMAC config option
- add bindings for idmac and edmac used by synopsys-dw-mshc
  at runtime
- add edmac support for synopsys-dw-mshc

Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc


Changes in v3:
- choose transfer mode at runtime
- remove all CONFIG_MMC_DW_IDMAC config option
- add supports-idmac property for some platforms

Changes in v2:
- Fix typo of dev_info msg
- remove unused dmach from declaration of dw_mci_dma_slave

Shawn Lin (5):
  mmc: dw_mmc: Add external dma interface support
  Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
  arm: configs: remove CONFIG_MMC_DW_IDMAC
  mips: configs: remove CONFIG_MMC_DW_IDMAC
  ARM: dts: add supports-idmac property

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  41 +++
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/arm/boot/dts/exynos3250-monk.dts              |   1 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |   1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   1 +
 arch/arm/boot/dts/exynos4412-origen.dts            |   1 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |   1 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +
 arch/arm/boot/dts/exynos5250-snow.dts              |   3 +
 arch/arm/boot/dts/exynos5250-spring.dts            |   2 +
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   2 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   2 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   3 +
 arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +
 arch/arm/configs/exynos_defconfig                  |   1 -
 arch/arm/configs/hisi_defconfig                    |   1 -
 arch/arm/configs/lpc18xx_defconfig                 |   1 -
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/zx_defconfig                      |   1 -
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 +
 arch/mips/configs/pistachio_defconfig              |   1 -
 drivers/mmc/host/Kconfig                           |  11 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
 drivers/mmc/host/dw_mmc.c                          | 277 +++++++++++++++++----
 include/linux/mmc/dw_mmc.h                         |  28 ++-
 36 files changed, 338 insertions(+), 72 deletions(-)

-- 
2.3.7
