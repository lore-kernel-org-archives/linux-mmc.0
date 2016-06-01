From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 00/12] usb/mmc/power: Generic power sequence (and fix
 USB/LAN when TFTP booting)
Date: Wed, 01 Jun 2016 10:02:09 +0200
Message-ID: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,


My third approach for a USB power sequence which fixes usb3503+lan
on Odroid U3 board if it was initialized by bootloader
(e.g. for TFTP boot).


Changes since v2
================
1. Add Javier's reviewed-by tags. Address some comments.
2. Re-use existing properties for GPIOs etc by pwrseq-simple
   driver.  New property is still added: "power-sequence".
   I tried to address and do according to Rob's comments.

   Please look at patch 6/12 ("power: pwrseq: simple: Add support
   for regulator and generic property") for bindings and the
   new code around matching "power-sequence" property.

3. I marked the usb code as "EXAMPLE" because that part
   is left to Peter Chen.


Problem
=======
When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
is required, e.g. by suspend to RAM. The actual TFTP boot does
not have to happen. Just "usb start" from U-Boot is sufficient.

>From the schematics, the regulator is a supply only to LAN, however
without toggling it off/on, the usb3503 hub won appear neither.


Solution
========
This is very similar to the MMC pwrseq behavior so the idea is to:
1. Move MMC pwrseq drivers to generic place,
2. Extend the pwrseq-simple with regulator toggling,
3. Add support to USB hub and port core for pwrseq,
4. Toggle the regulator when needed.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  power/mmc: Move pwrseq drivers to power/pwrseq
  MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
  power: pwrseq: Enable COMPILE_TEST for drivers
  power: pwrseq: Remove mmc prefix from mmc_pwrseq
  power: pwrseq: Generalize mmc_pwrseq operations by removing mmc prefix
  power: pwrseq: simple: Add support for regulator and generic property
  power: pwrseq: Add support for USB hubs with external power
  usb: hub: Handle deferred probe
  EXAMPLE CODE: usb: port: Parse pwrseq phandle from Device Tree
  EXAMPLE CODE: usb: hub: Power sequence the ports on activation
  ARM: dts: exynos: Switch the buck8 to GPIO mode on Odroid U3
  ARM: dts: exynos: Fix LAN and HUB after bootloader initialization on
    Odroid U3

 .../pwrseq/pwrseq-emmc.txt}                        |   0
 .../pwrseq/pwrseq-simple.txt}                      |  29 +++-
 MAINTAINERS                                        |   9 ++
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   5 +
 drivers/mmc/Kconfig                                |   2 -
 drivers/mmc/core/Makefile                          |   3 -
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/host.c                            |   2 +-
 drivers/mmc/core/pwrseq.c                          | 110 ---------------
 drivers/mmc/core/pwrseq.h                          |  52 -------
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/{mmc/core => power/pwrseq}/Kconfig         |  22 ++-
 drivers/power/pwrseq/Makefile                      |   3 +
 drivers/power/pwrseq/pwrseq.c                      | 153 +++++++++++++++++++++
 drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c   |  17 +--
 drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c | 110 ++++++++++++---
 drivers/usb/core/hub.c                             |  16 ++-
 drivers/usb/core/hub.h                             |   3 +
 drivers/usb/core/port.c                            |  15 ++
 include/linux/mmc/host.h                           |   4 +-
 include/linux/pwrseq.h                             |  63 +++++++++
 22 files changed, 414 insertions(+), 214 deletions(-)
 rename Documentation/devicetree/bindings/{mmc/mmc-pwrseq-emmc.txt => power/pwrseq/pwrseq-emmc.txt} (100%)
 rename Documentation/devicetree/bindings/{mmc/mmc-pwrseq-simple.txt => power/pwrseq/pwrseq-simple.txt} (53%)
 delete mode 100644 drivers/mmc/core/pwrseq.c
 delete mode 100644 drivers/mmc/core/pwrseq.h
 rename drivers/{mmc/core => power/pwrseq}/Kconfig (60%)
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/pwrseq.c
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c (88%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c (52%)
 create mode 100644 include/linux/pwrseq.h

-- 
1.9.1
