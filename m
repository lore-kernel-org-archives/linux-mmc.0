From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Add device tree probe for sdhci-esdhc-imx
Date: Sun,  3 Jul 2011 16:30:48 +0800
Message-ID: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40214 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab1GCIUP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2011 04:20:15 -0400
Received: by iyb12 with SMTP id 12so3779922iyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2011 01:20:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org

The first patch removes the uses of cpu_is_mx(), and can be merged
right away when review gets done.

The second patch makes an independent fix on sdhci-pltfm.c which can
be merged if it looks right to the gate keeper.

The third patch adds device tree probe.  It uses the newly added dt
api of_property_read_string which is sitting on Grant's devicetree/next
branch with the out_string 'const' thing as a question mark.

Shawn Guo (3):
      mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
      mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
      mmc: sdhci-esdhc-imx: add device tree probe support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   40 ++++++
 arch/arm/mach-imx/clock-imx25.c                    |    4 +-
 arch/arm/mach-imx/clock-imx35.c                    |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   16 +-
 arch/arm/mach-mx5/mx51_efika.c                     |    4 +-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   17 ++-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  144 ++++++++++++++++++--
 drivers/mmc/host/sdhci-pltfm.c                     |    3 +-
 9 files changed, 202 insertions(+), 33 deletions(-)
