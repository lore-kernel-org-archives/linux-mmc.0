From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 0/6] mmc: imx: a few fixes and new feature
Date: Wed, 29 Jul 2015 17:03:51 +0800
Message-ID: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: johan.derycke@barco.com, haibo.chen@freescale.com, fabio.estevam@freescale.com, b29396@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Changes for v3:
-Add property describe in binding doc.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: add compatible string in bingding doc
  mmc: sdhci-esdhc-imx: config watermark level and burst length
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  2 +
 arch/arm/boot/dts/imx7d-sdb.dts                    | 13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 97 +++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |  1 +
 4 files changed, 112 insertions(+), 1 deletion(-)

-- 
1.9.1
