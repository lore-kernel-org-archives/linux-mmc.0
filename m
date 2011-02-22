From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH V2 0/5] sdhci-esdhc-imx: use gpio for write protection and card detection
Date: Tue, 22 Feb 2011 13:58:15 +0100
Message-ID: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55295 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1BVM61 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 07:58:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

Second version of my series, no major changes:

* rephrased warnings
* collected some tags
* rebased to mmc/mmc-next as of today

Eric wanted to tested these patches soonish. Thanks to Marc for testing the
first three already.

I think the first three patches should go via Chris and the latter two via
Sascha. The last one is more a cleanup-patch, but it depends on the former, so
I included it here.

The branch can be found at:

	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

Thanks,

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
 drivers/mmc/host/sdhci-esdhc-imx.c           |  131 +++++++++++++++++++++++---
 drivers/mmc/host/sdhci-esdhc.h               |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c            |    3 +-
 7 files changed, 148 insertions(+), 22 deletions(-)

-- 
1.7.2.3

