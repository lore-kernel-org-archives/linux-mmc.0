From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc4
Date: Fri, 23 Nov 2018 08:25:18 +0100
Message-ID: <20181123072518.2033-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with two MMC fixes intended for v4.20-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc2

for you to fetch changes up to 5305ec6a27b2dc7398a689e661a4a2e951026f09:

  mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning value (2018-11-19 14:11:07 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fixup card detect lookup
 - sdhci-pci: Workaround GLK firmware bug for tuning

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning value

Rajat Jain (1):
      mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL

 drivers/mmc/host/sdhci-pci-core.c | 86 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)
