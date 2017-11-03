From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc8 take 2
Date: Fri,  3 Nov 2017 08:15:34 +0100
Message-ID: <1509693334-23331-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:47610 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdKCHPj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Nov 2017 03:15:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id k40so2051854lfi.4
        for <linux-mmc@vger.kernel.org>; Fri, 03 Nov 2017 00:15:39 -0700 (PDT)
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


The following changes since commit 48e1dc10a9440872c0fc07a7fbcfce177f996fd4:

  mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c (2017-10-20 11:24:58 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-rc4-3

for you to fetch changes up to 9d9491a7da2a4ce9fed32bd8611992ea3471523a:

  mmc: dw_mmc: Fix the DTO timeout calculation (2017-11-01 15:13:45 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Fix request timeout issues

----------------------------------------------------------------
Douglas Anderson (4):
      mmc: dw_mmc: cancel the CTO timer after a voltage switch
      mmc: dw_mmc: Fix the CTO timeout calculation
      mmc: dw_mmc: Add locking to the CTO timer
      mmc: dw_mmc: Fix the DTO timeout calculation

 drivers/mmc/host/dw_mmc.c | 107 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 13 deletions(-)
