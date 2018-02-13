From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 0/2] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 13:33:56 +0100
Message-ID: <20180213123358.13212-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
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

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/hs400-v3

Changes since v2:
* Consolidate disable_scc and reset_hs400_mode into reset_hs400_tuning
  callback
* Reuse renesas_sdhi_reset_hs400_mode() in renesas_sdhi_hw_reset()
* Factor out renesas_sdhi_reset_scc()

Changes since v1:
* Use updated code from BSP v3.6.0
* Ironed out dependencies, eMMC HS400 is now working on
  H3 / Salvator-X, M3-W 1.0 / Salvator-X and H3 ES2.0 Salvator-XS.

Masaharu Hayakawa (2):
  mmc: tmio: add eMMC HS400 mode support
  mmc: renesas_sdhi: add eMMC HS400 mode support

 drivers/mmc/host/renesas_sdhi_core.c | 133 +++++++++++++++++++++++++++++------
 drivers/mmc/host/tmio_mmc.h          |   5 ++
 drivers/mmc/host/tmio_mmc_core.c     |  24 ++++++-
 3 files changed, 138 insertions(+), 24 deletions(-)

-- 
2.11.0
