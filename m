From: <patrice.chotard@st.com>
Subject: [PATCH v2 00/15] Add MMCI support for STM32F SoCs family
Date: Tue, 16 Jan 2018 13:30:44 +0100
Message-ID: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series reworks patches submitted one year ago by Andrea Merello [1] 
but without succeed to merged it.

STM32F4 and STM32F7 SoCs families embeds a variant of the ARM PrimeCell 
PL18x SD host controller, for which the mmci driver exists. 
This series adds support for these SoCs to the mmci driver.

As other variants, this one need some specific quirks, that this 
series address. 

This series has been tested on following boards :
	_ stm32f429-eval
	_ stm32f469-disco
	_ stm32f746-eval
	_ stm32f769-disco

DT update for stm32f7 pinctrl, stm32f746-eval and stm32f769-disco boards
will be sent later to avoid conflict with pending stm32f7 series [1] which
is not yet merged on kernel mainline.

[1] https://www.spinics.net/lists/linux-mmc/msg41616.html
[2] https://patchwork.kernel.org/patch/10104447/

v2: _ add Revievied-by, Acked-by in some patches
    _ replace bool by u32 for start_err and opendrain fields of struct variant_data
    _ split previous patch 3 in two parts, first patch clean the open drain bit code
      and second part add pinctrl pins management when no open drain bit is available.
    _ replace "pl180" by "PL180" in patch "mmc: mmci: Add STM32 variant"

Andrea Merello (2):
  ARM: dts: stm32: Add pin map for SDIO controller on stm32f4
  ARM: dts: stm32: Enable SDIO controller on stm32f469 disco board

Patrice Chotard (13):
  mmc: mmci: Don't pretend all variants to have MMCIMASK1 register
  mmc: mmci: Don't pretend all variants to have MCI_STARBITERR flag
  mmc: mmci: Don't pretend all variants to have OPENDRAIN bit
  mmc: mmci: Add support for setting pad type via pinctrl
  mmc: mmci: Add STM32 variant
  ARM: dts: stm32: Add SDIO controller for stm32f746
  ARM: dts: stm32: Add SDIO controller for stm32f429
  ARM: dts: stm32: Enable SDIO controller on stm32429i-eval board
  ARM: stm32: Add AMBA support for STM32F4 and STM32F7 SoCs
  ARM: configs: stm32: Enable MMC_ARMMMCI support
  ARM: configs: stm32: Enable EXT3_FS support
  clk: stm32: Add clk entry for SDMMC2 on stm32F769
  gpio: stmpe: i2c transfer are forbiden in atomic context

 arch/arm/boot/dts/stm32429i-eval.dts   |  19 +++++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi |  31 +++++++++
 arch/arm/boot/dts/stm32f429.dtsi       |  11 +++
 arch/arm/boot/dts/stm32f469-disco.dts  |  19 +++++
 arch/arm/boot/dts/stm32f746.dtsi       |  22 ++++++
 arch/arm/configs/stm32_defconfig       |   3 +
 arch/arm/mach-stm32/Kconfig            |   3 +
 drivers/clk/clk-stm32f4.c              |   3 +-
 drivers/gpio/gpio-stmpe.c              |  20 +++---
 drivers/mmc/host/mmci.c                | 124 +++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h                |   6 ++
 11 files changed, 236 insertions(+), 25 deletions(-)

-- 
1.9.1
