From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] MMC fixes for v5.2-rc6
Date: Thu, 20 Jun 2019 13:16:02 +0200
Message-ID: <20190620111602.17958-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with quite a few MMC fixes intended for v5.2-rc6. This time the PR
also contains fixes for a WiFi driver, which device is attached to the SDIO
interface. Patches for the WiFi driver have been acked by the corresponding
maintainers. More details about the highlights are as usual found in the signed
tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc4

for you to fetch changes up to 83293386bc95cf5e9f0c0175794455835bd1cb4a:

  mmc: core: Prevent processing SDIO IRQs when the card is suspended (2019-06-18 14:06:32 +0200)

----------------------------------------------------------------
MMC core:
 - Make switch to eMMC HS400 more robust for some controllers
 - Add two SDIO func API to manage re-tuning constraints
 - Prevent processing SDIO IRQs when the card is suspended

MMC host:
 - sdhi: Disallow broken HS400 for M3-W ES1.2, RZ/G2M and V3H
 - mtk-sd: Fixup support for SDIO IRQs
 - sdhci-pci-o2micro: Fixup support for tuning

Wireless BRCMFMAC (SDIO):
 - Deal with expected transmission errors related to the idle states
   (handled by the Always-On-Subsystem or AOS) on the SDIO-based WiFi on
   rk3288-veyron-minnie, rk3288-veyron-speedy and rk3288-veyron-mickey.

----------------------------------------------------------------
Douglas Anderson (5):
      Revert "brcmfmac: disable command decode in sdio_aos"
      mmc: core: API to temporarily disable retuning for SDIO CRC errors
      brcmfmac: sdio: Disable auto-tuning around commands expected to fail
      mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
      brcmfmac: sdio: Don't tune while the card is off

Raul E Rangel (1):
      mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning

Ulf Hansson (1):
      mmc: core: Prevent processing SDIO IRQs when the card is suspended

Wolfram Sang (2):
      mmc: sdhi: disallow HS400 for M3-W ES1.2, RZ/G2M, and V3H
      mmc: core: complete HS400 before checking status

jjian zhou (2):
      mmc: mediatek: fix SDIO IRQ interrupt handle flow
      mmc: mediatek: fix SDIO IRQ detection issue

 drivers/mmc/core/core.c                            |  5 +-
 drivers/mmc/core/mmc.c                             |  6 +-
 drivers/mmc/core/sdio.c                            | 13 +++-
 drivers/mmc/core/sdio_io.c                         | 77 ++++++++++++++++++++++
 drivers/mmc/core/sdio_irq.c                        |  4 ++
 drivers/mmc/host/mtk-sd.c                          | 39 ++++++-----
 drivers/mmc/host/renesas_sdhi_core.c               |  9 ++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 17 +++--
 include/linux/mmc/host.h                           |  1 +
 include/linux/mmc/sdio_func.h                      |  6 ++
 11 files changed, 151 insertions(+), 31 deletions(-)
