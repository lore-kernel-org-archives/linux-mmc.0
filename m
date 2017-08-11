From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc5
Date: Fri, 11 Aug 2017 16:26:29 +0200
Message-ID: <CAPDyKFp1VRx_Zo_n7N93CkuCmRbA_Z-tvfqHbsvXztWp=Vo8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:37838 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbdHKO0a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2017 10:26:30 -0400
Received: by mail-qk0-f177.google.com with SMTP id z18so21111139qka.4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2017 07:26:30 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Linus,

Here are a couple of mmc fixes intended for v4.13-rc5.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e=
:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13=
-rc4

for you to fetch changes up to 3f8b23a09a87aa65df3e13129cb2d9cffcb394db:

  mmc: block: fix lockdep splat when removing mmc_block module
(2017-08-09 13:19:44 +0200)

----------------------------------------------------------------
MMC core:
 - Fix lockdep splat when removing mmc_block module
 - Fix the logic for setting eMMC HS400ES signal voltage
MMC host:
 - omap_hsmmc: Add CMD23 capability to fix -EIO errors

----------------------------------------------------------------
Haibo Chen (1):
      mmc: mmc: correct the logic for setting HS400ES signal voltage

Kishon Vijay Abraham I (1):
      mmc: host: omap_hsmmc: Add CMD23 capability to omap_hsmmc driver

Micha=C5=82 Miros=C5=82aw (1):
      mmc: block: fix lockdep splat when removing mmc_block module

 drivers/mmc/core/block.c      | 2 ++
 drivers/mmc/core/mmc.c        | 2 +-
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
