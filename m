From: <dinguyen@altera.com>
Subject: [PATCH 0/3] Add support for SD/MMC on SOCFPGA
Date: Mon, 9 Sep 2013 10:33:50 -0500
Message-ID: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:56141
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760Ab3IIPeE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 11:34:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Pavel Machek <pavel@denx.de>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

Here is a patch series that enables SD/MMC support for the SOCFPGA platform.
This is the 6th revision of the series. This series is intended for v3.13.

v6:
- Reuse "samsung,dw-mshc-sdr-timing" binding
- Clean up dw_mmc-socfpga.c to have only the necessary functions
	- Remove dw_mci_socfpga_parse_dt(), as we'll let the platform function:
		socfpga_sysmgr_set_dwmmc_drvsel_smpsel() do that work
	- Always use SDMMC_CMD_USE_HOLD_REG
- Add mach-socfpga/system_mgr.c, which contains function that will set the
  SD/MMC SDR values in the System Manager.
- Expose an API function in the mach-socfpga platform code so that the SD/MMC
  driver can use to set the SDR values.

I know that there's a general rule not to have drivers access specific
function(s) in platform code, but for this case I am really unsure of what
would be the best solution. The system manager IP block itself does not warrant
a driver, so a "syscon" driver should suffice. However, there are specific
register offsets that are needed, these can be defined in either in the SD/MMC 
or DTS entry. But in order for the DTS entries to be correct, it would need register 
offset information as well. And I was informed that register offsets were frowned 
upon in the past.
   
So for this go-around, I am exposing an API from the mach-socfpga platform
code that will only be used by a platform-specific implementation of the SD/MMC
driver.

v5:
- Add "altr,ciu-clk-offset" that represents the necessary offset
	and shift values in the sysmgr phandle. This is used to set
	the correct CIU clock values.
    
v4:
- Add a complete binding example in documentations
- Add a phandle entry for "altr,sysmgr" which links the system
	manager to the SD/MMC IP block that controls the SDR timings.
- Split up patches
	1/3 - Add syscon binding to sys-mgr node
	2/3 - DTS bindings and documentation for SD/MMC on SOCFPGA
	3/3 - Driver changes to use the bindings
    
v3:
- Explicitly reference synopsis-dw-mshc.txt for base bindings
- Remove "dw-mshc-ciu-div" as driver can get clock information dts "ciu" entry
- Fixed indentation issue
    
v2:
- Remove bus-width and extra line in documentation
- Merge bindings example into a single node in documentation


Dinh Nguyen (3):
  arm: socfpga: Set the SDMMC clock phase in system manager
  mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
  arm: dts: socfpga: Add support for SD/MMC

 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   38 ++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   12 ++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++++
 arch/arm/mach-socfpga/Makefile                     |    2 +-
 arch/arm/mach-socfpga/core.h                       |    6 ++
 arch/arm/mach-socfpga/system_mgr.c                 |   32 ++++++++++
 drivers/mmc/host/dw_mmc-pltfm.h                    |    2 +-
 drivers/mmc/host/dw_mmc-socfpga.c                  |   63 +-------------------
 9 files changed, 115 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 arch/arm/mach-socfpga/system_mgr.c

-- 
1.7.9.5

