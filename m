From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 76/95] mmc: core: complete HS400 before checking status
Date: Wed, 26 Jun 2019 20:30:01 -0400
Message-ID: <20190627003021.19867-76-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit b0e370b95a3b231d0fb5d1958cce85ef57196fe6 ]

We don't have a reproducible error case, yet our BSP team suggested that
the mmc_switch_status() command in mmc_select_hs400() should come after
the callback into the driver completing HS400 setup. It makes sense to
me because we want the status of a fully setup HS400, so it will
increase the reliability of the mmc_switch_status() command.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: ba6c7ac3a2f4 ("mmc: core: more fine-grained hooks for HS400 tuning")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3e786ba204c3..671bfcceea6a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1212,13 +1212,13 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
+	if (host->ops->hs400_complete)
+		host->ops->hs400_complete(host);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
 
-	if (host->ops->hs400_complete)
-		host->ops->hs400_complete(host);
-
 	return 0;
 
 out_err:
-- 
2.20.1
