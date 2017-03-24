From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.11 rc4
Date: Fri, 24 Mar 2017 10:19:11 +0100
Message-ID: <CAPDyKFrAhummENr6BcwTO6uN8_apjfZfPAuWMBzY1HNnp7A-Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.11 rc4. They are based
on v4.11-rc2.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.11-rc2

for you to fetch changes up to 027fb89e61054b4aedd962adb3e2003dec78a716:

  mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power
(2017-03-23 09:24:42 +0100)

----------------------------------------------------------------
MMC core:
 - Fix initialization of HS400-ES eMMC cards
 - A couple of fixes for the mmc block device driver
 - Resolved a compiler warning

MMC host:
 - sdhci: Do not disable IRQs while waiting for clock
 - sdhci-pci: Do not disable IRQs in sdhci_intel_set_power
 - sdhci-of-arasan: Fix incorrect timeout clock
 - mediatek: Fix bug for setting wrong clock frequency
 - sdhci-of-at91: Use regulator to fix cmd timeout errors
 - ushc: Fix NULL-deref at probe
 - rockchip-dw-mshc: Rename RK1108 to RV1108 in DT

----------------------------------------------------------------
Adrian Hunter (4):
      mmc: block: Fix is_waiting_last_req set incorrectly
      mmc: block: Fix cmd error reset failure path
      mmc: sdhci: Do not disable interrupts while waiting for clock
      mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power

Andy Yan (1):
      dt-bindings: rockchip-dw-mshc: rename RK1108 to RV1108

Anssi Hannula (1):
      mmc: sdhci-of-arasan: fix incorrect timeout clock

Guenter Roeck (1):
      mmc: core: Fix access to HS400-ES devices

Johan Hovold (1):
      mmc: ushc: fix NULL-deref at probe

Romain Izard (1):
      mmc: sdhci-of-at91: Support external regulators

Winkler, Tomas (1):
      mmc: core: mmc_blk_rw_cmd_err - remove unused variable

yong mao (1):
      mmc: mediatek: Fixed bug where clock frequency could be set wrong

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt      |  2 +-
 drivers/mmc/core/block.c                              |  7 +++----
 drivers/mmc/core/mmc.c                                |  2 +-
 drivers/mmc/host/mtk-sd.c                             |  4 ++--
 drivers/mmc/host/sdhci-of-arasan.c                    | 14 +++++---------
 drivers/mmc/host/sdhci-of-at91.c                      | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c                     |  4 ++++
 drivers/mmc/host/sdhci.c                              |  4 +++-
 drivers/mmc/host/ushc.c                               |  3 +++
 9 files changed, 41 insertions(+), 18 deletions(-)
