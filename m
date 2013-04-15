From: <ludovic.desroches@atmel.com>
Subject: [PATCH 0/3] ARM: at91: move to generic DMA device tree bindings
Date: Mon, 15 Apr 2013 14:16:54 +0200
Message-ID: <1366028217-5037-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:53052 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3DOMRr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Apr 2013 08:17:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches introduces DMA device tree bindings support for the atmel
DMA controller and first driver conversions.

I'll send an update of dts file in the next version if there is no major issue
with the bindings.

Regards


Ludovic Desroches (3):
  at_hdmac: move to generic DMA binding
  i2c: at91: convert to dma_request_slave_channel_compat()
  mci: at91: convert to dma_request_slave_channel_compat()

 .../devicetree/bindings/dma/atmel-dma.txt          | 26 +++++-
 arch/arm/boot/dts/sama5d3.dtsi                     |  4 +-
 drivers/dma/at_hdmac.c                             | 93 ++++++++++++++++++++--
 drivers/dma/at_hdmac_regs.h                        |  4 +
 drivers/i2c/busses/i2c-at91.c                      | 49 ++++++------
 drivers/mmc/host/atmel-mci.c                       | 25 +++---
 6 files changed, 154 insertions(+), 47 deletions(-)

-- 
1.7.11.3

