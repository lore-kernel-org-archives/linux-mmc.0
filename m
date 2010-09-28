From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/6] Add driver for mx35/51-esdhc-controller (and update sdhci for that)
Date: Tue, 28 Sep 2010 14:36:40 +0200
Message-ID: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab0I1MhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:37:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

Okay, here is the next version of my patch series. The first four are
updates/improvements for sdhci and sdhci-pltfm and are of generic interest,
too. There were a few people asking for them, so I hope they will now donate
some Acked-by/Tested-by tags. Changes from the previous version are mentioned
in the seperate files. The corresponding branch can be found here:

git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

Patches are placed on top of mmc-next as of today.

Thanks,

   Wolfram

Wolfram Sang (6):
  mmc: sdhci-pltfm: Add structure for host-specific data
  mmc: sdhci-pltfm: move .h-file into apropriate subdir
  mmc: sdhci: introduce private get_ro
  mmc: sdhci_pltfm: pass platform_data on custom init-call
  mmc: sdhci-of-esdhc: factor out common stuff
  mmc: sdhci-pltfm: add pltfm-driver for imx35/51

 drivers/mmc/host/Kconfig           |   10 +++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |  144 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h     |   81 ++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c  |   70 ++---------------
 drivers/mmc/host/sdhci-pltfm.c     |   23 ++++--
 drivers/mmc/host/sdhci-pltfm.h     |    9 ++-
 drivers/mmc/host/sdhci.c           |   11 ++-
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/sdhci-pltfm.h    |   36 +++++++++
 include/linux/sdhci-pltfm.h        |   35 ---------
 12 files changed, 314 insertions(+), 109 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
 create mode 100644 drivers/mmc/host/sdhci-esdhc.h
 create mode 100644 include/linux/mmc/sdhci-pltfm.h
 delete mode 100644 include/linux/sdhci-pltfm.h

