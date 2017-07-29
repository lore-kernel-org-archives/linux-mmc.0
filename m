From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 06/12] mmc: toshsd: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:35 +0200
Message-ID: <1501307981-29745-7-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/mmc/host/toshsd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 553ef41..dd961c5 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -550,7 +550,7 @@ static int toshsd_get_cd(struct mmc_host *mmc)
 	return !!(ioread16(host->ioaddr + SD_CARDSTATUS) & SD_CARD_PRESENT_0);
 }
 
-static struct mmc_host_ops toshsd_ops = {
+static const struct mmc_host_ops toshsd_ops = {
 	.request = toshsd_request,
 	.set_ios = toshsd_set_ios,
 	.get_ro = toshsd_get_ro,
