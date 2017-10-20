From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc6
Date: Fri, 20 Oct 2017 10:25:07 +0200
Message-ID: <1508487907-3946-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:48500 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdJTIZK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 04:25:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id a69so12330943lfe.5
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 01:25:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's a PR with a MMC fix intended for v4.14-rc6. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-rc4

for you to fetch changes up to eb701ce16a45ed9880897c48f05ee608d77c72e3:

  mmc: sdhci-pci: Fix default d3_retune for Intel host controllers (2017-10-10 08:40:04 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fix default d3_retune for Intel host controllers

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix default d3_retune for Intel host controllers

 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 1 file changed, 2 insertions(+)
