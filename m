From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 07/15] mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
Date: Thu, 21 Jan 2016 13:26:34 +0800
Message-ID: <1453354002-28366-8-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

Now that clock delay settings for 8 bit DDR are correct, and vqmmc
support is available, we can enable MMC_CAP_1_8V_DDR support. This
enables MMC HS-DDR at up to 52 MHz, even if signal voltage switching
is not available.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d05928091b34..f3a7f36e38c2 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1145,6 +1145,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 50000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
 	ret = mmc_of_parse(mmc);
-- 
2.7.0.rc3
