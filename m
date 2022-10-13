Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD7C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 02:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJMCkl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Oct 2022 22:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJMCkk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2022 22:40:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABAFF21C;
        Wed, 12 Oct 2022 19:40:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29D2eUBi010139;
        Wed, 12 Oct 2022 21:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665628830;
        bh=kMR2ox77RnQmVe0zkdaunM4zi/sHhqP76vBI4aEl7F4=;
        h=From:To:CC:Subject:Date;
        b=TaTdDvkEggYp3cw8mTH3c7hB2dTP9vyYfCaPwEWRGSNE0V5/IlBr8FcO1SFHNmQKL
         xZEbVXMWbJ6KBu3ZSF3Kpwb7NF2GMcPL0iMfYQAsf2K9djTuS25GSoidgNgMIYmdgy
         eoNjYZ0VqcR2yXQz4xm+lvmhI46uRnOP9Wy4Uqy0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29D2eTlw000799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 21:40:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 12
 Oct 2022 21:40:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 12 Oct 2022 21:40:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29D2eOeh097431;
        Wed, 12 Oct 2022 21:40:27 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: add ti,itap-del-sel-ddr50 to schema
Date:   Wed, 12 Oct 2022 19:40:21 -0700
Message-ID: <20221013024021.121104-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add missing ti,itap-del-sel-ddr50 property to schema to clear up the
following warnings.

mmc@4fb0000: Unevaluated properties are not allowed ('ti,itap-del-sel-ddr50' was unexpected)

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index ea9121fb188d..382d5face49a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -159,6 +159,12 @@ properties:
     minimum: 0
     maximum: 0x1f
 
+  ti,itap-del-sel-ddr50:
+    description: Input tap delay for MMC DDR50 timing
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 0x1f
+
   ti,itap-del-sel-ddr52:
     description: Input tap delay for MMC DDR52 timing
     $ref: "/schemas/types.yaml#/definitions/uint32"
-- 
2.38.0.rc0.52.gdda7228a83

