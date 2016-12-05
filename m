From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 0/2] mmc: sdhci: export sdhci_execute_tuning(), then add Cadence SDHCI driver
Date: Mon,  5 Dec 2016 11:10:52 +0900
Message-ID: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Andrei Pistirica <andrei.pistirica@microchip.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Joshua Henderson <joshua.henderson@microchip.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>, Eric Anholt <eric@anholt.net>
List-Id: linux-mmc@vger.kernel.org


1/2 exports sdhci_execute_tuning(), which I want to use for 2/2.

2/2 adds a new driver for Cadence's controller IP.


Masahiro Yamada (2):
  mmc: sdhci: export sdhci_execute_tuning()
  mmc: sdhci-cadence: add Cadence SD4HC support

 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  30 +++
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 280 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 6 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
 create mode 100644 drivers/mmc/host/sdhci-cadence.c

-- 
2.7.4
