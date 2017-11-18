From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/6 v2] mmc: sunxi-mmc: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 15:03:48 +0530
Message-ID: <27a6d3a22516b3711b48bfbf305b6d8f3960eeac.1510997223.git.arvind.yadav.cs@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35945 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163308AbdKRJef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Nov 2017 04:34:35 -0500
In-Reply-To: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355d..ec2a16b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_assert_reset;
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		ret = host->irq;
+		goto error_assert_reset;
+	}
+
 	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
 			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
 
-- 
2.7.4

