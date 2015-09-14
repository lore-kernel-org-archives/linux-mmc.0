From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] mmc: pwrseq: use gpiod_get() instead of index 0
Date: Mon, 14 Sep 2015 14:00:35 +0200
Message-ID: <1442232035-32051-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The gpiod_get() function expands to gpiod_get_index() with index 0
so it's better to use it since is easier to read and more concise.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mmc/core/pwrseq_emmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index 9d6d2fb21796..137c97fb7aa8 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -76,7 +76,7 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
 	if (!pwrseq)
 		return ERR_PTR(-ENOMEM);
 
-	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
+	pwrseq->reset_gpio = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->reset_gpio)) {
 		ret = PTR_ERR(pwrseq->reset_gpio);
 		goto free;
-- 
2.4.3
