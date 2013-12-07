From: <dinguyen@altera.com>
Subject: [PATCHv2 0/3] mmc: dw_mmc: Make the use of the hold reg generic
Date: Fri, 6 Dec 2013 21:20:21 -0600
Message-ID: <1386386424-859-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:2699
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab3LGDWM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 22:22:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v2 of the patch series that makes the setting of the SDMMC_CMD_USE_HOLD_REG
bit generic.

v2 differences:

* Another part of the spec on dw_mmc states, "Never set CMD.use_hold_reg = 1 and
  cclk_in_drv phase shift to 0 at the same time. This would add an extra one-cycle
  delay on the output path, resulting in incorrect behavior." The cclk_in_drv phase
  shift is the 2nd parameter in the "samsung,dw-mshc-sdr-timing" and
  "samsung,dw-mshc-ddr-timing" bindings. V2 checks for the cclk_in_drv phase shift
  value. If cclk_in_drv = 0, then we cannot set the SDMMC_CMD_USE_HOLD_REG bit.

* Removes the Exynos' platform specific prepare_command's function that sets the
  SDMMC_CMD_USE_HOLD_REG based on the cclk_in_drv phase shift value.

Thanks,

Dinh Nguyen (3):
  mmc: dw_mmc: Enable the hold reg for certain speed modes
  mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
  mmc: dw_mmc-exynos: Remove Exynos' custom prepare_command function

 drivers/mmc/host/dw_mmc-exynos.c |   14 ------------
 drivers/mmc/host/dw_mmc-pltfm.c  |   12 +----------
 drivers/mmc/host/dw_mmc.c        |   44 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h       |    3 +++
 4 files changed, 48 insertions(+), 25 deletions(-)

-- 
1.7.9.5


