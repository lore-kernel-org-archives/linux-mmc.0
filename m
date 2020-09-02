Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B9C43461
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3AB208C7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075513;
	bh=FKAYu4oD2G5WMtLd9hitMhMb2ec5r1K6mvi1cq8DwSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAVw84dT+KvKqyloFJWtuEzQrPBCttbYy5dVCpNSz3HN6noF3SDLI7F6bjnzGeqA+
	 NohMB96z4dRWlf/yVbmMg6V7PLFB6ualw3SPKIt0wbKMKsD7BfHSlpORAtBREkr/kq
	 hmJv8+bULUkGSPFpHKZdZvxF6TYLtAw6lBs0tLfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIBTi0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgIBTi0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:38:26 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE434208C7;
        Wed,  2 Sep 2020 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075505;
        bh=FKAYu4oD2G5WMtLd9hitMhMb2ec5r1K6mvi1cq8DwSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/oZcVE+7MwGo3enjkFgsjITJp6lQVttN8zMl+peWR/VHJbvGYExW57UOivCRwmHU
         FgqzHkNemwRXeHzS07Y+luaw140AMnoDKyyVebm+0O0TVdB0SPpOikhtA3UQZZHpC4
         x2puAX6Uqz5H23ylate4gQDGP2KirfA6oG3zkJo0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 09/11] mmc: dw_mmc: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 21:36:56 +0200
Message-Id: <20200902193658.20539-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code, the error value gets printed and real error
from dw_mci_parse_dt() is passed further instead of fixed -EINVAL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/dw_mmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0fba940544ca..43c5795691fb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3161,12 +3161,9 @@ int dw_mci_probe(struct dw_mci *host)
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
-		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
-			return -EPROBE_DEFER;
-		} else if (IS_ERR(host->pdata)) {
-			dev_err(host->dev, "platform data not available\n");
-			return -EINVAL;
-		}
+		if (IS_ERR(host->pdata))
+			return dev_err_probe(host->dev, PTR_ERR(host->pdata),
+					     "platform data not available\n");
 	}
 
 	host->biu_clk = devm_clk_get(host->dev, "biu");
-- 
2.17.1

