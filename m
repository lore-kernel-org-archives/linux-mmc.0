From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 0/3] dra7/omap4/omap5: Enable ADMA2
Date: Wed, 18 May 2016 14:15:12 +0530
Message-ID: <1463561115-31798-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, peter.ujfalusi@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add ADMA2 support in omap hsmmc driver. It's not added as
a dma engine since ADMA2 is only implemented in HSMMC.

Though this doesn't improve the throughput with high speed
cards, around 25% improvement is seen with HS200 card.

HS200 support is not yet added in OMAP HSMMC since
it has dependency with IODelay driver which is not yet
upstreamed.

Tested MMC1 and MMC2 in DRA7 (dra72-evm, dra7-evm) and OMAP5
(omap5-uevm).
Also tested having rootfs in MMC1 in DRA7, OMAP5, OMAP4 and OMAP3.

Kishon Vijay Abraham I (3):
  mmc: host: omap_hsmmc: remove *use_dma* member
  mmc: host: omap_hsmmc: Enable ADMA2
  ARM: dts: dra7/omap4/omap5: Enable ADMA2

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
 arch/arm/boot/dts/dra7.dtsi                        |    4 +
 arch/arm/boot/dts/omap4.dtsi                       |    2 +
 arch/arm/boot/dts/omap5.dtsi                       |    4 +
 drivers/mmc/host/omap_hsmmc.c                      |  332 +++++++++++++++-----
 include/linux/platform_data/hsmmc-omap.h           |    1 +
 6 files changed, 269 insertions(+), 75 deletions(-)

-- 
1.7.9.5
