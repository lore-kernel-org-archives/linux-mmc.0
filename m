From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/3] mmc: sh_mmcif: double clock speed
Date: Wed, 28 Mar 2012 18:01:09 +0900
Message-ID: <1332925271-23860-2-git-send-email-horms@verge.net.au>
References: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50920 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab2C1JBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:01:20 -0400
In-Reply-To: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Cao Minh Hiep <hiepcm@gmail.com>, Simon Horman <horms@verge.net.au>

Correct an off-by one error when calculating the clock divisor in cases
where the host clock is a power of two of the target clock.  Previously the
divisor was one greater than the correct value in these cases leading to
the clock being set at half the desired speed.

Thanks to Guennadi Liakhovetski for working with me on
the logic for this change.

Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>

---
v2
* Rewrite changelog
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

