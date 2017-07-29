From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 09/12] mmc: sunxi: constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:38 +0200
Message-ID: <1501307981-29745-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59959 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753441AbdG2GZD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Jul 2017 02:25:03 -0400
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

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
 drivers/mmc/host/sunxi-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6adc524..fa0601c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1048,7 +1048,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 	return !!(mmc_readl(host, REG_STAS) & SDXC_CARD_DATA_BUSY);
 }
 
-static struct mmc_host_ops sunxi_mmc_ops = {
+static const struct mmc_host_ops sunxi_mmc_ops = {
 	.request	 = sunxi_mmc_request,
 	.set_ios	 = sunxi_mmc_set_ios,
 	.get_ro		 = mmc_gpio_get_ro,

