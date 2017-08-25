From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] mmc: sunxi: Reset the device at probe time
Date: Fri, 25 Aug 2017 11:49:53 +0200
Message-ID: <20170825094953.3247-2-maxime.ripard@free-electrons.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37926 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbdHYJt4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2017 05:49:56 -0400
In-Reply-To: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-mmc@vger.kernel.org

We might be into some troubles if the bootloader misconfigured the MMC
controller.

We currently only de-assert the reset line at probe time, which means that
if the device was already out of reset, we're going to keep whatever state
was set already.

Switch to a reset instead of the deassert to have a device in a pristine
state when we start operating.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index da5f46a14497..53c970fe0873 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1242,7 +1242,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	}
 
 	if (!IS_ERR(host->reset)) {
-		ret = reset_control_deassert(host->reset);
+		ret = reset_control_reset(host->reset);
 		if (ret) {
 			dev_err(&pdev->dev, "reset err %d\n", ret);
 			goto error_disable_clk_sample;
-- 
2.13.5

