From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 06/25] mmc: make MAN_BKOPS_EN message a debug
Date: Fri, 22 Mar 2019 16:43:57 +0100
Message-ID: <20190322154425.3852517-7-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, hongjiefang <hongjiefang@asrmicro.com>, Simon Horman <horms+renesas@verge.net.au>, Jennifer Dahm <jennifer.dahm@ni.com>, Yinbo Zhu <yinbo.zhu@nxp.com>, Avri Altman <avri.altman@wdc.com>, Kyle Roeschley <kyle.roeschley@ni.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

IMO this info is only useful for developers. Most users won't need this
information, since there is not much they can do about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 4ec96b4cbde8d5714a4477b5a2562c3dd40bc5fa)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a31789be0840..adc3291e9d6a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -508,7 +508,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
 			if (!card->ext_csd.man_bkops_en)
-				pr_info("%s: MAN_BKOPS_EN bit is not set\n",
+				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
 		}
 
-- 
2.20.0
