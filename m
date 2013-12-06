From: <dinguyen@altera.com>
Subject: [PATCH 0/2] mmc: dw_mmc: Make the use of the hold reg generic
Date: Fri, 6 Dec 2013 10:10:21 -0600
Message-ID: <1386346223-18464-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:14565
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754764Ab3LFQMN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 11:12:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This patch series makes the setting of the SDMMC_CMD_USE_HOLD_REG bit generic
for all platforms that requires it. According the Synopsys spec on the dw_mmc,
setting the SDMMC_CMD_USE_HOLD_REG should be done for all speeds except for the
following higher speed modes: SDR104, SDR50, DDR50. I am also include MMC_HS200
speed as not needing the SDMMC_CMD_USE_HOLD_REG bit set as well.

Currently, Rockchip and SOCFPGA's variant of the dw_mmc requires that the
SDMMC_CMD_USE_HOLD_REG be set. For SOCFPGA, the dw_mmc is operating at 
MMC_TIMING_SD_HS mode. I don't know Rockchip's variant is operating at.

Thanks,

Dinh Nguyen (2):
  mmc: dw_mmc: Enable the hold reg for certain speed modes
  mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure

 drivers/mmc/host/dw_mmc-pltfm.c |   12 +-----------
 drivers/mmc/host/dw_mmc.c       |   14 ++++++++++++++
 include/linux/mmc/dw_mmc.h      |    1 +
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
1.7.9.5


