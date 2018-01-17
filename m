From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 06/16] mmc: tmio: refactor .get_ro hook
Date: Thu, 18 Jan 2018 01:28:06 +0900
Message-ID: <1516206496-16612-7-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This IP provides the write protect signal level in the status
register, but it is also possible to use GPIO for WP.  They are
exclusive, so it is not efficient to call mmc_gpio_get_ro() every
time from tmio_mmc_get_ro() if we know gpio_ro is not used.

Check the capability of gpio_ro just once in the probe function,
then set mmc_gpio_get_ro to .get_ro if it is the case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index d092b0f..0032707 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1076,15 +1076,9 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
-	int ret = mmc_gpio_get_ro(mmc);
 
-	if (ret >= 0)
-		return ret;
-
-	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
-
-	return ret;
+	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
+		 (sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 }
 
 static int tmio_multi_io_quirk(struct mmc_card *card,
@@ -1247,6 +1241,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	}
 	mmc->max_seg_size = mmc->max_req_size;
 
+	if (mmc_can_gpio_ro(mmc))
+		_host->ops.get_ro = mmc_gpio_get_ro;
+
 	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
-- 
2.7.4
