From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
Date: Fri, 22 Jun 2018 15:46:14 +0530
Message-ID: <20180622101617.11157-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>, kishon@ti.com
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
binding.

I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
Everyone who use a custom .config should also enable
CONFIG_MMC_SDHCI_OMAP for MMC to work.

Kishon Vijay Abraham I (3):
  ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
  ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
  ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

 arch/arm/boot/dts/keystone-k2g-evm.dts | 10 ++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 12 ++++--------
 arch/arm/configs/keystone_defconfig    |  3 +++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1
