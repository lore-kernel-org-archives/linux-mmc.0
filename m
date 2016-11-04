From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.9 rc4
Date: Fri, 4 Nov 2016 18:45:23 +0100
Message-ID: <CAPDyKFpsd5nie+NOnucfU0aYFWoRA3b72jNEORw6XG5A6qnDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35973 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935270AbcKDRp0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 13:45:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id p190so66014617wmp.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 10:45:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are some mmc fixes intended for v4.9 rc4. They are based on v4.9-rc2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.9-rc2

for you to fetch changes up to d1f63f0c81c22ba705fcd149a1fcec37b734d818:

  mmc: sdhci-msm: Fix error return code in sdhci_msm_probe()
(2016-10-27 09:43:01 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-msm: Fix error path in probe
 - dw_mmc-pltfm: Avoid NULL pointer dereference

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc-pltfm: fix the potential NULL pointer dereference

Wei Yongjun (1):
      mmc: sdhci-msm: Fix error return code in sdhci_msm_probe()

 drivers/mmc/host/dw_mmc-pltfm.c | 5 +++--
 drivers/mmc/host/sdhci-msm.c    | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
