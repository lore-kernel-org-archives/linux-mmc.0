From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Thu, 7 Jul 2011 00:47:46 +0800
Message-ID: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:30634
	"EHLO CH1EHSOBE018.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754809Ab1GFQlt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 12:41:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The first patch copies platform data into driver private data, and
do not reference platform data after probe.  The second one removes
the uses of cpu_is_mx().  The third one makes a dt related fix on
sdhci-pltfm.c, and the last one adds actual device tree probe for
sdhci-esdhc-imx driver.

Changes since v2:
 * Add patch #1
 * Do not use Linux details of cd-type and wp-type for binding

Changes since v1:
 * Address review comments given by Grant

Shawn Guo (4):
      mmc: sdhci-esdhc-imx: do not reference platform data after probe
      mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
      mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
      mmc: sdhci-esdhc-imx: add device tree probe support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   34 +++++
 arch/arm/mach-imx/clock-imx25.c                    |    4 +-
 arch/arm/mach-imx/clock-imx35.c                    |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   16 +-
 arch/arm/mach-mx5/mx51_efika.c                     |    4 +-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   17 ++-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  151 +++++++++++++++++---
 drivers/mmc/host/sdhci-pltfm.c                     |    3 +-
 9 files changed, 194 insertions(+), 42 deletions(-)

