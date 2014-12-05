From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/13] mmc: sdhci: Always init buf_ready_int
Date: Fri,  5 Dec 2014 19:41:10 +0200
Message-ID: <1417801271-15575-13-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60409 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaLERns (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:48 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

There is no point making the initialization
of buf_ready_int conditional on host version.
Simplify by just doing it always. Note that
the other conditional initializations will be
removed when the new way of doing re-tuning
is taken into use.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bfde165..dd4cc4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3331,9 +3331,9 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
 
-	if (host->version >= SDHCI_SPEC_300) {
-		init_waitqueue_head(&host->buf_ready_int);
+	init_waitqueue_head(&host->buf_ready_int);
 
+	if (host->version >= SDHCI_SPEC_300) {
 		/* Initialize re-tuning timer */
 		init_timer(&host->tuning_timer);
 		host->tuning_timer.data = (unsigned long)host;
-- 
1.9.1

