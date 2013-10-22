From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for mmc-next
Date: Tue, 22 Oct 2013 14:48:01 +0200
Message-ID: <CAPDyKFqtoTqMWeGJeuLt3rFCqEt9uHSYyN1qRX7n+G6UdW7sbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:54485 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3JVMsC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 08:48:02 -0400
Received: by mail-qe0-f41.google.com with SMTP id x7so4763800qeu.28
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 05:48:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Chris,

I have been posting some various patchsets to the mmc-list since early
September. This pull request collects the patches for you to pull in
to your mmc tree for the mmc-next branch. I hope you find this
convenient.

Kind regards
Ulf Hansson


The following changes since commit 26cb3023896d8b188db0000328e39a7cdb92c0a4:

  mmc: sdhci: Use jiffies instead of a timeout counter (2013-10-21
15:58:47 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ulfh/mmc.git mmc-next_for_chris

for you to fetch changes up to 5d6f3429bc44f653a0b58d8255532705d40d40e0:

  mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume
(2013-10-22 12:39:40 +0200)

----------------------------------------------------------------
Highlights:
Core:
-Invent MMC_CAP_RUNTIME_RESUME, to resume at runtime_resume.
-Improve the suspend|resume sequence when using runtime PM.
-Prevent suspend during card insert/removal for wakeup enabled devices.
-Remove deprecated mmc_suspend|resume_host API.
-Prevent spec violation regarding VCC/VDD voltage level at card initialization.
-Bugfix for some specific switch commands.

Drivers:
-Remove use of deprecated mmc_suspend|resume_host API.

Misc:
-Remove the last user of CONFIG_MMC_CLKGATE in MIPS db1235 defconfig.

----------------------------------------------------------------
Ulf Hansson (41):
      mmc: core: Do not poll for busy with status cmd for all switch cmds
      mmc: core: Let mmc_power_up|cycle take ocr as parameter
      mmc: core: Let mmc_set_signal_voltage take ocr as parameter
      mmc: core: Remove unnecessary retry mechanism at SDIO attach
      mmc: core: Cleanup code for setting ocr mask for SDIO
      mmc: core: Move cached value of the negotiated ocr mask to card struct
      mmc: core: Prevent violation of specs while initializing cards
      mmc: core: Collect common code for card ocr validation
      mmc: core: Signal wakeup event at card insert/removal
      mmc: atmel-mci: Remove redundant suspend and resume callbacks
      mmc: au1xmmc: Move away from using deprecated APIs
      mmc: bfin_sdh: Move away from using deprecated APIs
      mmc: cb710: Move away from using deprecated APIs
      mmc: davinci_mmc: Move away from using deprecated APIs
      mmc: dw_mmc: Move away from using deprecated APIs
      mmc: jz4740: Move away from using deprecated APIs
      mmc: msm_sdcc: Move away from using deprecated APIs
      mmc: mvsdio: Remove redundant suspend and resume callbacks
      mmc: vub300: Move away from using deprecated APIs
      mmc: sdhci: Move away from using deprecated APIs
      mmc: tifm_sd: Move away from using deprecated APIs
      mmc: omap: Remove redundant suspend and resume callbacks
      mmc: omap_hsmmc: Move away from using deprecated APIs
      mmc: mxs-mmc: Move away from using deprecated APIs
      mmc: mxcmmc: Move away from using deprecated APIs
      mmc: wmt-sdmmc: Move away from using deprecated APIs
      mmc: s3cmci: Remove redundant suspend and resume callbacks
      mmc: pxamci: Remove redundant suspend and resume callbacks
      mmc: wbsd: Move away from using deprecated APIs
      mmc: rtsx: Remove redundant suspend and resume callbacks
      mmc: sdricoh_cs: Move away from using deprecated APIs
      mmc: sh_mmcif: Move away from using deprecated APIs
      mmc: tmio: Move away from using deprecated APIs
      mmc: via-sdmmc: Move away from using deprecated APIs
      mmc: mmci: Move away from using deprecated APIs
      mmc: core: Remove deprecated mmc_suspend|resume_host APIs
      MIPS: db1235: Don't use MMC_CLKGATE
      mmc: Don't force card to active state when entering suspend/shutdown
      mmc: core: Remove redundant mmc_power_up|off at runtime callbacks
      mmc: core: Improve runtime PM support during suspend/resume for sd/mmc
      mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume

 arch/mips/configs/db1235_defconfig |    1 -
 drivers/mmc/card/block.c           |    2 -
 drivers/mmc/core/core.c            |  129 ++++++++++++++++--------------------
 drivers/mmc/core/core.h            |    6 +-
 drivers/mmc/core/mmc.c             |  127 +++++++++++++++++++++--------------
 drivers/mmc/core/mmc_ops.c         |   23 +++++--
 drivers/mmc/core/sd.c              |  118 ++++++++++++++++++---------------
 drivers/mmc/core/sdio.c            |   82 +++++++----------------
 drivers/mmc/host/atmel-mci.c       |   61 -----------------
 drivers/mmc/host/au1xmmc.c         |    7 +-
 drivers/mmc/host/bfin_sdh.c        |   12 +---
 drivers/mmc/host/cb710-mmc.c       |   10 +--
 drivers/mmc/host/davinci_mmc.c     |   26 ++------
 drivers/mmc/host/dw_mmc.c          |   21 ------
 drivers/mmc/host/jz4740_mmc.c      |    4 --
 drivers/mmc/host/mmci.c            |   17 ++---
 drivers/mmc/host/msm_sdcc.c        |   27 +-------
 drivers/mmc/host/mvsdio.c          |   29 --------
 drivers/mmc/host/mxcmmc.c          |   12 +---
 drivers/mmc/host/mxs-mmc.c         |   12 +---
 drivers/mmc/host/omap.c            |   53 ---------------
 drivers/mmc/host/omap_hsmmc.c      |   37 +----------
 drivers/mmc/host/pxamci.c          |   32 ---------
 drivers/mmc/host/rtsx_pci_sdmmc.c  |   33 ---------
 drivers/mmc/host/s3cmci.c          |   29 --------
 drivers/mmc/host/sdhci.c           |   20 +-----
 drivers/mmc/host/sdricoh_cs.c      |    3 -
 drivers/mmc/host/sh_mmcif.c        |   10 +--
 drivers/mmc/host/tifm_sd.c         |    4 +-
 drivers/mmc/host/tmio_mmc_pio.c    |    9 +--
 drivers/mmc/host/via-sdmmc.c       |    7 +-
 drivers/mmc/host/vub300.c          |   18 +----
 drivers/mmc/host/wbsd.c            |   33 ++-------
 drivers/mmc/host/wmt-sdmmc.c       |   27 +++-----
 include/linux/mmc/card.h           |    5 ++
 include/linux/mmc/core.h           |    3 +-
 include/linux/mmc/host.h           |    5 +-
 37 files changed, 301 insertions(+), 753 deletions(-)


                           122,1         Bot
