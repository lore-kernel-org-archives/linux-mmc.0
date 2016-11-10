From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] mmc: tmio: allow tmio_mmc_host_alloc() to return proper error code
Date: Thu, 10 Nov 2016 22:24:23 +0900
Message-ID: <1478784263-18777-3-git-send-email-yamada.masahiro@socionext.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Now, mmc_alloc_host() returns an error pointer when it fails.
So, tmio_mmc_host_alloc() can also return an error pointer to
propagate the proper error code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sh_mobile_sdhi.c | 4 ++--
 drivers/mmc/host/tmio_mmc.c       | 4 +++-
 drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 49edff7..97a796c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -355,8 +355,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	host = tmio_mmc_host_alloc(pdev);
-	if (!host) {
-		ret = -ENOMEM;
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
 		goto eprobe;
 	}
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e897e7f..3316545 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -93,8 +93,10 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
 	host = tmio_mmc_host_alloc(pdev);
-	if (!host)
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
 		goto cell_disable;
+	}
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 18106fc..7e8c80e 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1014,7 +1014,7 @@ struct tmio_mmc_host*
 
 	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
 	if (IS_ERR(mmc))
-		return NULL;
+		return ERR_CAST(mmc);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-- 
1.9.1
