From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v11 1/7] mmc: omap_hsmmc: compile fix for !CONFIG_OF build
Date: Fri,  9 May 2014 01:20:28 +0200
Message-ID: <1399591234-13089-1-git-send-email-afenkart@gmail.com>
References: <1399591018-12930-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:48558 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbaEHXVB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 19:21:01 -0400
In-Reply-To: <1399591018-12930-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8d07e2b..5042a15 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1864,6 +1864,7 @@ static inline struct omap_mmc_platform_data
 {
 	return ERR_PTR(-EINVAL);
 }
+#define omap_mmc_of_match      NULL
 #endif
 
 static int omap_hsmmc_probe(struct platform_device *pdev)
-- 
1.7.10.4

