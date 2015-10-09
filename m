From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 0/5] Armada 38x SDHCI driver improvements
Date: Fri,  9 Oct 2015 03:03:50 +0200
Message-ID: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com
List-Id: linux-mmc@vger.kernel.org

Hi,

I send a second round of remaining A38x SDHCI patches. After lots of
discussions I changed card detection mechanism to SW polling in order
to satisfy all A388-GP revisions. Any remarks will be welcome.

Best regards,
Marcin

Changes:
v1 -> v2
* enable SW polling as card detection
* in resume function change condition for mbus windows reconfiguration 

Marcin Wojtas (5):
  mmc: sdhci-pxav3: enable proper resuming on Armada 38x SoC
  mmc: sdhci-pxav3: enable usage of DAT3 pin as HW card detect
  ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
  mmc: sdhci: add init_card callback to sdhci
  mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card
    initialization

 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  5 ++
 arch/arm/boot/dts/armada-388-gp.dts                |  2 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 94 +++++++++++++++++-----
 drivers/mmc/host/sdhci.c                           | 14 +++-
 drivers/mmc/host/sdhci.h                           |  4 +
 5 files changed, 95 insertions(+), 24 deletions(-)

-- 
1.8.3.1
