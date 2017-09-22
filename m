From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [RFC PATCH] mmc: tmio: check mmc_regulator_get_supply return value
Date: Fri, 22 Sep 2017 12:22:17 +0100
Message-ID: <1506079337-12882-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, kuninori.morimoto.gx@renesas.com, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

mmc_regulator_get_supply returns -EPROBE_DEFER if either vmmc or
vqmmc regulators had their probing deferred.
vqmmc regulator is needed by UHS to work properly, therefore this
patch checks the value returned by mmc_regulator_get_supply to
make sure we have a reference to both vmmc and vqmmc (if found in
the DT).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---

I believe this patch is in order for UHS to work properly on the RZ/G1 platforms
as the signal voltage needs to be switched from 3.3V to 1.8V, and therefore we
need to make sure we hold a reference to vqmmc. Without this patch there is a
chance that the regulator driver gets probed later on and therefore we end up
without control over the power regulator. I have seen an RZ/G1E based platform
failing the transition to UHS because of this.
However, there are side effects to it as the mmc devices will be enumerated
in a different order (due to -EPROBE_DEFER), this means this patch would likely
break existing platforms.
Please, let me know your comments.

 drivers/mmc/host/tmio_mmc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 88a9435..3df0413 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1153,8 +1153,11 @@ static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 {
 	struct tmio_mmc_data *pdata = host->pdata;
 	struct mmc_host *mmc = host->mmc;
+	int err;
 
-	mmc_regulator_get_supply(mmc);
+	err = mmc_regulator_get_supply(mmc);
+	if (err)
+		return err;
 
 	/* use ocr_mask if no regulator */
 	if (!mmc->ocr_avail)
-- 
2.7.4
