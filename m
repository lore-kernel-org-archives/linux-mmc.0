From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc8
Date: Mon, 30 Oct 2017 11:19:31 +0100
Message-ID: <1509358771-5865-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:51530 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbdJ3KTe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2017 06:19:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id r129so14284486lff.8
        for <linux-mmc@vger.kernel.org>; Mon, 30 Oct 2017 03:19:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit eb701ce16a45ed9880897c48f05ee608d77c72e3:

  mmc: sdhci-pci: Fix default d3_retune for Intel host controllers (2017-10-10 08:40:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-rc4-2

for you to fetch changes up to 48e1dc10a9440872c0fc07a7fbcfce177f996fd4:

  mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c (2017-10-20 11:24:58 +0200)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: fix kernel panic
 - tmio: fix swiotlb buffer is full

----------------------------------------------------------------
Yoshihiro Shimoda (2):
      mmc: tmio: fix swiotlb buffer is full
      mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 17 ++++++++++-------
 drivers/mmc/host/tmio_mmc_core.c              | 13 +++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)
