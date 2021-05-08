Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D7C433B4
	for <linux-mmc@archiver.kernel.org>; Sat,  8 May 2021 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A81610CD
	for <linux-mmc@archiver.kernel.org>; Sat,  8 May 2021 21:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhEHVHl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 May 2021 17:07:41 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:40619 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhEHVHk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 8 May 2021 17:07:40 -0400
Received: by lynxeye.de (Postfix, from userid 501)
        id 0DA46E7425C; Sat,  8 May 2021 22:57:03 +0200 (CEST)
Received: from astat.fritz.box (a89-183-71-68.net-htp.de [89.183.71.68])
        by lynxeye.de (Postfix) with ESMTPA id B0865E74214;
        Sat,  8 May 2021 22:57:02 +0200 (CEST)
From:   Lucas Stach <dev@lynxeye.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: mmc: add no-mmc-hs400 flag
Date:   Sat,  8 May 2021 22:56:57 +0200
Message-Id: <20210508205658.91105-1-dev@lynxeye.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

HS400 requires a data strobe line in addition to the other MMC signal
lines, so if a board design neglects to wire up this signal, HS400 mode
is no available, even if both the controller and the eMMC are claiming
to support this mode. Add a DT flag to allow boards to disable the
HS400 support in this case.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
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

