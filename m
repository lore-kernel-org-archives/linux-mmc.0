From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/6] mmc: sunxi-mmc: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 01:58:22 +0530
Message-ID: <1510950502-22565-7-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35385 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761045AbdKQU24 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 15:28:56 -0500
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355d..ec2a16b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_assert_reset;
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		ret = host->irq;
+		goto error_assert_reset;
+	}
+
 	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
 			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
 
-- 
2.7.4

