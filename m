From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.9 rc2
Date: Thu, 20 Oct 2016 12:33:24 +0200
Message-ID: <CAPDyKFqGsbkwayk-PcAhcx+=EopCAHFfokQLJXDp+wX49ZOPkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34744 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755999AbcJTKd0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 06:33:26 -0400
Received: by mail-qk0-f169.google.com with SMTP id f128so81887011qkb.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 03:33:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ritesh Raj Sarraf <rrs@researchut.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here are some mmc fixes intended for v4.9 rc2. They are based on a
commit during the merge window and has been tested a while on top of
v4.9-rc1, via my next branch.

This time I have also included a few changes for a memstick driver
which has a corresponding mmc driver. They use the same USB device as
parent, hence both needs to play nice with runtime PM, which they
didn't.

Unfortunate, the memstick driver didn't have a maintainer, so I
couldn't receive an ack of the changes for it.

More details can as usual be found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 24532f768121b07b16178ffb40442ece43365cbd:

  Merge branch 'for-4.9/block-smp' of git://git.kernel.dk/linux-block
(2016-10-09 17:32:20 -0700)

are available in the git repository at:


  http://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.9-rc1

for you to fetch changes up to 82bb095ee9dcd9380b6ab608b5fa9f64e65f3a3b:

  MAINTAINERS: mmc: Move the mmc tree to kernel.org (2016-10-17 15:46:05 +0200)

----------------------------------------------------------------
MMC core:
 - Update MAINTAINERS as the mmc tree moved to kernel.org
 - A few fixes for HS400es mode
 - A few other minor fixes

MMC host:
 - sdhci: Fix an issue when dealing with stop commands
 - sdhci-pci: Fix a bus power failure issue
 - sdhci-esdhc-imx: Correct two register accesses
 - sdhci-of-arasan: Fix the 1.8V I/O signal switch behaviour
 - rtsx_usb_sdmmc: Fix runtime PM issues

Other: (Because of no maintainer)
 - memstick: rtsx_usb_ms: Fix runtime PM issues

----------------------------------------------------------------
Aaron Brice (1):
      mmc: sdhci-esdhc-imx: Correct two register accesses

Adrian Hunter (4):
      mmc: sdhci: Fix SDHCI_QUIRK2_STOP_WITH_TC
      mmc: sdhci: Rename sdhci_set_power() to sdhci_set_power_noreg()
      mmc: sdhci-pci: Let devices define their own sdhci_ops
      mmc: sdhci-pci: Fix bus power failing to enable for some Intel controllers

Alan Stern (1):
      memstick: rtsx_usb_ms: Runtime resume the device when polling for cards

Baoyou Xie (1):
      mmc: block: add missing header dependencies

Haibo Chen (1):
      mmc: sdhci: cast unsigned int to unsigned long long to avoid
unexpeted error

Jiri Slaby (1):
      mmc: core: Annotate cmd_hdr as __le32

Shawn Lin (3):
      mmc: core: switch to 1V8 or 1V2 for hs400es mode
      mmc: core: changes frequency to hs_max_dtr when selecting hs400es
      mmc: sdhci-of-arasan: add sdhci_arasan_voltage_switch for arasan, 5.1

Ulf Hansson (4):
      mmc: rtsx_usb_sdmmc: Avoid keeping the device runtime resumed when unused
      mmc: rtsx_usb_sdmmc: Handle runtime PM while changing the led
      memstick: rtsx_usb_ms: Manage runtime PM when accessing the device
      MAINTAINERS: mmc: Move the mmc tree to kernel.org

Wei Yongjun (1):
      mmc: sdhci-of-arasan: Fix non static symbol warning

 MAINTAINERS                         |  2 +-
 drivers/memstick/host/rtsx_usb_ms.c |  6 +++++
 drivers/mmc/card/block.c            |  3 ++-
 drivers/mmc/card/queue.h            |  2 +-
 drivers/mmc/core/mmc.c              | 12 +++++++++
 drivers/mmc/host/rtsx_usb_sdmmc.c   |  7 ++---
 drivers/mmc/host/sdhci-esdhc-imx.c  | 23 +++++++++++++++-
 drivers/mmc/host/sdhci-of-arasan.c  | 26 +++++++++++++++++-
 drivers/mmc/host/sdhci-pci-core.c   | 54 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.h        |  2 ++
 drivers/mmc/host/sdhci-pxav3.c      |  2 +-
 drivers/mmc/host/sdhci.c            | 42 ++++++++++++++---------------
 drivers/mmc/host/sdhci.h            |  2 ++
 13 files changed, 149 insertions(+), 34 deletions(-)
