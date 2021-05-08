Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9830AC433B4
	for <linux-mmc@archiver.kernel.org>; Sat,  8 May 2021 21:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3E86101B
	for <linux-mmc@archiver.kernel.org>; Sat,  8 May 2021 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhEHVHl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 May 2021 17:07:41 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:40618 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229522AbhEHVHk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 8 May 2021 17:07:40 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 May 2021 17:07:40 EDT
Received: by lynxeye.de (Postfix, from userid 501)
        id 78D66E74251; Sat,  8 May 2021 22:57:04 +0200 (CEST)
Received: from astat.fritz.box (a89-183-71-68.net-htp.de [89.183.71.68])
        by lynxeye.de (Postfix) with ESMTPA id 0727CE7424E;
        Sat,  8 May 2021 22:57:03 +0200 (CEST)
From:   Lucas Stach <dev@lynxeye.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: add support for disabling HS400 mode via DT
Date:   Sat,  8 May 2021 22:56:58 +0200
Message-Id: <20210508205658.91105-2-dev@lynxeye.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508205658.91105-1-dev@lynxeye.de>
References: <20210508205658.91105-1-dev@lynxeye.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On some boards the data strobe line isn't wired up, rendering HS400
support broken, even if both the controller and the eMMC claim to
support it. Allow to disable HS400 mode via DT.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a20459744d21..1d6068507fb6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1483,6 +1483,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_find_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
+	if (of_find_property(np, "no-mmc-hs400", NULL))
+		host->quirks2 &= ~SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
+
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
-- 
2.31.1

