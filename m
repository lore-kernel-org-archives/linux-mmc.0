From: Steven Honeyman <stevenhoneyman@gmail.com>
Subject: Subject: [PATCH] sdhci: change a warning message from pr_err to pr_warn
Date: Sat, 13 Sep 2014 22:23:28 +0100
Message-ID: <CABz95_B1h=nFvGCuuDZRQm7qtLftnv8NXZPK=+7tx7H3PS+ygA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:47537 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaIMVX3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Sep 2014 17:23:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This is just a warning, so I've given it a more appropriate log level

Signed-off-by: Steven Honeyman <stevenhoneyman@gmail.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b2a9a..6e9ba15 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2768,7 +2768,7 @@ int sdhci_add_host(struct sdhci_host *host)
     host->version = (host->version & SDHCI_SPEC_VER_MASK)
                 >> SDHCI_SPEC_VER_SHIFT;
     if (host->version > SDHCI_SPEC_300) {
-        pr_err("%s: Unknown controller version (%d). "
+        pr_warn("%s: Unknown controller version (%d). "
             "You may experience problems.\n", mmc_hostname(mmc),
             host->version);
     }
--
2.1.0
