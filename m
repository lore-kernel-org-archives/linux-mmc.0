From: <dinguyen@altera.com>
Subject: [PATCHv9 0/4] socfpga: Enable SD/MMC support
Date: Thu, 9 Jan 2014 15:31:15 -0600
Message-ID: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:51775
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbaAIVdQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 16:33:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v9 of that patch series to enable SD/MMC on the SOCFPGA platform.

V9 differences from v8:

* Update the Makefile to remove the SOCFPGA DW platform specific build.

Thanks,
Dinh

Dinh Nguyen (4):
  clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"
  dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 .../devicetree/bindings/clock/altr_socfpga.txt     |    5 +
 arch/arm/boot/dts/socfpga.dtsi                     |   14 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++
 arch/arm/configs/socfpga_defconfig                 |    2 +
 drivers/clk/socfpga/clk-gate.c                     |   68 ++++++++++
 drivers/mmc/host/Kconfig                           |    8 --
 drivers/mmc/host/Makefile                          |    1 -
 drivers/mmc/host/dw_mmc-socfpga.c                  |  138 --------------------
 10 files changed, 121 insertions(+), 148 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5


