From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.6 rc3
Date: Sun, 10 Apr 2016 10:50:21 +0200
Message-ID: <CAPDyKFq4ktFrAY__8T5aseah2A2OH9CC3ZLXSOa=75kA0-p4uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35634 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcDJIuX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Apr 2016 04:50:23 -0400
Received: by mail-wm0-f44.google.com with SMTP id 191so55267728wmq.0
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2016 01:50:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are a couple of mmc fixes intended for v4.6 rc3 (or rc4 as I
guess it's late for rc3). It's based on v4.6 rc1.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.6-rc1

for you to fetch changes up to 01d6b2a40a0fa73c90e05b1033f181a51fec9292:

  mmc: sdhci-pci: Add support and PCI IDs for more Broxton host
controllers (2016-04-05 12:14:09 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix regression setting power on Trats2 board
 - sdhci-pci: Add support and PCI IDs for more Broxton host controllers

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: sdhci: Fix regression setting power on Trats2 board
      mmc: sdhci-pci: Add support and PCI IDs for more Broxton host controllers

 drivers/mmc/host/sdhci-pci-core.c | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 drivers/mmc/host/sdhci-pxav3.c    | 22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          | 39 ++++++++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.h          |  4 ++++
 5 files changed, 84 insertions(+), 9 deletions(-)
