From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 10/16] mmc: tmio: remove TMIO_MMC_WRPROTECT_DISABLE
Date: Thu, 18 Jan 2018 01:28:10 +0900
Message-ID: <1516206496-16612-11-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The use of this flag has been replaced with MMC_CAP2_NO_WRITE_PROTECT.
No platform defines this flag any more.  Remove.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 5 ++---
 include/linux/mfd/tmio.h         | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index bdbff2d..7ad3433c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1075,10 +1075,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
 
-	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		 (sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+		 TMIO_STAT_WRPROTECT);
 }
 
 static int tmio_multi_io_quirk(struct mmc_card *card,
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 396a103c..91f9221 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -36,7 +36,6 @@
 	} while (0)
 
 /* tmio MMC platform flags */
-#define TMIO_MMC_WRPROTECT_DISABLE	BIT(0)
 /*
  * Some controllers can support a 2-byte block size when the bus width
  * is configured in 4-bit mode.
-- 
2.7.4
