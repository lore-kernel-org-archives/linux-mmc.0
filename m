From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH 0/5] Tegra SDHCI UHS-I support
Date: Sat, 19 Dec 2015 20:15:59 +0100
Message-ID: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:40488 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932727AbbLSTXL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Dec 2015 14:23:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi all,

this series implements UHS-I signaling for the Tegra SDHCI host,
which mainly means putting a proper tuning sequence in place.

I've tested this on Jetson TK1 and got the following speed results,
where mmcblk0 is the on-board eMMC and mmcblk1 is a micro SDXC card:

Without series applied:
hdparm -t /dev/mmcblk0
 Timing buffered disk reads:  110 MB in  3.05 seconds =  36.02 MB/sec
hdparm -t /dev/mmcblk1
 Timing buffered disk reads:   56 MB in  3.01 seconds =  18.63 MB/sec
 
With series applied:
hdparm -t /dev/mmcblk0
 Timing buffered disk reads:  236 MB in  3.00 seconds =  78.58 MB/sec
hdparm -t /dev/mmcblk1
 Timing buffered disk reads:  102 MB in  3.04 seconds =  33.51 MB/sec

Tegra 30 does support UHS-I speeds too, but currently has problems
when lowering the card voltage, which is needed in order to switch
to UHS-I signaling. I have some more patches to fix this, but they
need a bit more cleanup, with them applied the gains on Tegra30 are
similar to the results above.

For now the gains are limited to Tegra124+, with no regressions on
Tegra30 and Tegra20.

Regards,
Lucas

Lucas Stach (5):
  mmc: tegra: implement module external clock change
  mmc: tegra: disable SPI_MODE_CLKEN
  mmc: tegra: implement UHS tuning
  mmc: tegra: enable UHS-I modes
  mmc: tegra: use correct accessor for misc ctrl register

 drivers/mmc/host/sdhci-tegra.c | 153 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 24 deletions(-)

-- 
2.5.0

