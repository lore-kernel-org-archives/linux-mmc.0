Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4FCC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 09:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33C364EF5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhBYJxW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 04:53:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235046AbhBYJxI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 25 Feb 2021 04:53:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E5D2AAAE;
        Thu, 25 Feb 2021 09:52:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, alcooperx@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/2] mmc: sdhci-iproc: Set clock frequency as per DT
Date:   Thu, 25 Feb 2021 10:52:16 +0100
Message-Id: <20210225095216.28591-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210225095216.28591-1-nsaenzjulienne@suse.de>
References: <20210225095216.28591-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

devicetree might request a clock frequency different from whatever is
set-up by the bootloader. Make sure to setup the new rate.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
2.30.1

