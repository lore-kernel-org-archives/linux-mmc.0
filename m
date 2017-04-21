From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.11 rc8
Date: Fri, 21 Apr 2017 10:55:56 +0200
Message-ID: <CAPDyKFoMLeT3eYgdpxEGETdimCNsZvP6hN2FcO1GHTN_OOZ=Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36817 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036286AbdDUIz5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Apr 2017 04:55:57 -0400
Received: by mail-qt0-f181.google.com with SMTP id g60so64936766qtd.3
        for <linux-mmc@vger.kernel.org>; Fri, 21 Apr 2017 01:55:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here are a couple of mmc fixes intended for v4.11 rc8. They are based
on v4.11-rc7.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4f7d029b9bf009fbee76bb10c0c4351a1870d2f3:

  Linux 4.11-rc7 (2017-04-16 13:00:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.11-rc7

for you to fetch changes up to 9f327845358d3dd0d8a5a7a5436b0aa5c432e757:

  mmc: sdhci-esdhc-imx: increase the pad I/O drive strength for DDR50
card (2017-04-20 14:41:05 +0200)

----------------------------------------------------------------
MMC core:
 - kmalloc sdio scratch buffer to make it DMA-friendly

MMC host:
 - dw_mmc: Fix behaviour for SDIO IRQs when runtime PM is used
 - sdhci-esdhc-imx: Correct pad I/O drive strength for UHS-DDR50 cards

----------------------------------------------------------------
Douglas Anderson (1):
      mmc: dw_mmc: Don't allow Runtime PM for SDIO cards

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: increase the pad I/O drive strength for DDR50 card

Heiner Kallweit (1):
      mmc: sdio: fix alignment issue in struct sdio_func

 drivers/mmc/core/sdio_bus.c        | 12 +++++++++++-
 drivers/mmc/host/dw_mmc.c          | 11 +++++++++--
 drivers/mmc/host/sdhci-esdhc-imx.c |  1 +
 include/linux/mmc/sdio_func.h      |  2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)
