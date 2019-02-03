From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC
 controller by default
Date: Sun,  3 Feb 2019 23:56:26 +0800
Message-ID: <20190203155628.16767-2-wens@csie.org>
References: <20190203155628.16767-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBMM63TRAKGQEA2WX5XQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190203155628.16767-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Some H5 boards seem to not have proper trace lengths for eMMC to be able
to use the default setting for the delay chains under HS-DDR mode. These
include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
Computer ALL-H3-CC-H5 works just fine.

For the H5 (at least for now), default to not enabling HS-DDR modes in
the driver, and expect the device tree to signal HS-DDR capability on
boards that work.

Reported-by: Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 279e326e397e..7415af8c8ff6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays || host->use_new_timings)
+	/*
+	 * Some H5 devices do not have signal traces precise enough to
+	 * use HS DDR mode for their eMMC chips.
+	 *
+	 * We still enable HS DDR modes for all the other controller
+	 * variants that support them.
+	 */
+	if ((host->cfg->clk_delays || host->use_new_timings) &&
+	    !of_device_is_compatible(pdev->dev.of_node,
+				     "allwinner,sun50i-h5-emmc"))
 		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.20.1
