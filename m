From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 00/10] Add SDHCI support for STMicroelectronics SoCs
Date: Wed,  4 Jun 2014 17:07:24 +0100
Message-ID: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:42677 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaFDQHk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 12:07:40 -0400
Received: by mail-wi0-f181.google.com with SMTP id n15so1794767wiw.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 09:07:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: peter.griffin@linaro.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

This series adds a SDHCI platform driver for ST SoCs, along with
the additional device tree bindings and configuration to enable
the controller to work properly.

Initially it supports the stih416 and stih415 SoCs, and has
been tested on a stih416-b2020 board.

regards,

Peter.

Changes since v1
- Whitespace cleanups
- Use readl_relaxed io accessor
- Add update to MAINTAINERS
- Remove reset controller code from platform driver
- Remove #ifdef around sleep ops
- Use sdhci_pltfm_clk_get_max_clock lib function
- Pass bus-width etc through board device tree node
- Remove unncessary header
- Remove / change some debug messages
- Remove final break from switch case

Peter Griffin (10):
  mmc: sdhci-st: Intial support for ST SDHCI controller
  mmc: sdhci-st: ST Microelectronics SDHCI binding documentation.
  ARM: STi: DT: Add sdhci pins for stih416
  ARM: STi: DT: Add sdhci controller for stih416
  ARM: STi: DT: Add sdhci pin configuration for stih415
  ARM: STi: DT: Add sdhci controller for stih415
  ARM: STi: DT: Enable mmc0 for both stih415 and stih416 SoCs
  ARM: STi: DT: Enable second sdhci controller for stih416 b2020 boards.
  ARM: update multi_v7_defconfig for STI
  MAINTAINERS: Add sdhci-st file to ARCH/STI architecture

 Documentation/devicetree/bindings/mmc/sdhci-st.txt |  33 ++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  21 +++
 arch/arm/boot/dts/stih415.dtsi                     |  12 ++
 arch/arm/boot/dts/stih416-b2020-revE.dts           |   6 +
 arch/arm/boot/dts/stih416-b2020.dts                |   8 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  39 ++++
 arch/arm/boot/dts/stih416.dtsi                     |  24 +++
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   4 +
 arch/arm/boot/dts/stih41x-b2020x.dtsi              |   4 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/mmc/host/Kconfig                           |  12 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-st.c                        | 201 +++++++++++++++++++++
 14 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-st.txt
 create mode 100644 drivers/mmc/host/sdhci-st.c

-- 
1.9.1

