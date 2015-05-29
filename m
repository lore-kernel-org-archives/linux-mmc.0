From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/2] mmc: sdhci-bcm2835: Clean up platform allocations if sdhci init fails.
Date: Fri, 29 May 2015 14:06:11 -0700
Message-ID: <1432933572-8695-1-git-send-email-eric@anholt.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:58104 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbE2VGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2015 17:06:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/mmc/host/sdhci-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 0ef0343..32f4046 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -173,8 +173,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	return sdhci_add_host(host);
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err;
 
+	return 0;
 err:
 	sdhci_pltfm_free(pdev);
 	return ret;
-- 
2.1.4

