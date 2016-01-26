From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 00/13] mmc: use sdhci_pltfm_init for private allocation and clean up
Date: Tue, 26 Jan 2016 18:15:40 +0800
Message-ID: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

These patches are to complete the TODOs in Commit 0e748234293f ("mmc:
sdhci: Add size for caller in init+register"), I.E:

- todo: migrate clients to using allocation this way
- todo: remove priv variable once migration is complete

Since v3:
 - based on v4.5-rc1
 - add Ludovic's ack for sdhci-of-at91 changes
 - fix use-after-free in some drivers: some host drivers still needs to
   access sdhci_pltfm_host->private after sdhci_pltfm_unregister(), but
   the private should be already freed by sdhci_pltfm_unregister.
 - add patch5 to fix one clk bug in sdhci_arasan_remove(). IMHO, It's
   better to add this patch to fixes rather than waiting for next merge
   window

Since v2:
 - based on mmc next tree and remove all priv usage introduced in newly
   commits in this tree
 - don't break two lines if sdhci_pltfm_init() call could be put into
   one line. Thank Ludovic Desroches.

Since v1:
 - add new patch03 to factorise sdhci_msm_pdata outisde of sdhci_msm_host.
   This is to fix drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host'
   is used uninitialized in this function [-Wuninitialized]
 - Add Arnd's Ack for all patches except patch3 which is new in v2


Jisheng Zhang (13):
  mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
  mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
  mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
  mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()
  mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
  mmc: sdhci-st: use sdhci_pltfm_init for private allocation
  mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
  mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host

 drivers/mmc/host/sdhci-bcm2835.c   | 14 +++----------
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++--------------------
 drivers/mmc/host/sdhci-msm.c       | 25 +++++++++++-------------
 drivers/mmc/host/sdhci-of-arasan.c | 33 +++++++++++++++----------------
 drivers/mmc/host/sdhci-of-at91.c   | 33 ++++++++++++++-----------------
 drivers/mmc/host/sdhci-of-esdhc.c  | 19 +++++++++---------
 drivers/mmc/host/sdhci-pltfm.h     |  1 -
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     | 20 ++++++++-----------
 drivers/mmc/host/sdhci-st.c        | 40 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci-tegra.c     | 21 +++++++-------------
 11 files changed, 106 insertions(+), 139 deletions(-)

-- 
2.7.0
