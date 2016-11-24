From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.9 rc7
Date: Thu, 24 Nov 2016 16:04:20 +0100
Message-ID: <CAPDyKFo8gM_KnLtqF08gX1EkQvBS0tvJDK=81Pz1OC3Hd4q0Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:36152 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966118AbcKXPEW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 10:04:22 -0500
Received: by mail-wj0-f169.google.com with SMTP id qp4so35562896wjc.3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2016 07:04:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are some mmc fixes intended for v4.9 rc7. They are based on v4.9-rc5.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.9-rc5

for you to fetch changes up to 647f80a1f233bb66fc58fb25664d029e0f12f3ae:

  mmc: dw_mmc: fix the error handling for dma operation (2016-11-21
11:08:28 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-of-esdhc: Fix card detection
 - dw_mmc: Fix DMA error path

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: fix the error handling for dma operation

Michael Walle (1):
      mmc: sdhci-of-esdhc: fixup PRESENT_STATE read

 drivers/mmc/host/dw_mmc.c         |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
 drivers/mmc/host/sdhci.h          |  1 +
 3 files changed, 16 insertions(+)
