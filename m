From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/2] mmc: sh_mmcif: double clock speed
Date: Wed, 21 Mar 2012 18:02:28 +0900
Message-ID: <1332320549-28584-2-git-send-email-horms@verge.net.au>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41242 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2CUJCl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 05:02:41 -0400
In-Reply-To: <1332320549-28584-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

This corrects an off-by one error when calculating the clock divisor.
The code previously assumed that for example a divisor of 2 is
set using a value of 0001 (the inverse of 1/2), a divisor of 4 is
set using a value of 0010 (the inverse of 1/4) etc.. However, the correct
values are 0000, 0001, etc...

The use of DIV_ROUND_UP() was suggested by Guennadi Liakhovetski to avoid
understating the divisor by one in the case where the host clock is not a
binary power of the MMCIF clock.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mmcif.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8057bf3..5014bc4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -453,7 +453,8 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
 	else
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
-				((fls(host->clk / clk) - 1) << 16));
+				((fls(DIV_ROUND_UP(host->clk,
+						   clk) - 1) - 1) << 16));
 
 	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
 }
-- 
1.7.6.3

