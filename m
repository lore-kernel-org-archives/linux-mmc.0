From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Add device tree probe for sdhci-esdhc-imx
Date: Tue, 5 Jul 2011 23:26:05 +0800
Message-ID: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:50437
	"EHLO CH1EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214Ab1GEPT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 11:19:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org

The first patch removes the uses of cpu_is_mx(), the second one makes
a dt related fix on sdhci-pltfm.c, and the third one adds device tree
probe for sdhci-esdhc-imx driver.

Changes since v1:
 * Address review comments given by Grant

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

