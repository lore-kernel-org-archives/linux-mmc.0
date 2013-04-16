From: <ludovic.desroches@atmel.com>
Subject: [PATCH v2 0/6] ARM: at91: move to generic DMA device tree binding
Date: Tue, 16 Apr 2013 15:03:04 +0200
Message-ID: <1366117390-24686-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:40596 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847Ab3DPNDR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Apr 2013 09:03:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches introduces DMA device tree bindings support for the atmel
DMA controller and first driver conversions.

Patch 3/6 has already been taken by Wolfram.

v2 changes:
- update documentation about dma bindings according to Nicolas' comments
- put dtsi changes in a separate patch
- add dtb update for i2c and mci nodes

Ludovic Desroches (6):
  at_hdmac: move to generic DMA binding
  ARM: at91: dts: set #dma-cells to the correct value
  i2c: at91: convert to dma_request_slave_channel_compat()
  ARM: at91: dts: add i2c dma support
  mci: at91: convert to dma_request_slave_channel_compat()
  ARM: at91: dts: add MCI DMA support

 .../devicetree/bindings/dma/atmel-dma.txt          | 35 ++++++--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  5 ++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  9 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 15 ++++
 arch/arm/boot/dts/sama5d3.dtsi                     | 19 ++++-
 drivers/dma/at_hdmac.c                             | 93 ++++++++++++++++++++--
 drivers/dma/at_hdmac_regs.h                        |  4 +
 drivers/i2c/busses/i2c-at91.c                      | 49 ++++++------
 drivers/mmc/host/atmel-mci.c                       | 25 +++---
 9 files changed, 204 insertions(+), 50 deletions(-)

-- 
1.7.11.3

