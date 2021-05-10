Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA2C43461
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB8461613
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhEJTMu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 15:12:50 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:56430 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231474AbhEJTMt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 May 2021 15:12:49 -0400
Received: by lynxeye.de (Postfix, from userid 501)
        id EF290E74268; Mon, 10 May 2021 21:04:04 +0200 (CEST)
Received: from astat.fritz.box (a89-183-115-43.net-htp.de [89.183.115.43])
        by lynxeye.de (Postfix) with ESMTPA id BEA98E74268;
        Mon, 10 May 2021 21:04:03 +0200 (CEST)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: mmc: add no-mmc-hs400 flag
Date:   Mon, 10 May 2021 21:03:58 +0200
Message-Id: <20210510190400.105162-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Lucas Stach <dev@lynxeye.de>

HS400 requires a data strobe line in addition to the usual MMC signal
lines. If a board design neglects to wire up this signal, HS400 mode is
not available, even if both the controller and the eMMC are claiming to
support this mode. Add a DT flag to allow boards to disable the HS400
support in this case.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index e141330c1114..ac80d09df3a9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -220,6 +220,11 @@ properties:
     description:
       eMMC HS400 enhanced strobe mode is supported
 
+  no-mmc-hs400:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      All eMMC HS400 modes are not supported.
+
   dsr:
     description:
       Value the card Driver Stage Register (DSR) should be programmed
-- 
2.31.1

