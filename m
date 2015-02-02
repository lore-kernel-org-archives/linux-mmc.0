From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 0/3] Add support for hardware reset of eMMC card on reboot
Date: Mon, 02 Feb 2015 09:33:45 +0100
Message-ID: <1422866028-27891-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

This patchset adds new mmc power sequence driver, which performs eMMC
card hardware reset. Such power sequence, involving resetting emmc card,
is required on some boards to properly perform system reboot procedure.

This patchset originates from fixes for the reboot hang issue on
Hardkernel's Odroid boards with eMMC card. Those boards are designed in
such a way, that the eMMC nreset signal is routed to SoC GPIO line
instead of the board reset logic. To properly restard system and let ROM
bootloader to read next bootloader from eMMC, one need to reset emmc
card before performing reboot.

The initial patches consisted of a complete reset/power off driver, but
after further analysis, it turned out that only eMMC nreset line control
logic is specific for those boards. Everything else can be done by the
MMC code. Sjoerd Simons and Jaehoon Chung suggested that such feature is
something generic, not really specific to the MMC host controller used
on Odroid boards, so it should be implemented in MMC core. Then, Ulf
Hansson suggested to use recently introduced power sequences driver for
implementing this feature.

This patches provides a simple mmc-pwrseq-emmc driver, which controls
single gpio line and performs eMMC reset procedure just after card power
on and just before turning it off or performing system reboot. This
driver has been instantiated on Odroid X2/U3 and XU3 boards.

Patches are prepared on top of linux-next.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v2:
- moved all code to separate mmc-prwseq-emmc driver

v1:
https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg41641.html
- moved all the code and logic to mmc core (slot-gpio.c), so it is
  available to all mmc drivers, which uses device tree

v0:
http://thread.gmane.org/gmane.linux.kernel.samsung-soc/42477/
- separated emmc reset logic from other code and moved to exynos dw-mmc
  driver

initial version:
http://thread.gmane.org/gmane.linux.power-management.general/51855/
- separate reset driver implementing all the logic

Patch summary:

Marek Szyprowski (3):
  mmc: pwrseq: add driver for emmc hardware reset
  ARM: dts: exynos4412-odroid*: add eMMC reset line
  ARM: dts: exynos5422-odroidxu3: add eMMC reset line

 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.txt    |  25 +++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  14 +++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  17 ++++
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/pwrseq.c                          |   3 +
 drivers/mmc/core/pwrseq.h                          |   1 +
 drivers/mmc/core/pwrseq_emmc.c                     | 108 +++++++++++++++++++++
 7 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
 create mode 100644 drivers/mmc/core/pwrseq_emmc.c

-- 
1.9.2
