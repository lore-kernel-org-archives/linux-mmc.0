From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/13] drivers/mmc/host/mmci.c: use clk_prepare_enable and clk_disable_unprepare
Date: Sun, 26 Aug 2012 18:00:59 +0200
Message-ID: <1345996865-32082-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
clk_enable, and clk_disable and clk_unprepare.  They make the code more
concise, and ensure that clk_unprepare is called when clk_enable fails.

A simplified version of the semantic patch that introduces calls to these
functions is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

- clk_prepare(e);
- clk_enable(e);
+ clk_prepare_enable(e);

@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/mmci.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50ff19a..edc3e9b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1309,14 +1309,10 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		goto host_free;
 	}
 
-	ret = clk_prepare(host->clk);
+	ret = clk_prepare_enable(host->clk);
 	if (ret)
 		goto clk_free;
 
-	ret = clk_enable(host->clk);
-	if (ret)
-		goto clk_unprep;
-
 	host->plat = plat;
 	host->variant = variant;
 	host->mclk = clk_get_rate(host->clk);
@@ -1515,9 +1511,7 @@ static int __devinit mmci_probe(struct amba_device *dev,
  err_gpio_cd:
 	iounmap(host->base);
  clk_disable:
-	clk_disable(host->clk);
- clk_unprep:
-	clk_unprepare(host->clk);
+	clk_disable_unprepare(host->clk);
  clk_free:
 	clk_put(host->clk);
  host_free:
@@ -1564,8 +1558,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 			gpio_free(host->gpio_cd);
 
 		iounmap(host->base);
-		clk_disable(host->clk);
-		clk_unprepare(host->clk);
+		clk_disable_unprepare(host->clk);
 		clk_put(host->clk);
 
 		if (host->vcc)
