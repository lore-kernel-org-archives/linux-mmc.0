From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 18 Jun 2015 02:05:31 +0800
Message-ID: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0135.outbound.protection.outlook.com ([157.56.111.135]:46694
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757758AbbFQSH4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 14:07:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

Commit 8d86e4f mmc: sdhci-esdhc-imx: Call mmc_of_parse()
seriously break the sd card detect/write protect function
of most IMX platforms since a lot of GPIO flags of cd-gpios/wp-gpios
are wrongly set in devicetree.

It breaks the following things:
1) cd-gpio function enable
Most IMX boards GPIO card detect function becomes unwork and using card
polling mode instead by mistake.
Openning CONFIG_MMC_DEBUG will easily see that.
It is caused by the default quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION
is not cleared for dt platform by commit 8d86e4f, then
MMC_CAP_NEEDS_POLL is wrongly set.
Patch 1~2 is to fix it.

2) cd-gpio/wp-gpio polarity
Before commit 8d86e4f, we do not use GPIO flags passed from
devicetree. But after it, GPIO flags specfied in dt becomes valid
and will affect the normal cd/wp function.

This is fixed by another dts fix patch series:
[PATCH 0/5] dts: imx: fix sd card gpio polarity specified in device tree
http://www.spinics.net/lists/arm-kernel/msg426156.html

Since it needs to change a lot board dts files, so i cook the patch
based on Shawn/for-next branch to make sure all board dts file are
changed in the same time.

The dts fix patches series should be picked before this series since
the driver fixes depend on the correct dts(correct GPIO polarity)
to work properly.

3) max-frequency not work in sdhci
mmc_of_parse will parse the max-frequency from devicetree,
however, its value will be overwritten by common sdhci driver
finnally,so it does not actually work.
Patch 3 is to fix it.

4) patch 4~6 clear unneeded parsing code after switch to mmc_of_parse().

The series is based on ulf/next tree.

I also CCed this patch series to all board maintainer related in this
change, hope they can help test it.
I only tested some freescale IMX boards.

BTW, There's indeed a problem here that dts fix patch series needs to
be picked before this series, but it can't go through Ulf tree
since some board dts changed does not in Ulf's tree.
And this patch series also can not go through Shawn's tree,
since mmc part change depends on some patches in Ulf tree.
Two series are cross dependant.
Hope you guy can find a solution for it.

Those two patch series is an important fix, hopefully can catch up the
final 4.1 merge window.

Dong Aisheng (6):
  mmc: sdhci-esdhc-imx: fix cd regression for dt platform
  mmc: sdhci-esdhc-imx: move all non dt probe code into one function
  mmc: sdhci: make max-frequency property in device tree work
  mmc: sdhci-esdhc-imx: remove duplicated dts parsing
  mmc: sdhci-esdhc-imx: clear f_max in boarddata
  dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 -
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 210 ++++++++++-----------
 drivers/mmc/host/sdhci.c                           |   9 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 -
 4 files changed, 111 insertions(+), 111 deletions(-)

-- 
1.9.1

