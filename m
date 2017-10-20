From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] mmc: renesas_sdhi and tmio: bugfixes for v4.14
Date: Fri, 20 Oct 2017 12:12:40 +0900
Message-ID: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch set is based on mainline v4.14-rc5.

Changes from v1:
 - Calculate the max size of swiotlb memory instead of hardcoded value
   in patch 1.
 - Add Reviewed-by from Geert-san in patch 2. (Geert-san, thanks!)

Yoshihiro Shimoda (2):
  mmc: tmio: fix swiotlb buffer is full
  mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 17 ++++++++++-------
 drivers/mmc/host/tmio_mmc_core.c              | 13 +++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.9.1
