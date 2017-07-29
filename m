From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 12/12] mmc: bcm2835: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:41 +0200
Message-ID: <1501307981-29745-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42093 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753455AbdG2GZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Jul 2017 02:25:04 -0400
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

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
 drivers/mmc/host/bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index abba9a2..229dc18 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1252,7 +1252,7 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mutex_unlock(&host->mutex);
 }
 
-static struct mmc_host_ops bcm2835_ops = {
+static const struct mmc_host_ops bcm2835_ops = {
 	.request = bcm2835_request,
 	.set_ios = bcm2835_set_ios,
 	.hw_reset = bcm2835_reset,

