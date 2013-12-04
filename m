From: <dinguyen@altera.com>
Subject: [PATCHv3 0/4] socfpga: Enable SD/MMC support
Date: Wed, 4 Dec 2013 16:52:52 -0600
Message-ID: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:19914 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755146Ab3LDWyv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 17:54:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v3 of the patch series to enable SD/MMC on the SOCFPGA platform. The
SD/MMC IP is the Synopsys DW SD/MMC driver. However, the settings for the
clock-phase of the CIU resides in a register that is located outside of SD/MMC
IP, in a register block called the system manager.

Per Arnd's suggestion, I implemented a clock driver for the system manager
block. The SD/MMC driver can now use the common clock API to set the correct
settings for the SD/MMC clock phase.

Patch 1/4: clk: socfpga: Add a clock driver for SOCFPGA's system manager
This patch adds a clk-sysmgr driver that can be use by a common clock API
to set system manager register bits needed by the SD/MMC driver. The SD/MMC
driver can simply call a common clock API to set the required clock phase
settings for the SD/MMC CIU.

Patch 2/4: arm: dts: Add a system manager compatible property
This patch adds a DTS compatible entry for the new clk-sysmgr driver.

Patch 3/4: mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
This patch cleans up dw_mmc-socpfga.c file from defines that are outside of
the SD/MMC IP. It makes the common clock API call to set the SD/MMC clock
phase settings in the system manager.

Patch 4/4: arm: dts: Add support for SD/MMC on SOCFPGA
This patch adds the necessary DTS bindings for the SOCFPGA specific extensions
to the base Synopsys DW SD/MMC driver.

Thanks,

Dinh Nguyen (4):
  clk: socfpga: Add a clock driver for SOCFPGA's system manager
  arm: dts: Add a system manager compatible property
  mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific
    funcationality
  arm: dts: Add support for SD/MMC on SOCFPGA

 .../bindings/arm/altera/socfpga-system.txt         |   10 +++
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   38 ++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   25 +++++-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   12 +++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 +++
 drivers/clk/socfpga/Makefile                       |    2 +-
 drivers/clk/socfpga/clk-sysmgr.c                   |   91 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc-socfpga.c                  |   78 +++--------------
 8 files changed, 196 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 drivers/clk/socfpga/clk-sysmgr.c

-- 
1.7.9.5


