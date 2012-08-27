From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 7/13] drivers/mmc/host/mmci.c: use clk_prepare_enable
 and clk_disable_unprepare
Date: Mon, 27 Aug 2012 14:55:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1208271453510.2079@hadrien>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr> <1345996865-32082-8-git-send-email-Julia.Lawall@lip6.fr> <CAPDyKFpf+PzMspT7CECpd=ZVdmp=7i4-pr-6StK8N1aRczNryw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:49278 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274Ab2H0MzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 08:55:13 -0400
In-Reply-To: <CAPDyKFpf+PzMspT7CECpd=ZVdmp=7i4-pr-6StK8N1aRczNryw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Chris Ball <cjb@laptop.org>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Simplify clock code in probe.

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
v2, try to avoid whitespace problem

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

