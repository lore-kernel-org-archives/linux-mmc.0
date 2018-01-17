From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 12/16] mmc: tmio: support IP-builtin card detection logic
Date: Thu, 18 Jan 2018 01:28:12 +0900
Message-ID: <1516206496-16612-13-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:36662 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeAQQ3b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jan 2018 11:29:31 -0500
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

A card detect GPIO is set up only for platforms with "cd-gpios"
DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
if ctx->cd_gpio is unset.

The bit 5 of the status register provides the current signal level
of the CD line.  Allow to use it if the GPIO is unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - split out GPIO CD

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index f30ac69..b20d5c5 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1080,6 +1080,14 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 		 TMIO_STAT_WRPROTECT);
 }
 
+static int tmio_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	return !!(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+		  TMIO_STAT_SIGSTATE);
+}
+
 static int tmio_multi_io_quirk(struct mmc_card *card,
 			       unsigned int direction, int blk_size)
 {
@@ -1095,7 +1103,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
-	.get_cd		= mmc_gpio_get_cd,
+	.get_cd		= tmio_mmc_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 	.hw_reset	= tmio_mmc_hw_reset,
@@ -1248,6 +1256,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (mmc_can_gpio_ro(mmc))
 		_host->ops.get_ro = mmc_gpio_get_ro;
 
+	if (mmc_can_gpio_cd(mmc))
+		_host->ops.get_ro = mmc_gpio_get_cd;
+
 	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
-- 
2.7.4

