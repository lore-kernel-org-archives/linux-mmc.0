From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 15/22] mmc: tmio: change bus_shift to unsigned int
Date: Sat, 25 Nov 2017 01:24:50 +0900
Message-ID: <1511540697-27387-16-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Sane values for bus_shift are:
   0 - for 16 bit bus
   1 - for 32 bit bus
   2 - for 64 bit bus

"unsigned long" is too much.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/tmio_mmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9f083dc..27894474 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -139,7 +139,7 @@ struct tmio_mmc_host {
 	struct scatterlist      *sg_orig;
 	unsigned int            sg_len;
 	unsigned int            sg_off;
-	unsigned long		bus_shift;
+	unsigned int		bus_shift;
 
 	struct platform_device *pdev;
 	struct tmio_mmc_data *pdata;
-- 
2.7.4
