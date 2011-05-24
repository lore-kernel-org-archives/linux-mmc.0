From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] ARM: mach-shmobile: mark DMA slave ID 0 as invalid
Date: Tue, 24 May 2011 12:24:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105241220240.31628@axis700.grange>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62983 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1EXKYG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 06:24:06 -0400
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

This makes it possible to leave DMA slave IDs in the platform data
at default 0 value without hitting DMA channel allocation error paths.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 6a290b7..75076b1 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -436,6 +436,7 @@ enum {
 
 /* DMA slave IDs */
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
-- 
1.7.2.5

