From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/5] sdhci-esdhc-imx: use gpio for write protection and card detection
Date: Thu, 10 Feb 2011 20:14:46 +0100
Message-ID: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49298 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab1BJTPZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 14:15:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

I finally could do a second version of my write protect-patches and the first
version of a card detect approach (thanks to Olof for the inspiration here).
Note that these feature are only needed for i.mx25/35 as the i.mx5x-series
_finally_ seem to be able to route the gpios to the controller directly.

These patches apply to mmc-next and have been tested with a mx35-based pcm043.
I think the first three patches should go via Chris and the latter two via
Sascha. The last one is more a cleanup-patch, but it depends on the former, so
I included it here.

The branch can be found at:

	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

Eric: Would be awesome if you could test these on your boards!

Looking forward to comments,

   Wolfram

Wolfram Sang (5):
  mmc: sdhci-esdhc-imx: add support for write protect on custom GPIO
  mmc: sdhci-esdhc: broken card detection is not a default quirk
  mmc: sdhci-esdhc-imx: add card detect on custom GPIO
  arm: mach-mx3: pcm043: add write-protect and card-detect for SD1
  arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded values

 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    4 +-
 arch/arm/mach-mx3/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c              |   19 +++-
 arch/arm/plat-mxc/include/mach/esdhc.h       |   12 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c           |  129 +++++++++++++++++++++++---
 drivers/mmc/host/sdhci-esdhc.h               |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c            |    3 +-
 7 files changed, 148 insertions(+), 22 deletions(-)

-- 
1.7.2.3

