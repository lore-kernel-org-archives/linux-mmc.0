From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 10/22] mmc: tmio: support IP-builtin card detection logic
Date: Sat, 25 Nov 2017 01:24:45 +0900
Message-ID: <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:61404 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdKXQZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 11:25:58 -0500
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

A card detect GPIO is set up only for platforms with "cd-gpios"
DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
if ctx->cd_gpio is unset.

The bit 5 of the status register provides the current signal level
of the CD line.  Allow to use it if the GPIO is unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 610f26f..b51bb06 100644
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

