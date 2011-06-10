From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support for mx5
Date: Fri, 10 Jun 2011 18:42:48 +0800
Message-ID: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41956 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab1FJKdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2011 06:33:55 -0400
Received: by pwi15 with SMTP id 15so1166470pwi.19
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jun 2011 03:33:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The card-present polling within sdhci based driver is very expensive
in terms of the impact to system performance.  We observe a few
system performance issues from Freescale and Linaro on mx5 platforms,
which have been proved card polling related.

The patch set extends the current sdhci-esdhc-imx card_detect and
write_protect support to cover mx5 platforms, and solves above
performance issues.

Shawn Guo (4):
      mmc: sdhci: fix interrupt storm from card detection
      mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
      mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
      mmc: sdhci-esdhc-imx: extend card_detect and write_protect support

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              |    2 +
 arch/arm/mach-imx/mach-mx35_3ds.c              |    7 +-
 arch/arm/mach-imx/mach-pcm043.c                |    2 +
 arch/arm/mach-imx/mach-vpr200.c                |    7 +-
 arch/arm/mach-mx5/board-mx51_3ds.c             |    7 +-
 arch/arm/mach-mx5/board-mx51_babbage.c         |   27 +++++-
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    7 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c         |    7 +-
 arch/arm/mach-mx5/board-mx53_evk.c             |   14 +++-
 arch/arm/mach-mx5/board-mx53_loco.c            |   14 +++-
 arch/arm/mach-mx5/board-mx53_smd.c             |   21 ++++-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |   14 +++-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |    7 +-
 arch/arm/mach-mx5/mx51_efika.c                 |    7 +-
 arch/arm/plat-mxc/include/mach/esdhc.h         |   25 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c             |  117 +++++++++++++----------
 drivers/mmc/host/sdhci.c                       |   13 ++-
 19 files changed, 225 insertions(+), 79 deletions(-)
