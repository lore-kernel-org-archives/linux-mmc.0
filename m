From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc4
Date: Fri, 4 Aug 2017 10:24:34 +0200
Message-ID: <CAPDyKFoDbOvk2kDjE78g+ivgekLMDBAYLAfzX_F-45Vb47_rqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.13-rc4.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13-rc3

for you to fetch changes up to 7c84b8b43d3d550fa6f0b57277d03f2e1bafb357:

  mmc: block: bypass the queue even if usage is present for hotplug
(2017-08-03 11:00:39 +0200)

----------------------------------------------------------------
MMC core:
 - Fix NULL pointer dereference for block I/O during hotplug
MMC host:
 - sdhci-of-at91: Fix card detect for non-removable cards

----------------------------------------------------------------
Ludovic Desroches (1):
      mmc: sdhci-of-at91: force card detect value for non removable devices

Shawn Lin (1):
      mmc: block: bypass the queue even if usage is present for hotplug

 drivers/mmc/core/block.c         |  1 +
 drivers/mmc/host/sdhci-of-at91.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)
