From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 0/5] mmc: add stm32 sdmmc controller
Date: Thu, 15 Feb 2018 14:34:52 +0100
Message-ID: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch serie adds support of stm32 SDMMC controller.
stm32h7 is the first SoC to use stm32 SDMMC controller
(previous SoC had pl180 controller).

The SDMMC features include the following:
-Full compliance with MultiMediaCard System Specification Version 4.51.
 Card support for three different databus modes:
 1-bit (default), 4-bit and 8-bit.
-Full compliance with SD memory card specifications version 4.1.
 SDR104 speed limited to maximum allowed I/O speed, SPI mode and
 UHS-II mode not supported.
-Full compliance with SDIO card specification version 4.0.

Ludovic Barre (5):
  dt-bindings: mmc: document the stm32 sdmmc bindings
  mmc: add stm32 sdmmc controller driver
  ARM: dts: stm32: add sdmmc support for stm32h743
  ARM: dts: stm32: add sdmmc1 support for stm32h743i-eval
  ARM: configs: stm32: add mmc and ext2/3/4 support

 .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     |  35 +
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  26 +
 arch/arm/boot/dts/stm32h743.dtsi                   |  26 +
 arch/arm/boot/dts/stm32h743i-eval.dts              |  11 +
 arch/arm/configs/stm32_defconfig                   |   4 +-
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/stm32-sdmmc.c                     | 710 +++++++++++++++++++++
 drivers/mmc/host/stm32-sdmmc.h                     | 220 +++++++
 9 files changed, 1040 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
 create mode 100644 drivers/mmc/host/stm32-sdmmc.c
 create mode 100644 drivers/mmc/host/stm32-sdmmc.h

-- 
2.7.4
