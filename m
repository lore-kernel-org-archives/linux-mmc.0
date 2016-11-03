From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 06/13] mmc: core: move the cookie's enum values from sdhci.h to
 mmc.h
Date: Thu, 03 Nov 2016 15:21:28 +0900
Message-ID: <20161103062135.10697-7-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36272 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbcKCGVv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 02:21:51 -0400
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

It's not for only sdhci controller.
So it can be moved from sdhci.h to mmc.h. And renamed from sdhci_cookie
to mmc_cookie.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci.h | 6 ------
 include/linux/mmc/core.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 766df17..325663b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -321,12 +321,6 @@ struct sdhci_adma2_64_desc {
 /* Allow for a a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
-enum sdhci_cookie {
-	COOKIE_UNMAPPED,
-	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
-	COOKIE_MAPPED,		/* mapped by sdhci_prepare_data() */
-};
-
 struct sdhci_host {
 	/* Data set by hardware interface driver */
 	const char *hw_name;	/* Hardware bus name */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2b953eb..d23a675 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -106,6 +106,12 @@ struct mmc_command {
 	struct mmc_request	*mrq;		/* associated request */
 };
 
+enum mmc_cookie {
+	COOKIE_UNMAPPED,
+	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of controller */
+	COOKIE_MAPPED,		/* mapped by prepare_data() of controller */
+};
+
 struct mmc_data {
 	unsigned int		timeout_ns;	/* data timeout (in ns, max 80ms) */
 	unsigned int		timeout_clks;	/* data timeout (in clocks) */
-- 
2.10.1

