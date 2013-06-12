From: <dinguyen@altera.com>
Subject: [PATCH 0/2] mmc: dw_mmc: Add support and bindings for SOCFPGA dw_mmc driver
Date: Tue, 11 Jun 2013 19:28:42 -0500
Message-ID: <1370996924-23048-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:49461
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755316Ab3FLA2s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 20:28:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Hi Chris,

I apologize for not including you in the original patch series. Can you can review
and apply to your tree if there are not comments?

PATCH[1/2] - Bindings and documentation for dw_mmc-socfpga
PATCH[2/2] - SOCFPGA platform specific implementation for dw_mmc driver.

Thanks,
Dinh

Dinh Nguyen (2):
  ARM: socfpga: dts: Add support for SD/MMC
  mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA

 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 +++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 +-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++
 drivers/mmc/host/Kconfig                           |    8 ++
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |    2 -
 drivers/mmc/host/dw_mmc-socfpga.c                  |  140 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h                          |    1 +
 9 files changed, 247 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5


