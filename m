Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2903EC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFCA619A0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhCVS76 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhCVS73 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B935D619A8;
        Mon, 22 Mar 2021 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439569;
        bh=3WJZ+xKT9j6gw9UE+xMc27OkZKOFyhJ+cIpSqbqXuBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKELXgM3XqhR4YSRZUHp5ZU6eoD1pjbdwmVJcdeBhnjS6ry1K/Zby/24yCwTti9tC
         49eVr4lL9glgiM0uCESrbFBnqB3BDEE5nlOIl2RXQjFgebnynbMb/dOQZOv65rYyFf
         B1C6TuoB6PfEsXbCR+wvFspZy7Vt7m8sTxlvADHvo8g4t1uZRdEmCUq4n7lkzklP4/
         17o5pgqN5D4ce2YUnXcVrUE7fu8iqUESqsfX6Xwn7k5WzM3xUMz9c515t5Zs3J+IX6
         iJ4IxHf67yTSbrML4p5LpYTZMwfXX5+Oj29sAys1IKKYMLUy5cnQhUMzyyUEkcKknc
         zNI95nDugy+xg==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenz@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, alcooperx@gmail.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH 3/4] mmc: sdhci-iproc: Set clock frequency as per DT
Date:   Mon, 22 Mar 2021 19:58:16 +0100
Message-Id: <20210322185816.27582-4-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322185816.27582-1-nsaenz@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

devicetree might request a clock frequency different from whatever is
set-up by the bootloader. Make sure to setup the new rate.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 drivers/mmc/host/sdhci-iproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index ddeaf8e1f72f..536c382e2486 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -358,6 +358,16 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 			ret = PTR_ERR(pltfm_host->clk);
 			goto err;
 		}
+
+		if (pltfm_host->clock) {
+			ret = clk_set_rate(pltfm_host->clk, pltfm_host->clock);
+			if (ret) {
+				dev_err(dev, "failed to set host clk at %u Hz\n",
+					pltfm_host->clock);
+				goto err;
+			}
+		}
+
 		ret = clk_prepare_enable(pltfm_host->clk);
 		if (ret) {
 			dev_err(dev, "failed to enable host clk\n");
-- 
2.30.2

