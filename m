From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Date: Thu, 10 Jan 2013 21:29:15 +0100
Message-ID: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:43253 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309Ab3AJU3d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jan 2013 15:29:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

A NULL is a valid clk cookie, so we should not be tested with
IS_ERR_NULL(). Replace it with IS_ERR().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/mmc/host/mvsdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..d0050fa 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -839,7 +839,7 @@ out:
 	if (r)
 		release_resource(r);
 	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
+		if (!IS_ERR(host->clk)) {
 			clk_disable_unprepare(host->clk);
 			clk_put(host->clk);
 		}
-- 
1.7.10.4

