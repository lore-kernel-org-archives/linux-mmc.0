From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/4] Tegra114 Add Minimal SDHCI support
Date: Wed, 20 Feb 2013 13:35:13 -0500
Message-ID: <1361385317-6020-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patchset adds the minimal support for Tegra114 SDHCI support
and enables it for tegra114-dalmore.

This patchset is dependent on:
 - Tegra114 Clock framework (v7) from Peter De Schrijver
   ( http://patchwork.ozlabs.org/patch/220727/ ...)
 - Tegra114 Pinctrl patches (v2) I sent 2/11
   ( http://patchwork.ozlabs.org/patch/219686/
     http://patchwork.ozlabs.org/patch/219687/ )
 - mmc: tegra: assume CONFIG_OF, remove platform data
   ( https://patchwork.kernel.org/patch/2150351/)

I tested merging this with and without the mmc patches from Joseph Lo
and it merged cleanly in either case, so there shouldn't be a nasty
dependency between them.
   ( http://patchwork.ozlabs.org/patch/221969/
     http://patchwork.ozlabs.org/patch/221970/ )

Pritesh Raithatha (1):
  ARM tegra: add SDHCI nodes with common properties

Rhyland Klein (3):
  ARM: tegra: add SDHCI support for Dalmore
  mmc: host: sdhci-tegra: cleanup ifdefs
  mmc: host: sdhci-tegra: add basic support for Tegra114

 arch/arm/boot/dts/tegra114-dalmore.dts |   11 +++++++++++
 arch/arm/boot/dts/tegra114.dtsi        |   32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-tegra.c         |   22 ++++++++++++++--------
 3 files changed, 57 insertions(+), 8 deletions(-)

-- 
1.7.9.5
