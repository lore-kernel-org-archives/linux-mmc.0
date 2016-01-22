From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.5 rc1
Date: Fri, 22 Jan 2016 15:24:02 +0100
Message-ID: <CAPDyKFpR0HQ7dPkigSwSawPKosCA-9TKUxf=LKwWH9WcD4p39A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33133 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbcAVOYD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2016 09:24:03 -0500
Received: by mail-yk0-f179.google.com with SMTP id k129so88167729yke.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2016 06:24:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here are some mmc fixes intended for v4.5 rc1. These are based on a
commit earlier in the merge window but has been tested a while in
linux-next via my next branch.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 67990608c8b95d2b8ccc29932376ae73d5818727:

  Merge tag 'pm+acpi-4.5-rc1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
(2016-01-12 20:25:09 -0800)

are available in the git repository at:


  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.5-rc1

for you to fetch changes up to 64a67d4762ce3ce4c9466eadd152d825fbf84967:

  mmc: pwrseq_simple: Make reset-gpios optional to match doc
(2016-01-21 13:52:27 +0100)

----------------------------------------------------------------
MMC core:
 - Restore reset-gpios to be optional in pwrseq_simple
 - Allow SDIO tuple for CISTPL_SDIO_STD
 - Print correct voltage value in debugfs
 - Enable tuning according to the actual timing
 - Limit SD card power limit according to cards capabilities

MMC host:
 - tmio_mmc_dma: don't print invalid DMA cookie
 - mmci: Pick the correct variant and allow 8-bit mode for Nomadik

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: tmio_mmc_dma: don't print invalid DMA cookie

Carlo Caione (1):
      mmc: core: Enable tuning according to the actual timing

Chuanxiao Dong (1):
      mmc: debugfs: correct wrong voltage value

Linus Walleij (2):
      mmc: mmci: fix an ages old detection error
      mmc: mmci: support 8bit mode on the Nomadik

Martin Fuzzey (1):
      mmc: pwrseq_simple: Make reset-gpios optional to match doc

Russell King (1):
      mmc: sd: limit SD card power limit according to cards capabilities

Shawn Lin (1):
      mmc: sdio_cis: fix unknown tuple for CISTPL_SDIO_STD

drivers/mmc/core/debugfs.c       |  2 +-
 drivers/mmc/core/pwrseq_simple.c | 22 ++++++++++++++--------
 drivers/mmc/core/sd.c            | 28 ++++++++++++++++++++--------
 drivers/mmc/core/sdio.c          |  4 ++--
 drivers/mmc/core/sdio_cis.c      |  1 +
 drivers/mmc/host/mmci.c          |  3 ++-
 drivers/mmc/host/tmio_mmc_dma.c  | 15 +++++++--------
 7 files changed, 47 insertions(+), 28 deletions(-)
