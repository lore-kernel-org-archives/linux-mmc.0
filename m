From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] mmc: tmio: support IP-builtin card detection logic
Date: Wed,  8 Nov 2017 19:17:00 +0900
Message-ID: <1510136220-31853-4-git-send-email-yamada.masahiro@socionext.com>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

A card detect GPIO is set up only for platforms with "cd-gpios"
DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
if ctx->cd_gpio is unset.

The bit 5 of the status register provides the current signal level
of the CD line.  Allow to use it if the GPIO is unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9fd0874..85a2944 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1087,6 +1087,19 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	return ret;
 }
 
+static int tmio_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = mmc_gpio_get_cd(mmc);
+	if (ret >= 0)
+		return ret;
+
+	return !!(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+							TMIO_STAT_SIGSTATE);
+}
+
 static int tmio_multi_io_quirk(struct mmc_card *card,
 			       unsigned int direction, int blk_size)
 {
@@ -1102,7 +1115,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
-	.get_cd		= mmc_gpio_get_cd,
+	.get_cd		= tmio_mmc_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 	.hw_reset	= tmio_mmc_hw_reset,
-- 
2.7.4
