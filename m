From: <dinguyen@altera.com>
Subject: [PATCHv2 0/4] socfpga: Enable SD/MMC support
Date: Mon, 4 Nov 2013 14:36:01 -0600
Message-ID: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:35009
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659Ab3KDUgZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 15:36:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v2 of the patch series to enable SD/MMC on the SOCFPGA platform.

V2 adds a syscon driver to control the system manager registers.

V1 of the cover-letter of this patch series appears below:
This patch series enables support for the Synopsys SD/MMC driver that is
on the Altera SOCFPGA platform. The reason why this series has 4 patches
is to implement Arnd's suggestion:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204982.html

To summarize Arnd's suggestion:

1. Create a backend syscon driver to control the system manager.
2. Create a clock driver independent of the SOCFPGA clock driver that
   uses syscon as the low-level interface.
3. Make the sdmmc driver use the normal clock API and link its clock to
   the driver step 2 in the device tree.

The end approach is a bit different because I did not find the need for a
syscon driver for the system manager. Since the system manager had already
been iomap already in the SOCFPGA platform code, I just reused it in the
new clock driver.

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
Dinh 

Dinh Nguyen (4):
  clk: socfpga: Add a clock driver for SOCFPGA's system manager
  arm: dts: Add a system manager compatible property
  mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
  arm: dts: Add support for SD/MMC on SOCFPGA

 .../bindings/arm/altera/socfpga-system.txt         |   10 ++
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   38 ++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   23 ++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   12 +++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 +++
 drivers/clk/socfpga/Makefile                       |    2 +-
 drivers/clk/socfpga/clk-sysmgr.c                   |   98 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc-socfpga.c                  |   80 ++--------------
 8 files changed, 202 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 drivers/clk/socfpga/clk-sysmgr.c
---
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org


-- 
1.7.9.5


