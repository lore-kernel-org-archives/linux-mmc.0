From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH V5 0/6] SD/MMC driver for MX25/35/51
Date: Fri, 15 Oct 2010 12:20:58 +0200
Message-ID: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58910 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0JOKVT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 06:21:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Another try. The driver seems to be known by now and used already :) Minor
fixes only:

3/6: Rename a variable (found while working on write-protect-pin support)
5/6: Tested the checkpatch fixes
6/6: Added Kconfig dependencies

The series is based on mmc-next as of today and also available at

	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

Thanks,

   Wolfram

Wolfram Sang (6):
  mmc: sdhci-pltfm: Add structure for host-specific data
  mmc: sdhci-pltfm: move .h-file into apropriate subdir
  mmc: sdhci: introduce private get_ro
  mmc: sdhci_pltfm: pass more data on custom init-call
  mmc: sdhci-of-esdhc: factor out common stuff
  mmc: sdhci-pltfm: add pltfm-driver for imx35/51

 drivers/mmc/host/Kconfig           |   10 +++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |  143 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h     |   83 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c  |   70 ++----------------
 drivers/mmc/host/sdhci-pltfm.c     |   23 ++++--
 drivers/mmc/host/sdhci-pltfm.h     |   10 ++-
 drivers/mmc/host/sdhci.c           |   15 ++--
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/sdhci-pltfm.h    |   35 +++++++++
 include/linux/sdhci-pltfm.h        |   35 ---------
 12 files changed, 316 insertions(+), 112 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
 create mode 100644 drivers/mmc/host/sdhci-esdhc.h
 create mode 100644 include/linux/mmc/sdhci-pltfm.h
 delete mode 100644 include/linux/sdhci-pltfm.h

