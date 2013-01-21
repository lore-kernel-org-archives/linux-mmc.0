From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/6] sdhci-esdhc-imx: 8bit mmc support
Date: Mon, 21 Jan 2013 19:02:23 +0800
Message-ID: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:8513
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab3AUKe2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

The series makes Auto CMD23 work for imx6q usdhc and then adds 8bit
mmc support.

Sascha Hauer (2):
  mmc: sdhci: rename platform_8bit_width to platform_bus_width
  mmc: sdhci-esdhc-imx: support 8bit mode

Shawn Guo (4):
  mmc: sdhci-esdhc-imx: separate transfer mode from command write for
    usdhc
  mmc: sdhci-esdhc-imx: manually reset MIX_CTRL for usdhc
  mmc: sdhci-esdhc-imx: Auto CMD23 support for usdhc
  mmc: dt: bus-width can be an optional property

 Documentation/devicetree/bindings/mmc/mmc.txt |    5 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            |   98 +++++++++++++++++++++----
 drivers/mmc/host/sdhci-pci.c                  |    4 +-
 drivers/mmc/host/sdhci-pxav2.c                |    2 +-
 drivers/mmc/host/sdhci-s3c.c                  |    8 +-
 drivers/mmc/host/sdhci-tegra.c                |    4 +-
 drivers/mmc/host/sdhci.c                      |    8 +-
 drivers/mmc/host/sdhci.h                      |    2 +-
 include/linux/platform_data/mmc-esdhc-imx.h   |    1 +
 9 files changed, 101 insertions(+), 31 deletions(-)

-- 
1.7.9.5


