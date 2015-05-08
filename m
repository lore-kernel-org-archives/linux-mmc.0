From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.1 rc3
Date: Fri, 8 May 2015 09:23:22 +0200
Message-ID: <CAPDyKFqtYHORQxXZQ5bhC0gm0=Y_4iRq=fJwuxs7u8d3GTaqLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35223 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbEHHXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 03:23:23 -0400
Received: by qkhg7 with SMTP id g7so43069245qkh.2
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 00:23:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Here are some mmc fixes for v.4.1 rc3, based on v4.1-rc2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-4.1-rc2

for you to fetch changes up to 4de3bf66c61ef708d8f22d7f990339668a858e7d:

  mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE (2015-05-08
08:55:47 +0200)

----------------------------------------------------------------
MMC core:
- Don't access RPMB partitions for normal read/write
- Fix hibernation restore sequence

MMC host:
- dw_mmc: Fix card detection for non removable cards
- dw_mmc: Fix sglist issue in 32-bit mode
- sh_mmcif: Fix timeout value for command request

----------------------------------------------------------------
Chuanxiao Dong (1):
      mmc: card: Don't access RPMB partitions for normal read/write

Grygorii Strashko (1):
      mmc: core: add missing pm event in mmc_pm_notify to fix hib restore

Takeshi Kihara (1):
      mmc: sh_mmcif: Fix timeout value for command request

Zhangfei Gao (2):
      mmc: dw_mmc: init desc in dw_mci_idmac_init
      mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE

 drivers/mmc/card/block.c    | 12 ++++++++++++
 drivers/mmc/card/queue.c    |  2 +-
 drivers/mmc/card/queue.h    |  2 ++
 drivers/mmc/core/core.c     |  1 +
 drivers/mmc/host/dw_mmc.c   |  7 +++++--
 drivers/mmc/host/sh_mmcif.c |  2 +-
 6 files changed, 22 insertions(+), 4 deletions(-)
