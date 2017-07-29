From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 03/12] mmc: davinci: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:32 +0200
Message-ID: <1501307981-29745-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/mmc/host/davinci_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 621ce47..351330d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1062,7 +1062,7 @@ static void mmc_davinci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
-static struct mmc_host_ops mmc_davinci_ops = {
+static const struct mmc_host_ops mmc_davinci_ops = {
 	.request	= mmc_davinci_request,
 	.set_ios	= mmc_davinci_set_ios,
 	.get_cd		= mmc_davinci_get_cd,
