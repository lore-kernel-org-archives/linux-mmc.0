From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/6] ARM: at91: move to generic DMA device tree binding
Date: Fri, 19 Apr 2013 11:11:17 +0200
Message-ID: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Hi,

I resend the set of patches due to minor fixes. I think patches will go through
different subsytems.

Patch 1/6: dma subsystem
Patch 2/6, 4/6, 6/6: arm-soc
Patch 3/6: i2c subsystem, already taken by Wolfram, thx.
Patch 5/6: mmc subsystem

v3 changes:
- compile at_dma_filter function only if CONFIG_OF is set since it is only used
in at_dma_xlate
- remove trailing whitespaces in patch 5/6

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
