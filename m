From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Thu, 05 May 2016 14:34:13 +0200
Message-ID: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

This is a different, second try to fix usb3503+lan on Odroid U3 board
if it was initialized by bootloader (e.g. for TFTP boot).

First version:
http://www.spinics.net/lists/linux-usb/msg140042.html


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


Issues
======
I am not familiar with USB subsystem, so please kindly guide me
where USB related code should be placed.

In the code there are still some issues to solve (FIXME/TODO notes).
If the approach is okay, I will improve the patchset. However at this
point - IT WORKS, which is nice. :)


Best regards,
Krzysztof

Krzysztof Kozlowski (13):
  usb: misc: usb3503: Clean up on driver unbind
  power/mmc: Move pwrseq drivers to power/pwrseq
  MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
  power: pwrseq: Enable COMPILE_TEST for drivers
  power: pwrseq: Remove mmc prefix from mmc_pwrseq
  power: pwrseq: Generalize mmc_pwrseq operations by removing mmc prefix
  power: pwrseq: simple: Add support for toggling regulator
  usb: hub: Handle deferred probe
  power: pwrseq: Add support for USB hubs with external power
  usb: hub: Power sequence the ports on activation
  usb: port: Parse pwrseq phandle from Device Tree
  ARM: dts: exynos: Switch the buck8 to GPIO mode on Odroid U3
  ARM: dts: exynos: Fix LAN and HUB after bootloader initialization on
    Odroid U3

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 +
 MAINTAINERS                                        |  8 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  7 ++
 drivers/mmc/Kconfig                                |  2 -
 drivers/mmc/core/Makefile                          |  3 -
 drivers/mmc/core/core.c                            |  8 +--
 drivers/mmc/core/host.c                            |  2 +-
 drivers/mmc/core/pwrseq.h                          | 52 --------------
 drivers/power/Kconfig                              |  1 +
 drivers/power/Makefile                             |  1 +
 drivers/{mmc/core => power/pwrseq}/Kconfig         | 21 ++++--
 drivers/power/pwrseq/Makefile                      |  3 +
 drivers/{mmc/core => power/pwrseq}/pwrseq.c        | 80 +++++++++++++++++-----
 drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c   | 15 ++--
 drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c | 73 ++++++++++++++++----
 drivers/usb/core/hub.c                             | 17 ++++-
 drivers/usb/core/hub.h                             |  3 +
 drivers/usb/core/port.c                            | 15 ++++
 drivers/usb/misc/usb3503.c                         | 28 ++++++++
 include/linux/mmc/host.h                           |  4 +-
 include/linux/pwrseq.h                             | 60 ++++++++++++++++
 22 files changed, 294 insertions(+), 113 deletions(-)
 delete mode 100644 drivers/mmc/core/pwrseq.h
 rename drivers/{mmc/core => power/pwrseq}/Kconfig (65%)
 create mode 100644 drivers/power/pwrseq/Makefile
 rename drivers/{mmc/core => power/pwrseq}/pwrseq.c (50%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c (89%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c (64%)
 create mode 100644 include/linux/pwrseq.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
