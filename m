From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 0/2] mmc: sdhci: one expansion for SDHCI base code and add Cadence SDHCI driver
Date: Fri,  2 Dec 2016 11:21:49 +0900
Message-ID: <1480645311-13004-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Al Cooper <alcooperx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org


1/2 tweaks sdhci_execute_tuning(), which I want to use for 2/2.

2/2 adds a new driver for Cadence's controller IP.



Masahiro Yamada (2):
  mmc: sdhci: continue normal tuning if unsupported by platform tuning
  mmc: sdhci-cadence: add Cadence SD4HC support

 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  30 +++
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 279 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   4 +-
 5 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
 create mode 100644 drivers/mmc/host/sdhci-cadence.c

-- 
2.7.4
