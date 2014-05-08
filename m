From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 2
Date: Thu, 8 May 2014 14:57:07 +0200
Message-ID: <CAPDyKFrCuL9HmQyOPZXex1WZT0LiJ6HCj6JiXoh-x+o-CHuhiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:65249 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbaEHM5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 08:57:08 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so2701906qga.28
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 05:57:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Chris,

Here are a second collection of patches for 3.16.

Unless you have some additional review comments, please pull them into
your mmc-next branch.

Note 1)
I have not included any sdhci patches, to prevent additional conflicts
with Russell's big patchset.

Note 2)
I have not included the patch below; since I think it would be better
if you just drop the patch which this is reverting from your mmc next
branch.
[PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error handle and
remove smatch warnings"

Kind regards
Uffe


The following changes since commit 865042c0163792aedb05ad3428b70d9904643a8e:

  mmc: Add realtek USB sdmmc host driver (2014-04-22 07:06:49 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git mmc-next_for_chris_3.16_take2

for you to fetch changes up to c75d405f957f8b674cd985572c6f043126e3c576:

  MAINTAINERS: mmc: Update email for host driver maintainer
(2014-05-08 14:35:43 +0200)

----------------------------------------------------------------
Alex Smith (1):
      mmc: jz4740: don't wait for PRG_DONE after stop command with R1 response

Alexander Shiyan (1):
      mmc: mxcmmc: Use mmc_regulator_get_supply() API

Alexandre Belloni (1):
      mmc: atmel: don't test host->data

Arnd Bergmann (1):
      mmc: rtsx: fix possible linking error if built-in

Daniel Willmann (1):
      mmc: mxs: fix card detection function for broken card detect

Jonas Jensen (1):
      mmc: moxart: Add MOXA ART SD/MMC driver

Sebastian Hesselbarth (2):
      mmc: mvsdio: silence card detect notice
      mmc: mvsdio: workaround for spurious irqs

Seungwon Jeon (6):
      mmc: drop the speed mode of card's state
      mmc: identify available device type to select
      mmc: step power class after final selection of bus mode
      mmc: rework selection of bus speed mode
      mmc: add support for HS400 mode of eMMC5.0
      mmc: core: add DT bindings for eMMC HS400 1.8/1.2V

Tim Kryger (2):
      mmc: core: Try other signal levels during power up
      mmc: core: Improve support for deferred regulators

Ulf Hansson (1):
      MAINTAINERS: mmc: Update email for host driver maintainer

 Documentation/devicetree/bindings/mmc/mmc.txt      |    2 +
 .../devicetree/bindings/mmc/moxa,moxart-mmc.txt    |   30 +
 MAINTAINERS                                        |    2 +-
 drivers/mmc/core/bus.c                             |    9 +-
 drivers/mmc/core/core.c                            |   43 +-
 drivers/mmc/core/debugfs.c                         |    5 +-
 drivers/mmc/core/host.c                            |    4 +
 drivers/mmc/core/mmc.c                             |  666 +++++++++++-------
 drivers/mmc/core/sd.c                              |   16 +-
 drivers/mmc/core/sd.h                              |    1 -
 drivers/mmc/core/sdio.c                            |    8 +-
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/atmel-mci.c                       |   13 +-
 drivers/mmc/host/jz4740_mmc.c                      |   11 +-
 drivers/mmc/host/moxart-mmc.c                      |  730 ++++++++++++++++++++
 drivers/mmc/host/mvsdio.c                          |   20 +-
 drivers/mmc/host/mxcmmc.c                          |   44 +-
 drivers/mmc/host/mxs-mmc.c                         |    7 +
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |    5 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |    4 +-
 include/linux/mmc/card.h                           |   27 +-
 include/linux/mmc/host.h                           |   51 +-
 include/linux/mmc/mmc.h                            |   23 +-
 24 files changed, 1340 insertions(+), 391 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/moxa,moxart-mmc.txt
 create mode 100644 drivers/mmc/host/moxart-mmc.c
