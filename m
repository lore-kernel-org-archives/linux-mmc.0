From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v2 0/5] Tegra SDHCI UHS-I support
Date: Tue, 22 Dec 2015 19:40:59 +0100
Message-ID: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

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

V2 fixes some minor style problems and is rebased on top of mmc/next.
This means it enables the same tuning logic on Tegra210 also. I
don't have a way to test this myself, so any testing on Tegra210 much
appreciated.

Regards,
Lucas

Lucas Stach (5):
  mmc: tegra: implement module external clock change
  mmc: tegra: disable SPI_MODE_CLKEN
  mmc: tegra: implement UHS tuning
  mmc: tegra: enable UHS-I modes
  mmc: tegra: use correct accessor for misc ctrl register

 drivers/mmc/host/sdhci-tegra.c | 166 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 28 deletions(-)

-- 
2.5.0
