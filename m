Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F7BC2D0A8
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4823119
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600875478;
	bh=LZ8zZkcDT5bZVhoFGcs01ikRZlzBKlzCeMK3BbwqAPM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FOf6fkOsMtY0jJQ/Qqehl3CZepI45rSR0aoJ9VmtaFnJF19lMC3LZ3sDgoFr3HIas
	 bfJO2Lou2s8ItEI1SgArNey4TZNFC576d3ug02h37JLWPLd8Cbe7r4fjNOf+fUl0xT
	 tOr74P5At0Z+PFmUDHCeMPKQKFcVx4r5xLtFC/R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWPh6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgIWPh6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Sep 2020 11:37:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD1421D41;
        Wed, 23 Sep 2020 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600875477;
        bh=LZ8zZkcDT5bZVhoFGcs01ikRZlzBKlzCeMK3BbwqAPM=;
        h=From:To:Cc:Subject:Date:From;
        b=HzN/sn/PsFetsFC5y98ujOl+NUKWBnVEoUjvIIhM6JlYlpxBDZ6Zdoihix3Zxoi17
         uSDGJV8rA/GDq/ioNGSQK7dkwG+kqimuZpEAvlzAyFFV4vyfPq/Dc7EFENaYiPLERu
         U87FTK+pjCIJmdbFoSeGM8Jltqn66/8Hi1EdlOPs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] mmc: moxart: remove unneeded check for drvdata
Date:   Wed, 23 Sep 2020 17:37:38 +0200
Message-Id: <20200923153739.30327-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'struct mmc_host *mmc' comes from drvdata set at the end of probe,
so it cannot be NULL.  The code already dereferences it few lines before
the check with mmc_priv().  This also fixes smatch warning:

  drivers/mmc/host/moxart-mmc.c:692 moxart_remove() warn: variable dereferenced before check 'mmc' (see line 688)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/moxart-mmc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 2bfb376fddc4..f25079ba3bca 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -689,19 +689,18 @@ static int moxart_remove(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, NULL);
 
-	if (mmc) {
-		if (!IS_ERR(host->dma_chan_tx))
-			dma_release_channel(host->dma_chan_tx);
-		if (!IS_ERR(host->dma_chan_rx))
-			dma_release_channel(host->dma_chan_rx);
-		mmc_remove_host(mmc);
-		mmc_free_host(mmc);
+	if (!IS_ERR(host->dma_chan_tx))
+		dma_release_channel(host->dma_chan_tx);
+	if (!IS_ERR(host->dma_chan_rx))
+		dma_release_channel(host->dma_chan_rx);
+	mmc_remove_host(mmc);
+	mmc_free_host(mmc);
+
+	writel(0, host->base + REG_INTERRUPT_MASK);
+	writel(0, host->base + REG_POWER_CONTROL);
+	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
+	       host->base + REG_CLOCK_CONTROL);
 
-		writel(0, host->base + REG_INTERRUPT_MASK);
-		writel(0, host->base + REG_POWER_CONTROL);
-		writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
-		       host->base + REG_CLOCK_CONTROL);
-	}
 	return 0;
 }
 
-- 
2.17.1

