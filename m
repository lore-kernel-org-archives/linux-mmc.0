From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 6/6] mmc: tmio: move mmc_of_parse() out of tmio_mmc_host_probe()
Date: Tue,  7 Nov 2017 17:09:32 +0900
Message-ID: <1510042172-27220-7-git-send-email-yamada.masahiro@socionext.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

mmc_of_parse() parses various DT properties and sets capability flags
accordingly.  However, drivers have no chance to run platform init
code depending on such flags because mmc_of_parse() is called from
tmio_mmc_host_probe().

Move mmc_of_parse() out of tmio_mmc_host_probe() so that drivers can
handle capabilities before mmc_add_host().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c | 4 ++++
 drivers/mmc/host/tmio_mmc.c          | 4 ++++
 drivers/mmc/host/tmio_mmc_core.c     | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7bb0252..4658fb5 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -526,6 +526,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!host)
 		return -ENOMEM;
 
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto efree;
+
 	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ccfbc15..87052b3 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -96,6 +96,10 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (!host)
 		goto cell_disable;
 
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto host_free;
+
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 695b4f4..c2f759b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1188,10 +1188,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (IS_ERR(_host->ctl))
 		return PTR_ERR(_host->ctl);
 
-	ret = mmc_of_parse(mmc);
-	if (ret < 0)
-		return ret;
-
 	_host->pdata = pdata;
 	platform_set_drvdata(pdev, _host);
 
-- 
2.7.4
