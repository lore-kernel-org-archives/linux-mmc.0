From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 00/12] mmc: use sdhci_pltfm_init for private allocation and clean up
Date: Wed, 6 Jan 2016 11:55:53 +0800
Message-ID: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:65157 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935AbcAFEA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2016 23:00:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

These patches are to complete the TODOs in Commit 0e748234293f ("mmc:
sdhci: Add size for caller in init+register"), I.E:

- todo: migrate clients to using allocation this way
- todo: remove priv variable once migration is complete

Since v1:
 - add new patch03 to factorise sdhci_msm_pdata outisde of sdhci_msm_host.
   This is to fix drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host'
   is used uninitialized in this function [-Wuninitialized]
 - Add Arnd's Ack for all patches except patch3 which is new in v2

Jisheng Zhang (12):
  mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
  mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
  mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
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
 drivers/mmc/host/sdhci-msm.c       | 24 +++++++++++-------------
 drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++---------------
 drivers/mmc/host/sdhci-of-at91.c   | 21 ++++++++-------------
 drivers/mmc/host/sdhci-of-esdhc.c  | 17 ++++++++---------
 drivers/mmc/host/sdhci-pltfm.h     |  1 -
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     | 21 +++++++++------------
 drivers/mmc/host/sdhci-st.c        | 36 ++++++++++++++++++------------------
 drivers/mmc/host/sdhci-tegra.c     | 19 ++++++-------------
 11 files changed, 90 insertions(+), 127 deletions(-)

-- 
2.7.0.rc3

