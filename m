From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 00/12] power: add generic power sequence framework
Date: Fri, 17 Jun 2016 18:09:13 +0800
Message-ID: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi all,

We have an well-known problem that the device needs to do some power
sequence before it can be recognized by related host, the typical
example like hard-wired mmc devices and usb devices. This power
sequence is hard to be described at device tree and handled by
related host driver, so we have created a common power sequence
framework to handle this requirement. The generic code is supplied
some common helpers from host driver, and individual power sequence
driver handles kinds of power sequence for devices.

Since the MMC has already done the similar things, and this power
sequence handling can be generic, we use mmc power sequence code
as base to create this framework.

This patch set is based on Krzysztof Kozlowski's RFC patch set (v4.7-rc1)
[1], and making some changes which can let it be generic. After that,
we create a generic power sequence driver for USB devices which handles
below things, it includes all input signals for devices I can consider.

- Clock and its frequencies
- GPIO for reset and the duration time
- GPIO for enable
- Regulator for power

This patch set is tested on i.mx6 sabresx evk using a dts change, I use
two hot-plug devices to simulate this use case. The udoo board changes
were tested using my last power sequence patch set. [2]

@Maciej S. Szmigiero, Oscar, would you please test them on imx6qdl udoo
boards?
@Krzysztof Kozlowski, I have not written changes for your case since I
find the other sequences have already at drivers/usb/misc/usb3503.c,
this driver should be the place for your power sequence, I am not
sure if enable regualator at usb core is suitable for you or not.
@others, it is better you can help test this patch set for MMC devices
and your USB devices with dts changes.

Thank you for your time!

[1] http://www.spinics.net/lists/linux-usb/msg142351.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/413580.html

Krzysztof Kozlowski (5):
  power/mmc: Move pwrseq drivers to power/pwrseq
  MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
  power: pwrseq: Enable COMPILE_TEST for drivers
  power: pwrseq: Remove mmc prefix from mmc_pwrseq
  power: pwrseq: Generalize mmc_pwrseq operations by removing mmc prefix

Peter Chen (7):
  power: pwrseq: change common helpers as generic
  power: pwrseq: rename file name for generic driver
  doc: binding: pwrseq-usb-generic: add binding doc for generic usb
    power sequence driver
  power: pwrseq: pwrseq_usb_generic: add generic power sequence support
    for USB deivces
  usb: core: add power sequence handling for USB devices
  usb: chipidea: host: let the hcd know's parent device node
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../{mmc => power/pwrseq}/mmc-pwrseq-simple.txt    |   0
 .../pwrseq/pwrseq-emmc.txt}                        |   0
 .../bindings/power/pwrseq/pwrseq-usb-generic.txt   |  31 ++++
 .../devicetree/bindings/usb/usb-device.txt         |   2 +
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  30 +--
 drivers/mmc/Kconfig                                |   2 -
 drivers/mmc/core/Kconfig                           |  24 ---
 drivers/mmc/core/Makefile                          |   3 -
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/host.c                            |  10 +-
 drivers/mmc/core/pwrseq.h                          |  52 ------
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/power/pwrseq/Kconfig                       |  43 +++++
 drivers/power/pwrseq/Makefile                      |   4 +
 drivers/{mmc/core/pwrseq.c => power/pwrseq/core.c} |  71 ++++----
 drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c   |  17 +-
 .../pwrseq/pwrseq_mmc_simple.c}                    |  33 ++--
 drivers/power/pwrseq/pwrseq_usb_generic.c          | 202 +++++++++++++++++++++
 drivers/usb/chipidea/host.c                        |  18 +-
 drivers/usb/core/hub.c                             |  73 +++++++-
 drivers/usb/core/hub.h                             |   1 +
 include/linux/mmc/host.h                           |   4 +-
 include/linux/pwrseq.h                             |  61 +++++++
 25 files changed, 527 insertions(+), 173 deletions(-)
 rename Documentation/devicetree/bindings/{mmc => power/pwrseq}/mmc-pwrseq-simple.txt (100%)
 rename Documentation/devicetree/bindings/{mmc/mmc-pwrseq-emmc.txt => power/pwrseq/pwrseq-emmc.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
 delete mode 100644 drivers/mmc/core/Kconfig
 delete mode 100644 drivers/mmc/core/pwrseq.h
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 rename drivers/{mmc/core/pwrseq.c => power/pwrseq/core.c} (51%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c (88%)
 rename drivers/{mmc/core/pwrseq_simple.c => power/pwrseq/pwrseq_mmc_simple.c} (81%)
 create mode 100644 drivers/power/pwrseq/pwrseq_usb_generic.c
 create mode 100644 include/linux/pwrseq.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
