From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v4 00/14] usb/mmc/power: Generic power sequence (and fix USB/LAN
 when TFTP booting)
Date: Thu, 09 Jun 2016 11:44:17 +0200
Message-ID: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb@v
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,


Another version for solving a problem of power sequence on USB
hubs and devices.  Apparently I am not the only one experiencing it.

The patchset tries to provide a framework for generic power sequence
of USB devices but the USB part is left to Peter Chen.

Patchset is also available here:
repo:   https://github.com/krzk/linux
branch: for-next/odroid-u3-usb3503-lan-boot-fixes-v4


Changes since v3
================
1. Address Rob's comments.  All regulator supplies are parsed and
   toggled during power sequence.  This comes with two new patches:
   a. regulator,
   b. simplefb.
2. Minor fixes in pwrseq-simple driver - proper module removal path.
3. Minor fixes in example USB code (pointed out by Stephen Boyd).


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


Krzysztof Kozlowski (14):
  regulator: of: Add helper for getting all supplies
  simplefb: Use new devm_of_regulator_all_get helper and bulk API
  power/mmc: Move pwrseq drivers to power/pwrseq
  MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
  power: pwrseq: Enable COMPILE_TEST for drivers
  power: pwrseq: Remove mmc prefix from mmc_pwrseq
  power: pwrseq: Generalize mmc_pwrseq operations by removing mmc prefix
  power: pwrseq: simple: Add support for regulators and generic property
  power: pwrseq: Add support for USB hubs with external power
  usb: hub: Handle deferred probe
  EXAMPLE CODE: usb: port: Parse pwrseq phandle from Device Tree
  EXAMPLE CODE: usb: hub: Power sequence the ports on activation
  ARM: dts: exynos: Switch the buck8 to GPIO mode on Odroid U3
  ARM: dts: exynos: Fix LAN and HUB after bootloader initialization on
    Odroid U3

 .../pwrseq/pwrseq-emmc.txt}                        |   0
 .../pwrseq/pwrseq-simple.txt}                      |  30 ++-
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   5 +
 drivers/mmc/Kconfig                                |   2 -
 drivers/mmc/core/Makefile                          |   3 -
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/host.c                            |   2 +-
 drivers/mmc/core/pwrseq.c                          | 110 ---------
 drivers/mmc/core/pwrseq.h                          |  52 -----
 drivers/mmc/core/pwrseq_simple.c                   | 141 ------------
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/{mmc/core => power/pwrseq}/Kconfig         |  22 +-
 drivers/power/pwrseq/Makefile                      |   3 +
 drivers/power/pwrseq/pwrseq.c                      | 153 +++++++++++++
 drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c   |  17 +-
 drivers/power/pwrseq/pwrseq_simple.c               | 245 +++++++++++++++++++++
 drivers/regulator/of_regulator.c                   |  86 ++++++++
 drivers/usb/core/hub.c                             |  16 +-
 drivers/usb/core/hub.h                             |   3 +
 drivers/usb/core/port.c                            |  15 ++
 drivers/video/fbdev/simplefb.c                     |  71 ++----
 include/linux/mmc/host.h                           |   4 +-
 include/linux/pwrseq.h                             |  63 ++++++
 include/linux/regulator/of_regulator.h             |  13 ++
 26 files changed, 680 insertions(+), 395 deletions(-)
 rename Documentation/devicetree/bindings/{mmc/mmc-pwrseq-emmc.txt => power/pwrseq/pwrseq-emmc.txt} (100%)
 rename Documentation/devicetree/bindings/{mmc/mmc-pwrseq-simple.txt => power/pwrseq/pwrseq-simple.txt} (50%)
 delete mode 100644 drivers/mmc/core/pwrseq.c
 delete mode 100644 drivers/mmc/core/pwrseq.h
 delete mode 100644 drivers/mmc/core/pwrseq_simple.c
 rename drivers/{mmc/core => power/pwrseq}/Kconfig (60%)
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/pwrseq.c
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c (88%)
 create mode 100644 drivers/power/pwrseq/pwrseq_simple.c
 create mode 100644 include/linux/pwrseq.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
