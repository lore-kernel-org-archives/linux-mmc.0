From: <dinguyen@altera.com>
Subject: [PATCHv4 0/4] socfpga: Enable SD/MMC support
Date: Thu, 5 Dec 2013 11:14:33 -0600
Message-ID: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:42082
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757119Ab3LERQV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 12:16:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v4 of the patch series to enable SD/MMC on the SOCFPGA platform.

V4 differences from V3:

* Re-use the SOCFPGA clock driver for controlling the SDR settings of the CIU
clock. By using the .prepare member of the common clk_ops structure, the settings
of the SD/MMC CIU can be done through the common clock API in the SD/MMC driver.

* Re-use exising binding that is on the Rockchip. The "rockchip,rk2928-dw-mshc"
binding that will also work for SOCFPGA.

* Remove dw_mmm-socfpga.c that is platform specific to SOCFPGA as the only
require platform specific code is already done with "rockchip,rk2928-dw-mshc".

* Add error checking for getting "samsung,dw-mshc-sdr-timing".

* Add support for SD/MMC to socfpga_defconfig.

* Add SD/MMC dts entries for socfpga_arria5.

Thanks,

Dinh Nguyen (4):
  arm: dts: Add support for SD/MMC on SOCFPGA
  clk: socfpga: Add a hook for SD/MMC driver to control CIU clock
    settings
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 arch/arm/boot/dts/socfpga.dtsi          |   11 +++
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   12 +++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   12 +++
 arch/arm/boot/dts/socfpga_vt.dts        |   12 +++
 arch/arm/configs/socfpga_defconfig      |    2 +
 drivers/clk/socfpga/clk.c               |   22 +++++
 drivers/mmc/host/Kconfig                |    8 --
 drivers/mmc/host/dw_mmc-socfpga.c       |  138 -------------------------------
 8 files changed, 71 insertions(+), 146 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5


