From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.11 rc5
Date: Fri, 31 Mar 2017 14:12:06 +0200
Message-ID: <CAPDyKFpcZh0rNfZFUd3S_dh-8gimuZxSxvPLqzVtD3UU6da69w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33922 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbdCaMMI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2017 08:12:08 -0400
Received: by mail-vk0-f46.google.com with SMTP id z204so88484932vkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2017 05:12:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are a couple of mmc fixes intended for v4.11 rc5. They are based
on v4.11-rc4.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c02ed2e75ef4c74e41e421acb4ef1494671585e8:

  Linux 4.11-rc4 (2017-03-26 14:15:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.11-rc4

for you to fetch changes up to d0918764c17b94c30bbb2619929b1719ff52707a:

  mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection (2017-03-30
21:10:29 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix bug when using SDIO IRQ
 - sdhci-of-at91: Fix eMMC DDR52 card detection

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci: Disable runtime pm when the sdio_irq is enabled

Ludovic Desroches (1):
      mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection

 drivers/mmc/host/sdhci-of-at91.c | 11 ++++++++++-
 drivers/mmc/host/sdhci.c         |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
