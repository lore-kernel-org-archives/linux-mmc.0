From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
Date: Thu, 10 Nov 2016 22:24:21 +0900
Message-ID: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Sascha Sommer <saschasommer-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Pierre Ossman <pierre-vCPtPcF4ZGuHXe+LvDLADg@public.gmane.org>, Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel@
List-Id: linux-mmc@vger.kernel.org


sdhci_alloc_host() returns an error pointer when it fails.
but mmc_alloc_host() cannot.

This series allow to propagate a proper error code
when host-allocation fails.



Masahiro Yamada (2):
  mmc: allow mmc_alloc_host() to return proper error code
  mmc: tmio: allow tmio_mmc_host_alloc() to return proper error code

 drivers/mmc/core/host.c             | 11 ++++++-----
 drivers/mmc/host/android-goldfish.c |  4 ++--
 drivers/mmc/host/atmel-mci.c        |  4 ++--
 drivers/mmc/host/au1xmmc.c          |  4 ++--
 drivers/mmc/host/bfin_sdh.c         |  4 ++--
 drivers/mmc/host/cb710-mmc.c        |  4 ++--
 drivers/mmc/host/davinci_mmc.c      |  4 ++--
 drivers/mmc/host/dw_mmc.c           |  4 ++--
 drivers/mmc/host/jz4740_mmc.c       |  4 ++--
 drivers/mmc/host/mmc_spi.c          |  9 ++++++---
 drivers/mmc/host/mmci.c             |  4 ++--
 drivers/mmc/host/moxart-mmc.c       |  4 ++--
 drivers/mmc/host/mtk-sd.c           |  4 ++--
 drivers/mmc/host/mvsdio.c           |  4 ++--
 drivers/mmc/host/mxcmmc.c           |  4 ++--
 drivers/mmc/host/mxs-mmc.c          |  4 ++--
 drivers/mmc/host/omap.c             |  4 ++--
 drivers/mmc/host/omap_hsmmc.c       |  4 ++--
 drivers/mmc/host/pxamci.c           |  4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c   |  4 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c   |  4 ++--
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  4 ++--
 drivers/mmc/host/sdricoh_cs.c       |  4 ++--
 drivers/mmc/host/sh_mmcif.c         |  4 ++--
 drivers/mmc/host/sh_mobile_sdhi.c   |  4 ++--
 drivers/mmc/host/sunxi-mmc.c        |  4 ++--
 drivers/mmc/host/tifm_sd.c          |  4 ++--
 drivers/mmc/host/tmio_mmc.c         |  4 +++-
 drivers/mmc/host/tmio_mmc_pio.c     |  4 ++--
 drivers/mmc/host/toshsd.c           |  4 ++--
 drivers/mmc/host/usdhi6rol0.c       |  4 ++--
 drivers/mmc/host/ushc.c             |  4 ++--
 drivers/mmc/host/via-sdmmc.c        |  4 ++--
 drivers/mmc/host/vub300.c           |  4 ++--
 drivers/mmc/host/wbsd.c             |  4 ++--
 drivers/mmc/host/wmt-sdmmc.c        |  4 ++--
 drivers/staging/greybus/sdio.c      |  4 ++--
 38 files changed, 85 insertions(+), 79 deletions(-)

-- 
1.9.1
