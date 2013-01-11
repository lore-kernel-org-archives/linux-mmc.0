From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] mmc: mvsdio: Replace IS_ERR_OR_NULL() with IS_ERR()
Date: Fri, 11 Jan 2013 08:27:52 +0100
Message-ID: <1357889273-11553-1-git-send-email-andrew@lunn.ch>
References: <20130111004323.GA12257@schnuecks.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:44475 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570Ab3AKH2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Jan 2013 02:28:10 -0500
In-Reply-To: <20130111004323.GA12257@schnuecks.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, gmbnomis@gmail.com, Andrew Lunn <andrew@lunn.ch>

A NULL is a valid clk cookie, so we should not be tested with
IS_ERR_OR_NULL(). Replace it with IS_ERR().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

This patch depends on Thomas Petazzoni DT patches for mvsdio, which changed
the order of resource allocation etc.

Simon

You are correct about the indentation. As suggested, i moved the
disable_unprepare() inside if (host).

It should no longer be possible to have imbalanced clk operations:

If mmc_alloc_host() fails, it goes to out. host is NULL, no clk calls.
All other goto out occur after the clk_get() and when host is !NULL. clk
calls are then made when !IS_ERR(host->clk), keeping this balanced.

 drivers/mmc/host/mvsdio.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index feb16bd..196f085 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -818,14 +818,14 @@ out:
 		mmc_gpio_free_ro(mmc);
 		if (host->base)
 			iounmap(host->base);
+		if (!IS_ERR(host->clk)) {
+			clk_disable_unprepare(host->clk);
+			clk_put(host->clk);
+		}
 	}
 	if (r)
 		release_resource(r);
 	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
-			clk_disable_unprepare(host->clk);
-			clk_put(host->clk);
-		}
 		mmc_free_host(mmc);
 
 	return ret;
-- 
1.7.10.4

