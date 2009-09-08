From: thomas.ab@samsung.com
Subject: [PATCH 2/4] s3c6410: update clk->parent when setting clock source
Date: Tue,  8 Sep 2009 14:30:48 +0900
Message-ID: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:50464 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZIHFmM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 01:42:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This ensures the clock hierarchy data structures are
updated when we change the clock source in the actual
hardware registers.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index c972d2f..54eef93 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -328,6 +328,8 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
 		clksrc |= src_nr << sclk->shift;
 
 		__raw_writel(clksrc, S3C_CLK_SRC);
+
+		clk->parent = parent;
 		return 0;
 	}
 
-- 
1.5.3.4

