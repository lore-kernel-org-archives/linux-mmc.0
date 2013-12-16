From: <dinguyen@altera.com>
Subject: [RESEND LIST PATCHv7 0/4] socfpga: Enable SD/MMC support
Date: Mon, 16 Dec 2013 11:04:32 -0600
Message-ID: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:19221
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754564Ab3LPRGf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 12:06:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

RESEND: Apologies, re-send with CC to all the appropriate lists.

Hi,

This is v7 of the patch series to enable SD/MMC on the SOCFPGA platform.

V7 differences from V6:

* Add a new clock binding property clk-phase. This property is used to
  represent the 2 clock phase values that is needed for the SD/MMC driver.

Thanks,


Dinh Nguyen (4):
  clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"
  dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 .../devicetree/bindings/clock/altr_socfpga.txt     |   14 ++
 arch/arm/boot/dts/socfpga.dtsi                     |   14 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++
 arch/arm/configs/socfpga_defconfig                 |    2 +
 drivers/clk/socfpga/clk.c                          |   37 ++++++
 drivers/mmc/host/Kconfig                           |    8 --
 drivers/mmc/host/dw_mmc-socfpga.c                  |  138 --------------------
 9 files changed, 99 insertions(+), 147 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5


