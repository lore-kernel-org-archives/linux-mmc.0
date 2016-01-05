From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/11] mmc: use sdhci_pltfm_init for private allocation and clean up
Date: Tue, 5 Jan 2016 18:51:28 +0800
Message-ID: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

These patches are to complete the TODO in Commit 0e748234293f ("mmc:
sdhci: Add size for caller in init+register"), I.E:

- todo: migrate clients to using allocation this way
- todo: remove priv variable once migration is complete

Jisheng Zhang (11):
  mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
  mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
  mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
  mmc: sdhci-st: use sdhci_pltfm_init for private allocation
  mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
  mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host

 drivers/mmc/host/sdhci-bcm2835.c   | 14 +++-----------
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 +++++++++++++++++---------------------
 drivers/mmc/host/sdhci-msm.c       | 13 +++++--------
 drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++---------------
 drivers/mmc/host/sdhci-of-at91.c   | 21 ++++++++-------------
 drivers/mmc/host/sdhci-of-esdhc.c  | 17 ++++++++---------
 drivers/mmc/host/sdhci-pltfm.h     |  1 -
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     | 21 +++++++++------------
 drivers/mmc/host/sdhci-st.c        | 36 ++++++++++++++++++------------------
 drivers/mmc/host/sdhci-tegra.c     | 19 ++++++-------------
 11 files changed, 84 insertions(+), 122 deletions(-)

-- 
2.6.4
