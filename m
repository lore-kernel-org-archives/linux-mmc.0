From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 0/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Fri, 19 Jan 2018 14:39:03 +0100
Message-ID: <20180119133906.11280-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

this patch-set provides SDHI driver support for eMMC HS400.

Based on mmc/next

Dependencies for applying these patches: none

Dependencies to test eMMC HS400:
* [PATCH] clk: renesas: rcar-gen3: Fix SD divider setting
* [PATCH v2] arm64: dts: salvator-common: Enable HS400 of SDHI2

To assist testing and review this patch and the above mentioned
dependencies, which are necessary and sufficient to enable HS400 on H3 /
Salvator-X, M3-W 1.0 / Salvator-X and H3 ES2.0 Salvator-XS are available
at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/hs400-v2

Changes since v2:
* Use updated code from BSP v3.6.0
* Ironed out dependencies, eMMC HS400 is now working on
  H3 / Salvator-X, M3-W 1.0 / Salvator-X and H3 ES2.0 Salvator-XS.


Masaharu Hayakawa (3):
  mmc: tmio: correct treatment of errors during tuning
  mmc: tmio: add eMMC HS400 mode support
  mmc: renesas_sdhi: add eMMC HS400 mode support

 drivers/mmc/host/renesas_sdhi_core.c | 125 ++++++++++++++++++++++++++++++-----
 drivers/mmc/host/tmio_mmc.h          |   6 ++
 drivers/mmc/host/tmio_mmc_core.c     |  33 +++++++--
 3 files changed, 143 insertions(+), 21 deletions(-)

-- 
2.11.0
