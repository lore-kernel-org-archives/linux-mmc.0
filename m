From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v7 00/11] ARM, arm64: renesas: Enable UHS-I SDR-104
Date: Tue, 13 Sep 2016 12:56:57 +0200
Message-ID: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this series enables SDHI UHS-I SDR-104 on:
* r8a7790/lager
* r8a7791/koelsch
* r8a7794/alt
* r8a7795/salvator-x
* r8a7796/salvator-x

It is based on renesas-next-20160908-v4.8-rc1.


For functional SDR-104 support the following dependencies are needed:
* [PATCH v7 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
* [PATCH/RFT,v2,2/8] clk: renesas: r8a7796: Add SDIF clocks
* [PATCH] pinctrl: sh-pfc: r8a7796: Add voltage switch operations for SDHI
* [PATCH v2 0/3] pinctrl: sh-pfc: r8a779[14]: Implement voltage switching for SDHI

To aid review the following git branches are provided:
* This patchset:
  https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-integration-v7
* This patch-set and above dependencies
  https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-v7

Furthermore DMA support for R-Car Gen3 is need to achive higher
transfer rates on the r8a7795 and r8a7796. For convenience a
branch containing a merge of topic/sdr104-v7 (see above) and
"[PATCH/RFC v3 0/6] mmc: renesas_sdhi: add R-Car Gen-3 DMA support"
(rebased) is provided as:

* https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-v7+sdhi-dma-v3

Simon Horman (10):
  ARM: dts: lager: Enable UHS-I SDR-104
  arm64: dts: r8a7795: salvator-x: Enable UHS-I SDR-104
  ARM: dts: r8a7791: set maximum frequency for SDHI clocks
  ARM: dts: koelsch: Enable UHS-I SDR-50 and SDR-104
  ARM: dts: r8a7794: set maximum frequency for SDHI clocks
  ARM: dts: alt: Enable UHS-I SDR-50 and SDR-104
  arm64: dts: r8a7796: add SDHI nodes
  arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3
  arm64: dts: r8a7796: salvator-x: enable UHS for SDHI 0 & 3
  arm64: dts: r8a7796: salvator-x: Enable UHS-I SDR-104

Wolfram Sang (1):
  arm64: dts: r8a7795: salvator-x: enable UHS for SDHI 0 & 3

 arch/arm/boot/dts/r8a7790-lager.dts                |   1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  34 ++++++-
 arch/arm/boot/dts/r8a7791.dtsi                     |   3 +
 arch/arm/boot/dts/r8a7794-alt.dts                  |  23 ++++-
 arch/arm/boot/dts/r8a7794.dtsi                     |   3 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  24 ++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 104 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  42 +++++++++
 8 files changed, 227 insertions(+), 7 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
