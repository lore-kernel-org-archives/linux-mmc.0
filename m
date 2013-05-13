From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 00/10] mmc_of_parse() adaptations, DT support for Sheevaplugs
Date: Mon, 13 May 2013 23:18:51 +0200
Message-ID: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:49909 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3EMVTj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

While adding DT support for the Sheevaplugs by Globalscale Technologies
(Kirkwood), it turned out that the DT binding of mvsdio lacked features to
properly support the hardware (active high/low of CD and WP pins could not
be described in DT).

This is standard functionality provided by the mmc_of_parse() helper
function.  However, mmc_of_parse() may allocate GPIO lines.  If the
allocation fails, it outputs an error, but does not return an error to its
caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.

The patch set is structured as follows:

1   Adapt mmc_of_parse() to return errors
2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
    only)
7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
    kirkwood)
9   Add dts files for (eSATA) Sheevaplug
10  Add DT support for (eSATA) Sheevaplug


I could only test on an eSATA Sheevaplug. I found patches with
different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
someone with the hardware could give this a spin on a non-eSATA
version.  Some additional testing of the change detect and write
protect behaviour for mvsdio can't hurt either.  I hope that there aren't
board revisions with different CD/WP pins out there.

Simon Baatz (10):
  mmc: return mmc_of_parse() errors to caller
  mmc: sh_mmcif: handle mmc_of_parse() errors during probe
  mmc: tmio-mmc: handle mmc_of_parse() errors during probe
  mmc: mxcmmc: handle mmc_of_parse() errors during probe
  mmc: sdhi-pxav3: handle mmc_of_parse() errors during probe
  mmc: tegra: handle mmc_of_parse() errors during probe
  ARM: mvebu: Use standard MMC binding for all users of mvsdio
  mmc: mvsdio: use standard MMC device-tree binding parser
    mmc_of_parse()
  ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
  ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA

 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/armada-370-db.dts                |    1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
 arch/arm/boot/dts/armada-370-rd.dts                |    1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    4 +
 arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 +
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |   97 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |   40 ++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |   45 +++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |    4 +
 arch/arm/mach-kirkwood/Kconfig                     |    7 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/board-dt.c                  |    4 +
 arch/arm/mach-kirkwood/board-sheevaplug.c          |   27 ++++++
 arch/arm/mach-kirkwood/common.h                    |    5 +
 drivers/mmc/core/host.c                            |   24 ++++-
 drivers/mmc/host/mvsdio.c                          |   73 ++++++++-------
 drivers/mmc/host/mxcmmc.c                          |    4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |    7 +-
 drivers/mmc/host/sdhci-tegra.c                     |    9 +-
 drivers/mmc/host/sh_mmcif.c                        |    7 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |    4 +-
 include/linux/mmc/host.h                           |    2 +-
 27 files changed, 328 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c

-- 
1.7.9.5

