From: Juergen Kilb <J.Kilb@phytec.de>
Subject: [PATCH] omap_hsmmc: fix missing parenthesis in pr_info
Date: Sat, 29 Oct 2011 21:39:11 +0200
Message-ID: <1319917151-5626-1-git-send-email-J.Kilb@phytec.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.visioncatalog.com ([217.6.246.34]:52570 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab1J2UNK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 29 Oct 2011 16:13:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-omap@vger.kernel.org, Juergen Kilb <J.Kilb@phytec.de>

In commit a3c76eb9 (mmc: replace printk with appropriate
display macro) the opening parenthesis of pr_info was missing.

Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8ff123..101cd31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info"%s: cover is open, "
+			pr_info("%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
-- 
1.7.0.4

