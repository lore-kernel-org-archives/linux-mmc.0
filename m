From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/17] i2c: nomadik: Remove redundant call to pm_runtime_disable
Date: Tue,  4 Feb 2014 16:58:53 +0100
Message-ID: <1391529538-21685-13-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The amba bus are responsible for pm_runtime_enable|disable, remove the
redundant pm_runtime_disable at driver removal.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 840bcf9..42c9e51 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1105,7 +1105,6 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	pm_runtime_disable(&adev->dev);
 
 	return 0;
 }
-- 
1.7.9.5
