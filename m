From: <dinguyen@altera.com>
Subject: [PATCHv3 0/3] mmc: dw_mmc: Make the use of the hold reg generic
Date: Sun, 8 Dec 2013 22:51:05 -0600
Message-ID: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.28] ([207.46.163.28]:33424 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760461Ab3LIEyM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Dec 2013 23:54:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v3 of the patch series that makes the setting of the SDMMC_CMD_USE_HOLD_REG
bit generic.

v3 differences:

* Read the IHR(Implement HOLD Register) bit in the HCON register. Will not use
the SDMMC_CMD_USE_HOLD_REG if the IHR bit is 0 and cclk_in_drv = 0.

* Changes the cclk_in_drv and use_hold_reg register type from bool to u32.

* Add can_use_hold_reg variable that is condition on whether or not we can use
the hold reg.

* v2 of (1/3, 2/3) was Acked-by: and Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks,

Dinh Nguyen (3):
  mmc: dw_mmc: Enable the hold reg for certain speed modes
  mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
  mmc: dw_mmc-exynos: Remove Exynos' custom prepare_command function

 drivers/mmc/host/dw_mmc-exynos.c |   14 -----------
 drivers/mmc/host/dw_mmc-pltfm.c  |   12 +--------
 drivers/mmc/host/dw_mmc.c        |   51 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h        |    4 +++
 include/linux/mmc/dw_mmc.h       |    3 +++
 5 files changed, 59 insertions(+), 25 deletions(-)

-- 
1.7.9.5


