From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/17] spi: pl022: Remove redundant pinctrl to default state in probe
Date: Tue,  4 Feb 2014 16:58:51 +0100
Message-ID: <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The driver core is now taking care of putting our pins into default
state at probe. Thus we can remove the redundant call for it in probe.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2f44c81..3ddd8da 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2109,8 +2109,6 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	pl022->chipselects = devm_kzalloc(dev, num_cs * sizeof(int),
 					  GFP_KERNEL);
 
-	pinctrl_pm_select_default_state(dev);
-
 	/*
 	 * Bus Number Which has been Assigned to this SSP controller
 	 * on this board
-- 
1.7.9.5
