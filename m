From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr not supported on sabresd issues
Date: Wed, 30 Oct 2013 22:09:47 +0800
Message-ID: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:50576
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab3J3O2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:28:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

Patch 1~3 fix acmd23 unwork issue.
Currently the eMMC chip integrated on i.MX6Q SabreSD boards does not work.
(It's easily reproduced once you enable usdhc4 on sabresd, see patch 3)
It's caused by acmd setting bits are never cleared once it's been set
which cause the next normal commands to work abnormally.

Patch 4~6 fix DDR not supported on SabreSD board.
The SabreSD board does not have 1.8v signal voltage switch support for uSDHC,
thus it can not support UHS_DDR50 mode which can only run at 1.8v signal voltage.

The issue is that current mmc DDR mode support implemented in MMC core depends
on UHS_DDR50, which then cause such controller like uSDHC on SabreSD without 1.8v
capability can not support eMMC DDR mode too.
(But the SabreSD board does support eMMC DDR mode since the eMMC DDR mode can
work on either 1.8v or 3.3v)
So this patch gets rid of this limitation to let controller not support
1.8v signal voltage can also support eMMC DDR mode.

ChangeLog:
v1->v2: a minor change on patch1, switch the order of patch 4&5.
	dropped patch 7: mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
	which will be in another series together with another extra fix on tuning
	broken issue in latest Chris' tree.

Dong Aisheng (6):
  mmc: sdhci: clear auto cmd setting bits for no data cmds
  mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
  ARM: dts: sabresd: add usdhc4 support
  mmc: sdhci-esdhc-imx: fix cpas over write issue
  mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
  mmc: core: mmc DDR mode should not depend on UHS_DDR50

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    9 +++++++++
 drivers/mmc/core/mmc.c                 |    8 ++------
 drivers/mmc/host/sdhci-esdhc-imx.c     |   19 ++++++++++++++++++-
 drivers/mmc/host/sdhci.c               |    7 ++++++-
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
1.7.2.rc3


