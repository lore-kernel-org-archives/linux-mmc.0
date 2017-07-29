From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 10/12] mmc: sdricoh_cs: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:39 +0200
Message-ID: <1501307981-29745-11-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Sommer <saschasommer@freenet.de>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/mmc/host/sdricoh_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 70cb00a..9e46039 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -385,7 +385,7 @@ static int sdricoh_get_ro(struct mmc_host *mmc)
 	return (status & STATUS_CARD_LOCKED);
 }
 
-static struct mmc_host_ops sdricoh_ops = {
+static const struct mmc_host_ops sdricoh_ops = {
 	.request = sdricoh_request,
 	.set_ios = sdricoh_set_ios,
 	.get_ro = sdricoh_get_ro,
