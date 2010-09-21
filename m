From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Tue, 21 Sep 2010 14:30:06 +0200
Message-ID: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54285 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0IUMaX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 08:30:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Richard Zhu <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

this series adds basic support for the esdhc-controller found on mx35/51-cpus.
It first extends the sdhci-pltfm-driver to have a runtime-structure for data
(1/4), does a bit of cleanup (2/4), extracts a few parts which can be shared
with the OF-version (3/4) and finally adds the driver (4/4).

Note that the support is basic at the moment. Still to be done are:

* ADMA support (Richard Zhu mentioned it has issues and knows the details)

* 8-Bit bus width (needs more research; it breaks some cards for me :( )

* voltage switching using a regulator (I don't have such hardware, hopefully
  Richard can pick this up)

* write_protect using a GPIO (we need to retrieve board-specific data for that;
  an RFC follows after this series)

Platform resources could be posted after write_protect issue has been sorted
out.

Please review and/or give comments. Please let me also know if you intend to
work on a missing bit.

Thanks,

   Wolfram

===

Wolfram Sang (4):
  mmc: sdhci-pltfm: Add structure for host-specific data
  mmc: sdhci-pltfm: move .h-file into apropriate subdir
  mmc: sdhci-of-esdhc: factor out common stuff
  mmc: sdhci-pltfm: add pltfm-driver for imx35/51

 drivers/mmc/host/Kconfig          |    9 +++
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/sdhci-cns3xxx.c  |    2 +-
 drivers/mmc/host/sdhci-esdhc.c    |  141 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h    |   81 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |   70 ++----------------
 drivers/mmc/host/sdhci-pltfm.c    |   12 +++-
 drivers/mmc/host/sdhci-pltfm.h    |    8 ++-
 include/linux/mmc/sdhci-pltfm.h   |   35 +++++++++
 include/linux/sdhci-pltfm.h       |   35 ---------
 10 files changed, 292 insertions(+), 102 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc.c
 create mode 100644 drivers/mmc/host/sdhci-esdhc.h
 create mode 100644 include/linux/mmc/sdhci-pltfm.h
 delete mode 100644 include/linux/sdhci-pltfm.h

