From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 0/9] mmc: mmci: add support for STM32 SD controller
Date: Tue, 10 Jan 2017 09:42:07 +0100
Message-ID: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35882 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030674AbdAJImo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so7670576wmr.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:43 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

The SD controller found in STM32 MCUs happens to be yet another variant
of the ARM PrimeCell PL18x SD host controller, for which the mmci driver
exists.

This series adds support for it to the mmci driver.

As other varians, this one need some specific quirks, that this series
address. Most notably this variant has not AMBA PrimeCell id registers,
so we can't probe it using the AMBA PrimeCell generic "compatible" and
mechanism; rather this series adds support to the mmci driver for
register itself also as platform driver, so that specific "copatible"
strings can also be used.

I tested this on my STM32F469-disco board, that is able to boot from an
SD card, and write/read to/from it.

RFT for other variants (to check I didn't broke anything) and with MMC
cards. In particular I tried to implement also support for open-collector
communication mode, that AFAICT is used only on MMC cards, but I couldn't
test it.

Changes since v1:
- fixed compile failure when CONFIG_ARM_AMBA is enabled
- fixed mmc CD pin claimed two times
- trivial whitespace and newline fixes

Andrea Merello (9):
  mmc: mmci: don't pretend IP variants with only one IRQ to have two
    mask regs
  mmc: mmci: add support for not-amba, but still compatible, variants
  mmc: mmci: don't pretend all variants to have MCI_STARBITERR flag
  mmc: mmci: add support for setting pad type via pinctrl
  mmc: mmci: add STM32 variant
  DT: stm32f429: add pin map for SDIO controller
  DT: stm32f429: add node for SDIO controller
  DT: stm32f469-disco: add node for SDIO controller
  Documentation: document mmci STM32 DT binding

 Documentation/devicetree/bindings/mmc/mmci.txt |   2 +-
 arch/arm/boot/dts/stm32f429.dtsi               |  47 ++-
 arch/arm/boot/dts/stm32f469-disco.dts          |  29 ++
 drivers/mmc/host/Kconfig                       |   8 +-
 drivers/mmc/host/mmci.c                        | 398 +++++++++++++++++++------
 drivers/mmc/host/mmci.h                        |   7 +-
 6 files changed, 396 insertions(+), 95 deletions(-)

--
2.7.4
