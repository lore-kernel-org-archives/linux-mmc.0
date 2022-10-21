Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E68FA373E
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Oct 2022 17:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJURRH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJURRG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2022 13:17:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166917D292;
        Fri, 21 Oct 2022 10:17:01 -0700 (PDT)
Received: from jupiter.universe (dyndsl-037-138-189-087.ewe-ip-backbone.de [37.138.189.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5486660253A;
        Fri, 21 Oct 2022 18:16:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666372619;
        bh=8SEmRRNqWhaovZwlBX64w79Qsrya4d5yN06pT0JgFlY=;
        h=From:To:Cc:Subject:Date:From;
        b=OS3eeaMMU7EhgwObqeldVSO/Ydqm6XG4oVTr+K+uQrr1K2pdkkXB08MLcVuwsGV7e
         c83m5SW/OIqD57D6uQBRrJBZ2JHVzSbgea9ztx3aiFBhurai9PMMVB9CGhvzYw5CF6
         VhOhguRxCKT2gDI4LyR6JQtGDn/jOVWYuvNxyrfDTm7P++MX+0Dq4+oY7BLujhpU07
         LGxcpcyUc3VDp0zvoqVeMEH8TTRn9YM/LG3MsdLcFqFOdaz5qUWoH1ogJ0s1417rwQ
         kAu0t/ilzveWHhRlgaWMYSBkC0JEd2RpT7iais5YH48rDRzrvmB2b97UcXQJOkfNnv
         38lflUm/krRUA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 745DE48082E; Fri, 21 Oct 2022 19:16:57 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/1] dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset support
Date:   Fri, 21 Oct 2022 19:16:54 +0200
Message-Id: <20221021171654.87071-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Properly describe reset related properties in the binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 71f8e726d641..162c1a4abf3c 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -45,6 +45,18 @@ properties:
       - const: block
       - const: timer
 
+  resets:
+    minItems: 5
+    maxItems: 5
+
+  reset-names:
+    items:
+      - const: core
+      - const: bus
+      - const: axi
+      - const: block
+      - const: timer
+
   rockchip,txclk-tapnum:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
-- 
2.35.1

