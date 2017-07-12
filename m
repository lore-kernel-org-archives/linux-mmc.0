From: Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 0/3] Add MMCIF0 support for r8a7743/iwg20m
Date: Wed, 12 Jul 2017 11:03:22 +0100
Message-ID: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Paterson <chris.paterson2@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This series adds MMCIF0 support for the r8a7743 SoC and the iWave-RZG1M-20M
Qseven SOM.

This series is based on renesas-devel-20170711-v4.12.

Chris Paterson (3):
  dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings
  ARM: dts: r8a7743: Add MMCIF0 support
  ARM: dts: iwg20m: Add MMCIF0 support

 .../devicetree/bindings/mmc/renesas,mmcif.txt      |  3 ++-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     | 16 +++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
1.9.1
