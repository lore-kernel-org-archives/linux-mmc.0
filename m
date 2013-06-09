From: Simon Baatz <gmbnomis@gmail.com>
Subject: [RESEND PATCH V3 0/8] mmc_of_parse() adaptations, switch mvsdio to mmc_of_parse()
Date: Sun,  9 Jun 2013 22:14:10 +0200
Message-ID: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:62582 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3FIUOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 16:14:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Chris Ball <cjb@laptop.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

	RESEND V3:
	- Dropped patches 9 and 10, they are part of linux-next already
	NB: patch 7 as well, but I did not want to change the numbering

	V3 changes:
	- Patch 01/10: Added EPROBE_DEFER case to mmc_of_parse()
	- Added Acked-By to (unmodified) patches 02 and 03.

	V2 changes:
	- Converted mvsdio to use mmc_of_parse()
	- Adapted DTS files using mvsdio accordingly
	- Changed mmc_of_parse() to return errors to the caller

While adding DT support for the Sheevaplugs by Globalscale Technologies
(Kirkwood), it turned out that the DT binding of mvsdio lacked features to
properly support the hardware (active high/low of CD and WP pins could not
be described in DT).

This is standard functionality provided by the mmc_of_parse() helper
function.  However, mmc_of_parse() may allocate GPIO lines.  If the
allocation fails, it outputs an error, but does not return an error to its
caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
This also allows to handle the EPROBE_DEFER case when GPIO is not loaded
yet.

The patch set is structured as follows:

1   Adapt mmc_of_parse() to return errors
2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
    only)
7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
    kirkwood)


Simon Baatz (8):
  mmc: return mmc_of_parse() errors to caller
  mmc: sh_mmcif: handle mmc_of_parse() errors during probe
  mmc: tmio-mmc: handle mmc_of_parse() errors during probe
  mmc: mxcmmc: handle mmc_of_parse() errors during probe
  mmc: sdhci-pxav3: handle mmc_of_parse() errors during probe
  mmc: tegra: handle mmc_of_parse() errors during probe
  ARM: mvebu: Use standard MMC binding for all users of mvsdio
  mmc: mvsdio: use standard MMC device-tree binding parser
    mmc_of_parse()

 arch/arm/boot/dts/armada-370-db.dts                |    1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
 arch/arm/boot/dts/armada-370-rd.dts                |    1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    4 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 +
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |    4 ++
 drivers/mmc/core/host.c                            |   30 ++++++--
 drivers/mmc/host/mvsdio.c                          |   73 +++++++++++---------
 drivers/mmc/host/mxcmmc.c                          |    4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |    7 +-
 drivers/mmc/host/sdhci-tegra.c                     |    9 ++-
 drivers/mmc/host/sh_mmcif.c                        |    7 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |    4 +-
 include/linux/mmc/host.h                           |    2 +-
 18 files changed, 106 insertions(+), 48 deletions(-)

-- 
1.7.9.5

