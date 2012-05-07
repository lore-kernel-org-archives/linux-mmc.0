From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 00/10] Add device tree support for mxs-mmc
Date: Mon,  7 May 2012 22:43:02 +0800
Message-ID: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab2EGOnE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:04 -0400
Received: by dady13 with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

This series adds device tree support for mxs-mmc based on mxs
common-clk, pinctrl, and DT support for mxs gpio and dma.

Shawn Guo (10):
  mmc: mxs-mmc: use global stmp_device functionality
  mmc: mxs-mmc: let ssp_is_old take host as parameter
  mmc: mxs-mmc: get rid of the use of cpu_is_xxx
  mmc: mxs-mmc: move header from mach into linux folder
  mmc: mxs-mmc: use devm_* helper to make cleanup simpler
  mmc: mxs-mmc: have dma_channel than dma_res in mxs_mmc_host
  mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
  mmc: mxs-mmc: add device tree support
  ARM: dts: enable mmc for imx23-evk
  ARM: dts: enable mmc for imx28-evk

 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   26 +++
 arch/arm/boot/dts/imx23-evk.dts                    |   11 +
 arch/arm/boot/dts/imx23.dtsi                       |   19 ++
 arch/arm/boot/dts/imx28-evk.dts                    |   19 ++
 arch/arm/boot/dts/imx28.dtsi                       |   25 +++
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c       |   21 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |    3 +-
 drivers/clk/mxs/clk-imx23.c                        |    4 +-
 drivers/clk/mxs/clk-imx28.c                        |    8 +-
 drivers/mmc/host/mxs-mmc.c                         |  199 +++++++++++---------
 .../mach/mmc.h => include/linux/mmc/mxs-mmc.h      |    7 +-
 11 files changed, 235 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 rename arch/arm/mach-mxs/include/mach/mmc.h => include/linux/mmc/mxs-mmc.h (81%)

-- 
1.7.5.4

