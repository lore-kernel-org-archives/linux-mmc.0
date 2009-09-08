From: thomas.ab@samsung.com
Subject: [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
Date: Tue,  8 Sep 2009 14:26:00 +0900
Message-ID: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:42647 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZIHFhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 01:37:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

In s3c64xx_setrate_clksrc() we used sclk->shift,
but actually need to use sclk->divider_shift to
correctly calculate the value for the divider register.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index febac19..c972d2f 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -302,8 +302,8 @@ static int s3c64xx_setrate_clksrc(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	val = __raw_readl(reg);
-	val &= ~(0xf << sclk->shift);
-	val |= (div - 1) << sclk->shift;
+	val &= ~(0xf << sclk->divider_shift);
+	val |= (div - 1) << sclk->divider_shift;
 	__raw_writel(val, reg);
 
 	return 0;
-- 
1.5.3.4

