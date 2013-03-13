From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/3] mmc: sdhci-pltfm: Constify the ops field of sdhci_pltfm_data struct
Date: Wed, 13 Mar 2013 19:26:04 +0100
Message-ID: <1363199165-16211-2-git-send-email-lars@metafoo.de>
References: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-064.synserver.de ([212.40.185.64]:1053 "EHLO
	smtp-out-064.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933006Ab3CMSYg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 14:24:36 -0400
In-Reply-To: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <cbou@mail.ru>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

All users of the sdhci_ops struct in the sdhci core already treat it as const.
The sdhci-pltfm code itself never actually looks at the ops field of the
sdhci_pltfm_data struct and merely passes it on to the sdhci core, so make we
can make it const in the sdhci_pltfm_data struct as well. This allows us to
declare sdhci_ops structs as const in drivers using the sdhci-pltfm helper code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index a3bfc1e..1210ed1 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -16,7 +16,7 @@
 #include "sdhci.h"
 
 struct sdhci_pltfm_data {
-	struct sdhci_ops *ops;
+	const struct sdhci_ops *ops;
 	unsigned int quirks;
 };
 
-- 
1.8.0

