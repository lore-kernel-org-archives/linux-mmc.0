From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v4 0/3] mmc: sh_mobile_sdhi: fix missing r7s72100 clocks
Date: Fri, 20 Jan 2017 14:43:29 -0500
Message-ID: <20170120194332.1683-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

At first this started out as a simple typo fix, until I realized
that the SDHI in the RZ/A1 has 2 clocks per channel and both need
to be turned on/off.

This patch series adds the ability to specify 2 clocks instead of
just 1, and does so for the RZ/A1 r7s72100.

This patch has been tested on an RZ/A1 RSK board. Card detect works
fine as well as bind/unbind.

v4:
* No code changes, only text udpates to explain why there are 2 clocks
  and why we need to treat them as 1 clock.


Chris Brandt (3):
  mmc: sh_mobile_sdhi: add support for 2 clocks
  mmc: sh_mobile_sdhi: explain clock bindings
  ARM: dts: r7s72100: update sdhi clock bindings

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 28 ++++++++++++++++++++++
 arch/arm/boot/dts/r7s72100.dtsi                    | 17 +++++++++----
 drivers/mmc/host/sh_mobile_sdhi.c                  | 13 ++++++++++
 include/dt-bindings/clock/r7s72100-clock.h         |  6 +++--
 4 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.10.1
