From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 1
Date: Mon, 14 Apr 2014 15:46:08 +0200
Message-ID: <CAPDyKFo4U1RpBFCiF2XvZ83pWRjfcpPnExdA8RE1TuFsXD2q4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37603 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaDNNqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 09:46:09 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so7977382qaq.36
        for <linux-mmc@vger.kernel.org>; Mon, 14 Apr 2014 06:46:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Chris,

Here are a collection of patches for which I have acked earlier. I
have changed my ack to a "signed-off-by" for these patches, I suppose
that makes sense!?

Unless you have some additional review comments, please pull them into
you mmc-next branch once you have re-based it towards an 3.15 rc.

Kind regards
Ulf Hansson


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/linux-2.6.git
mmc-next_for_chris_3.16_take1

for you to fetch changes up to 43256f7aa3353389ddca072e77d45571de561ffb:

  mmc: Add realtek USB sdmmc host driver (2014-04-14 15:26:37 +0200)

----------------------------------------------------------------
Alexander Shiyan (2):
      mmc: mxcmmc: Convert to devm-* API
      mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS

Axel Lin (2):
      mmc: Convert to use ATTRIBUTE_GROUPS
      mmc: sdhci-s3c: Remove unused define for NUM_GPIOS

Fabio Estevam (1):
      mmc: card.h: Use NULL instead of 0 for END_FIXUP

Jaehoon Chung (7):
      mmc: dw_mmc: use the mmc_of_parse() instead of local parser
      mmc: dw_mmc: replace the bus_hz checking point
      mmc: dw_mmc: remove unused member variable.
      mmc: dw_mmc: fix minor coding style.
      mmc: dw_mmc: remove the unnecessary function.
      mmc: dw_mmc: remove the dw_mci_of_cd_gpio/wp_gpio()
      mmc: dw_mmc: restore the card-present checking point

Markus Mayer (1):
      mmc: Delay the card_event callback into the mmc_rescan worker

Micky Ching (2):
      mmc: rtsx: add R1-no-CRC mmc command type handle
      mmc: rtsx: modify error handle and remove smatch warnings

Roger Tseng (1):
      mmc: Add realtek USB sdmmc host driver

Sachin Kamat (1):
      mmc: dw_mmc: exynos: Staticize dw_mci_exynos_pmops

Seungwon Jeon (12):
      mmc: clarify DDR timing mode between SD-UHS and eMMC
      mmc: mmci: clarify DDR timing mode between SD-UHS and eMMC
      mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
      mmc: sh_mmcif: clarify DDR timing mode between SD-UHS and eMMC
      mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
      mmc: dw_mmc: clarify DDR timing mode between SD-UHS and eMMC
      mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC
      mmc: drop the speed mode of card's state
      mmc: identify available device type to select
      mmc: step power class after final selection of bus mode
      mmc: rework selection of bus speed mode
      mmc: add support for HS400 mode of eMMC5.0

Stefan Wahren (1):
      mmc: core: Use maximum timeout values in case TACC field is zero

Ulf Hansson (1):
      mmc: core: Invoke sdio func driver's PM callbacks from the sdio bus

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    5 -
 drivers/mmc/core/bus.c                             |    9 +-
 drivers/mmc/core/core.c                            |   12 +-
 drivers/mmc/core/debugfs.c                         |    8 +-
 drivers/mmc/core/mmc.c                             |  678 +++++----
 drivers/mmc/core/sd.c                              |   28 +-
 drivers/mmc/core/sd.h                              |    1 -
 drivers/mmc/core/sdio.c                            |   53 +-
 drivers/mmc/core/sdio_bus.c                        |   14 +-
 drivers/mmc/core/slot-gpio.c                       |    4 +-
 drivers/mmc/host/Kconfig                           |    7 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |    7 +-
 drivers/mmc/host/dw_mmc.c                          |  178 +--
 drivers/mmc/host/dw_mmc.h                          |    2 -
 drivers/mmc/host/mmci.c                            |    6 +-
 drivers/mmc/host/mxcmmc.c                          |  114 +-
 drivers/mmc/host/omap_hsmmc.c                      |    4 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  124 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  | 1455 ++++++++++++++++++++
 drivers/mmc/host/sdhci-s3c.c                       |    3 -
 drivers/mmc/host/sdhci.c                           |    4 +-
 drivers/mmc/host/sh_mmcif.c                        |    9 +-
 include/linux/mmc/card.h                           |   29 +-
 include/linux/mmc/dw_mmc.h                         |   14 -
 include/linux/mmc/host.h                           |   48 +-
 include/linux/mmc/mmc.h                            |   23 +-
 27 files changed, 2121 insertions(+), 719 deletions(-)
 create mode 100644 drivers/mmc/host/rtsx_usb_sdmmc.c
