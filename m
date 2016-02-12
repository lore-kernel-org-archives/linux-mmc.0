From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.5 rc4
Date: Fri, 12 Feb 2016 13:38:26 +0100
Message-ID: <CAPDyKFocsaFabaRRSD0XPg68EBPY2JAfnOUjmmtBODN7NoKr+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35972 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbcBLMi1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 07:38:27 -0500
Received: by mail-yw0-f181.google.com with SMTP id q190so63271825ywd.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2016 04:38:26 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are some mmc fixes intended for v4.5 rc4. These are based on v4.5 rc2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.5-rc2

for you to fetch changes up to a5ebb87db84392edfd3142c3a6a78431d820a789:

  Revert "mmc: block: don't use parameter prefix if built as module"
(2016-02-11 16:49:35 +0100)

----------------------------------------------------------------
MMC core:
 - Fix an sysfs ABI regression
 - Return an error in a specific error path dealing with mmc ioctls

MMM host:
 - sdhci-pci|acpi: Fix card detect race for Intel BXT/APL
 - sh_mmcif: Correct TX DMA channel allocation
 - mmc_spi: Fix error handling for dma mapping errors
 - sdhci-of-at91: Fix an unbalance issue for the runtime PM usage count
 - pxamci: Fix the device-tree probe deferral path
 - pxamci: Fix read-only GPIO polarity

----------------------------------------------------------------
Adrian Hunter (4):
      mmc: sdhci: Allow override of mmc host operations
      mmc: sdhci: Allow override of get_cd() called from sdhci_request()
      mmc: sdhci-pci: Fix card detect race for Intel BXT/APL
      mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL

Alexey Khoroshilov (1):
      mmc: mmc_spi: add checks for dma mapping error

Chris Paterson (1):
      mmc: sh_mmcif: Correct TX DMA channel allocation

Jisheng Zhang (1):
      mmc: sdhci-of-at91: fix pm runtime unbalanced issue in error path

Olof Johansson (1):
      mmc: block: return error on failed mmc_blk_get()

Robert Jarzmik (2):
      mmc: pxamci: fix again read-only gpio detection polarity
      mmc: pxamci: fix the device-tree probe deferral path

Ulf Hansson (1):
      Revert "mmc: block: don't use parameter prefix if built as module"

 drivers/mmc/card/block.c          |  7 +++----
 drivers/mmc/host/mmc_spi.c        | 15 +++++++++++++--
 drivers/mmc/host/pxamci.c         | 37 ++++++++++---------------------------
 drivers/mmc/host/sdhci-acpi.c     | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-at91.c  |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 31 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  5 +++--
 drivers/mmc/host/sdhci.h          |  1 +
 drivers/mmc/host/sh_mmcif.c       |  2 +-
