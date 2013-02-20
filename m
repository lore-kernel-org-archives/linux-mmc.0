From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] mmc: tegra: use mmc_of_parse to get support of standard MMC DT binding
Date: Wed, 20 Feb 2013 15:05:00 +0800
Message-ID: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The 2nd patch of this series depends on two patches below.

"mmc: provide a standard MMC device-tree binding parser centrally"
(available on next-20130219)
mmc: tegra: assume CONFIG_OF, remove platform data
(https://patchwork.kernel.org/patch/2150351/)

Verified on Seaboard and Cardhu.

Joseph Lo (2):
  ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host
  mmc: tegra: use mmc_of_parse to get the support of standard MMC DT
    bindings

 arch/arm/boot/dts/tegra20-harmony.dts   |  4 +-
 arch/arm/boot/dts/tegra20-paz00.dts     |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts  |  2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts   |  2 +-
 arch/arm/boot/dts/tegra20-whistler.dts  |  1 +
 arch/arm/boot/dts/tegra30-beaver.dts    |  2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi   |  2 +-
 drivers/mmc/host/sdhci-tegra.c          | 85 +++------------------------------
 9 files changed, 16 insertions(+), 86 deletions(-)

-- 
1.8.1.1
