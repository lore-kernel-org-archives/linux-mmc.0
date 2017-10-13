From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] mmc: meson-mx-sdio: Cleanup IS_ERR() checks
Date: Fri, 13 Oct 2017 14:20:49 +0300
Message-ID: <20171013112049.rdcdqv6ooktlv5wz@mwanda>
References: <20171013111943.zyp5myiwb3pp56vh@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38561 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdJMLWP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Oct 2017 07:22:15 -0400
Content-Disposition: inline
In-Reply-To: <20171013111943.zyp5myiwb3pp56vh@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@endlessm.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org

Using PTR_ERR_OR_ZERO() instead of IS_ERR() works, but it's not how
you're supposed to write these conditions.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I really hope it doesn't become a trend on to wrap all error checks in a
WARN_ON() macro...

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index dc30ed5e964b..d0d921e0e589 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -602,7 +602,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 
 	host->fixed_factor_clk = devm_clk_register(host->controller_dev,
 						 &host->fixed_factor.hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->fixed_factor_clk)))
+	if (WARN_ON(IS_ERR(host->fixed_factor_clk)))
 		return PTR_ERR(host->fixed_factor_clk);
 
 	clk_div_parent = __clk_get_name(host->fixed_factor_clk);
@@ -620,7 +620,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 
 	host->cfg_div_clk = devm_clk_register(host->controller_dev,
 					      &host->cfg_div.hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
+	if (WARN_ON(IS_ERR(host->cfg_div_clk)))
 		return PTR_ERR(host->cfg_div_clk);
 
 	return 0;
