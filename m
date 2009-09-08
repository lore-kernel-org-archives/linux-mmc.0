From: thomas.ab@samsung.com
Subject: [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
Date: Tue,  8 Sep 2009 14:40:01 +0900
Message-ID: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:52422 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZIHFrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 01:47:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch removes the redundant MPLL parent assignment
in the function s3c6400_register_clocks.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 9745852..72c03ab 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -758,6 +758,5 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 		}
 	}
 
-	clk_mpll.parent = &clk_mout_mpll.clk;
 	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.5.3.4

