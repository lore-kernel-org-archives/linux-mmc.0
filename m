From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Support for platform-esdhc-controller
Date: Mon,  6 Sep 2010 12:34:22 +0200
Message-ID: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51022 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0IFKe4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:34:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

This is a patch series adding support for the esdhc-controller as a platform
device which can be found on e.g. mx35/51. It was tested using a mx35-based
Phytec pcm043. This is still a WIP! ADMA2 is not supported so far (mx35 just
has ADMA1 which is not supported by the core?) I will see if I can grab a
mx51-board later.

The following changes since commit 2bfc96a127bc1cc94d26bfaa40159966064f9c8c:

  Linux 2.6.36-rc3 (2010-08-29 08:36:04 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

Wolfram Sang (3):
      sdhci-pltfm: Add structure for host-specific data
      mmc: add driver for imx35/51
      pcm043: add resources for mmc

 arch/arm/mach-mx3/mach-pcm043.c |   29 ++++++
 drivers/mmc/host/Kconfig        |    9 ++
 drivers/mmc/host/Makefile       |    1 +
 drivers/mmc/host/sdhci-esdhc.c  |  194 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c  |   10 ++-
 drivers/mmc/host/sdhci-pltfm.h  |    6 +
 6 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc.c

Regards,

   Wolfram

