From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 01/12] mmc: wmt-sdmmc: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:30 +0200
Message-ID: <1501307981-29745-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The mmc_host_ops structure is only stored in the ops field of an
mmc_host structure, which is declared as const.  Thus the mmc_host_ops
structure itself can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct mmc_host_ops i@p = { ... };

@ok1@
struct mmc_host *mmc;
identifier r.i;
position p;
@@
mmc->ops = &i@p

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct mmc_host_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct mmc_host_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/wmt-sdmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 21ebba8..50fe69d 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -726,7 +726,7 @@ static int wmt_mci_get_cd(struct mmc_host *mmc)
 	return !(cd ^ priv->cd_inverted);
 }
 
-static struct mmc_host_ops wmt_mci_ops = {
+static const struct mmc_host_ops wmt_mci_ops = {
 	.request = wmt_mci_request,
 	.set_ios = wmt_mci_set_ios,
 	.get_ro = wmt_mci_get_ro,

