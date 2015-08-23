From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 01/11] mmc: omap: fix error return code
Date: Sun, 23 Aug 2015 02:11:12 +0200
Message-ID: <1440288682-12732-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Return a negative error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/omap.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 70dcf07..b763b11 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1420,8 +1420,10 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->reg_shift = (mmc_omap7xx() ? 1 : 2);
 
 	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
-	if (!host->mmc_omap_wq)
+	if (!host->mmc_omap_wq) {
+		ret = -ENOMEM;
 		goto err_plat_cleanup;
+	}
 
 	for (i = 0; i < pdata->nr_slots; i++) {
 		ret = mmc_omap_new_slot(host, i);
