From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/3] mmc: sunxi: Fix MMC DDR modes for Allwinner A80
Date: Sun, 29 May 2016 15:04:41 +0800
Message-ID: <1464505484-3661-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

This series fixes and re-enables eMMC HS-DDR support for Allwinner A80 SoC.
The issue with the original code was the mmc clock timings were incorrect,
and thus we had disabled HS-DDR on A80 for the previous release.

Patch 1 is a fix for mmc core. Arnd's patch to remove IS_ERR_VALUE replaced
it with an incorrect check on return values, thus blocking the code path
for HS-DDR and higher timing modes. This patch instead checks for a positive
return code, which is how mmc_select_bus_width indicates a success.

Patch 2 fixes the HS-DDR clock timings for the A80.

Patch 3 re-enables HS-DDR mode for the A80.


Regards
ChenYu

Chen-Yu Tsai (3):
  mmc: fix mmc mode selection for HS-DDR and higher
  mmc: sunxi: Fix DDR MMC timings for A80
  mmc: sunxi: Re-enable eMMC HS-DDR modes on Allwinner A80

 drivers/mmc/core/mmc.c       | 4 ++--
 drivers/mmc/host/sunxi-mmc.c | 9 ++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.8.1
