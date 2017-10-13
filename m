From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] mmc: meson-mx-sdio: return correct error code
Date: Fri, 13 Oct 2017 14:19:43 +0300
Message-ID: <20171013111943.zyp5myiwb3pp56vh@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37380 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdJMLVK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Oct 2017 07:21:10 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@endlessm.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org

This has a copy and paste bug so we use "host->fixed_factor_clk" which
is a valid pointer instead of "host->cfg_div_clk" which holds the error
code.

Fixes: 0aa0fb9cd239 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 19b499bbe691..dc30ed5e964b 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -621,7 +621,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 	host->cfg_div_clk = devm_clk_register(host->controller_dev,
 					      &host->cfg_div.hw);
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
-		return PTR_ERR(host->fixed_factor_clk);
+		return PTR_ERR(host->cfg_div_clk);
 
 	return 0;
 }
