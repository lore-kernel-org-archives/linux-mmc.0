From: akpm@linux-foundation.org
Subject: [patch 036/177] sdhci: remove useless set_clock() check
Date: Tue, 10 Aug 2010 18:01:43 -0700
Message-ID: <201008110101.o7B11hqZ027052@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51113 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab0HKBLr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:11:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

When using QUIRK_NONSTANDARD_CLOCK, it checks the set_clock() function
which is not used actually.  So delete it.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-remove-useless-set_clock-check drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-remove-useless-set_clock-check
+++ a/drivers/mmc/host/sdhci.c
@@ -1787,7 +1787,7 @@ int sdhci_add_host(struct sdhci_host *ho
 	 */
 	mmc->ops = &sdhci_ops;
 	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
-			host->ops->set_clock && host->ops->get_min_clock)
+			host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
 		mmc->f_min = host->max_clk / 256;
_
