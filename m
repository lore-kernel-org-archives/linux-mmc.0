From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/5] mmc: sdhi: Add defines for platform irq indexes
Date: Tue, 16 Aug 2011 11:08:17 +0900
Message-ID: <1313460499-3377-4-git-send-email-horms@verge.net.au>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36190 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1HPCI3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2011 22:08:29 -0400
In-Reply-To: <1313460499-3377-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

This is intended to make it easier to correctly
order platform defines in platform data and
the logic that uses them.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index bd50b36..c66c58c 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -3,6 +3,10 @@
 
 #include <linux/types.h>
 
+#define SH_MOBILE_SDHI_IRQ_SDCARD	0
+#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	1
+#define SH_MOBILE_SDHI_IRQ_SDIO		2
+
 struct platform_device;
 struct tmio_mmc_data;
 
-- 
1.7.5.4

