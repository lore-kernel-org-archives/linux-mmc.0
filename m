Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB9C38142
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 01:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjAYBCU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 20:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjAYBCT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 20:02:19 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41C1222A27;
        Tue, 24 Jan 2023 17:02:15 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id A1C9F2058B4F;
        Wed, 25 Jan 2023 10:02:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:17 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D4E243D53;
        Wed, 25 Jan 2023 10:02:13 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/5] dt-bindings: mmc: uniphier-sd: Add socionext,syscon-uhs-mode property
Date:   Wed, 25 Jan 2023 10:01:57 +0900
Message-Id: <20230125010201.28246-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

UHS mode control is included in the interface logic represented
by syscon. To refer this, add new property "socionext,syscon-uhs-mode".

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/mmc/socionext,uniphier-sd.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
index a586fad0a46b..313621d0d9f5 100644
--- a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
@@ -55,6 +55,16 @@ properties:
     minItems: 1
     maxItems: 3
 
+  socionext,syscon-uhs-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to syscon that configures uhs mode
+          - description: ID of SD instance
+    description:
+      A phandle to syscon with one argument that configures uhs mode.
+      The argument is the ID of SD instance.
+
 allOf:
   - $ref: mmc-controller.yaml
 
-- 
2.25.1

