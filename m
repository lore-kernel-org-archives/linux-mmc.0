From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc5
Date: Tue, 17 Jan 2017 16:21:16 +0100
Message-ID: <CAPDyKFpwij4TBydjm33fCpd05vuc3pSP8wGqhejG7cbTqNcMuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37895 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdAQP1f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:27:35 -0500
Received: by mail-wm0-f53.google.com with SMTP id r144so227732339wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:27:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>

Hi Linus,

Here are some mmc fixes intended for v4.9 rc5. They are based on v4.9-rc3.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-rc3

for you to fetch changes up to ee6ff743e3a4b697e8286054667d7e4e1b56510d:

  mmc: core: Restore parts of the polling policy when switch to HS/HS
DDR (2017-01-16 16:17:42 +0100)

----------------------------------------------------------------
MMC core:
 - Fix regressions detecting HS/HS DDR eMMC cards related to CMD6

MMC host:
 - mmc: mxs-mmc: Fix additional cycles after transmission stop
 - sdhci-acpi: Only powered up enabled acpi child devices
 - meson: avoid possible NULL dereference

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci-acpi: Only powered up enabled acpi child devices

Heinrich Schuchardt (1):
      MMC: meson: avoid possible NULL dereference

Stefan Wahren (1):
      mmc: mxs-mmc: Fix additional cycles after transmission stop

Ulf Hansson (1):
      mmc: core: Restore parts of the polling policy when switch to HS/HS DDR

 drivers/mmc/core/mmc_ops.c      | 25 ++++++++++++-------------
 drivers/mmc/host/meson-gx-mmc.c |  8 +++++---
 drivers/mmc/host/mxs-mmc.c      |  6 ++++--
 drivers/mmc/host/sdhci-acpi.c   |  3 ++-
 4 files changed, 23 insertions(+), 19 deletions(-)
