From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/9] mmc: sh_mobile_sdhi: add HS200 support
Date: Mon, 12 Dec 2016 20:51:19 +0100
Message-ID: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41852 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbcLLTvr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Dec 2016 14:51:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is a series adding HS200 support to the SDHI driver. Building the actual
functionality on top of SDR104 support was rather easy. However, I figured the
checks for enabling tuning were rather scattered over the driver and could be
further improved. So I did some refactoring of that to make adding HS200
support then a one-liner :)

This has been tested on Salvator-X boards with R-Car H3 and M3-W SoCs. It has
also been tested on a Lager board (R-Car H2) checking SDR50/104 for
regressions. The whole test document showing significant speed-ups reading from
the on-board eMMC can be found here:

http://elinux.org/Tests:eMMC-HS

and the branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-emmc-hs

Please comment, review, apply...

Thanks,

   Wolfram


Wolfram Sang (9):
  mmc: sh_mobile_sdhi: simplify accessing DT data
  mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
  mmc: sh_mobile_sdhi: improve prerequisites for tuning
  mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
  mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
  mmc: sh_mobile_sdhi: remove superfluous check in SCC error check
  mmc: sh_mobile_sdhi: enable HS200
  arm64: dts: r8a7795: enable HS200 for eMMC
  arm64: dts: r8a7796: enable HS200 for eMMC

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  1 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  1 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 67 ++++++++--------------
 3 files changed, 27 insertions(+), 42 deletions(-)

-- 
2.10.2

