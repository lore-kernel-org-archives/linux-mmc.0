From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/2] mmc: sdhci-bcm2835: Actually enable the clock
Date: Fri, 29 May 2015 14:06:12 -0700
Message-ID: <1432933572-8695-2-git-send-email-eric@anholt.net>
References: <1432933572-8695-1-git-send-email-eric@anholt.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:58111 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbbE2VGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2015 17:06:13 -0400
In-Reply-To: <1432933572-8695-1-git-send-email-eric@anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>

We're currently using a fixed frequency clock specified in the DT, so
enabling is a no-op.  However, the RPi firmware-based clocks driver
can actually disable unused clocks, so when switching to use it we
ended up losing our MMC clock once all devices were probed.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Re-disable our clock on sdhci_add_host() failure.

 drivers/mmc/host/sdhci-bcm2835.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 32f4046..1c65d46 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -172,12 +172,19 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pltfm_host->clk);
 		goto err;
 	}
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable host clk\n");
+		goto err;
+	}
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto err;
+		goto err_clk;
 
 	return 0;
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
 err:
 	sdhci_pltfm_free(pdev);
 	return ret;
-- 
2.1.4

