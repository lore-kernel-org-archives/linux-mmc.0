From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 2/3] mmc: sunxi: Fix DDR MMC timings for A80
Date: Sun, 29 May 2016 15:04:43 +0800
Message-ID: <1464505484-3661-3-git-send-email-wens@csie.org>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464505484-3661-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The MMC clock timings were incorrectly calculated, when the conversion
from delay value to delay phase was done.

The 50M DDR and 50M DDR 8bit timings are off, and make eMMC DDR
unusable. Unfortunately it seems different controllers on the same SoC
have different timings. The new settings are taken from mmc2, which is
commonly used with eMMC.

The settings for the slower timing modes seem to work despite being
wrong, so leave them be.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7fc8b7aa83f0..5873dc344ab2 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -970,8 +970,8 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
 	[SDXC_CLK_50M]		= { .output = 150, .sample = 120 },
-	[SDXC_CLK_50M_DDR]	= { .output =  90, .sample = 120 },
-	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 120 },
+	[SDXC_CLK_50M_DDR]	= { .output =  54, .sample =  36 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  72, .sample =  72 },
 };
 
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
-- 
2.8.1
