From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Wed, 27 Jan 2016 13:04:03 +0800
Message-ID: <1453871043-2985-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45042 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbcA0FIz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:08:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Ulf wants to make sdhci into a library, but it's a huge task
since any improvemts may touch too much platforms. But at least
we should make some effort to push things torwards to this target.

This patchset remove SDHCI_QUIRK_BROKEN_CARD_DETECTION from sdhci
to gradually reduce quirk of sdhci.

Firstly, SDHCI_QUIRK_BROKEN_CARD_DETECTION aims at claiming the slot is
a "broken-cd" one, but "broken-cd" is not a quirk from my view.
In addition, mmc core stack had already obtain "broken-cd" from dts via
mmc_of_parse and pass MMC_CAP_NEEDS_POLL to mmc->caps. So we can reuse it
instead of SDHCI_QUIRK_BROKEN_CARD_DETECTION.

However, before doing the cleanup work, I find that geting _of_ property
for sdhci* is not so pretty good and consistent. Some variant drives use
mmc_of_parse, while another ones use sdhci_get_of_property. I also find some
variant drivers combine these two paths. So in order to make my "broken-cd"
cleanup running, I decide to add mmc_of_parse into sdhci_get_of_property and
replace mmc_of_parse with sdhci_get_of_property for all variant drivers if
needed.

Unfortunately, I don't have all these platforms touched to test my patchset.
I might make some mistakes for these changes, so any comments are welcomed.



Shawn Lin (21):
  mmc: sdhci-pltfm: consolidate parsing path
  mmc: sdhci-iproc: consolidate parsing path
  mmc: sdhci-msm: consolidate parsing path
  mmc: sdhci-of-arasan: consolidate parsing path
  mmc: sdhci-of-at91: consolidate parsing path
  mmc: sdhci-of-esdhc: consolidate parsing path
  mmc: sdhci-pxav3: consolidate parsing path
  mmc: sdhci-sirf: check sdhci_get_of_property return value
  mmc: sdhci_f_sdh30: check sdhci_get_of_property return value
  mmc: sdhci: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-acpi: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-bcm-kona: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-bcm2835: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-msm: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-of-esdhc: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-pci-core: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-pltfm: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-pxav2: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-s3c: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci.h: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION

 drivers/mmc/host/sdhci-acpi.c      |  3 +--
 drivers/mmc/host/sdhci-bcm-kona.c  |  3 ---
 drivers/mmc/host/sdhci-bcm2835.c   |  5 +++--
 drivers/mmc/host/sdhci-esdhc-imx.c |  9 +++++----
 drivers/mmc/host/sdhci-iproc.c     |  5 +++--
 drivers/mmc/host/sdhci-msm.c       |  6 ++----
 drivers/mmc/host/sdhci-of-arasan.c | 11 ++++-------
 drivers/mmc/host/sdhci-of-at91.c   |  4 +---
 drivers/mmc/host/sdhci-of-esdhc.c  | 25 ++++++++++++-------------
 drivers/mmc/host/sdhci-pci-core.c  |  5 ++++-
 drivers/mmc/host/sdhci-pltfm.c     | 26 +++++++++++++++++++-------
 drivers/mmc/host/sdhci-pltfm.h     |  2 +-
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     |  4 +---
 drivers/mmc/host/sdhci-s3c.c       |  2 +-
 drivers/mmc/host/sdhci-sirf.c      |  4 +++-
 drivers/mmc/host/sdhci.c           | 14 +++++---------
 drivers/mmc/host/sdhci.h           | 30 ++++++++++++++----------------
 drivers/mmc/host/sdhci_f_sdh30.c   |  5 ++++-
 19 files changed, 83 insertions(+), 81 deletions(-)

-- 
2.3.7


