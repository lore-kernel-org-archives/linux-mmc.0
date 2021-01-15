Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63EC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A1B23A9C
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 19:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbhAOTdJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:33:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38234 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbhAOTdI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 14:33:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10FJWQTt010421;
        Fri, 15 Jan 2021 13:32:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610739146;
        bh=m0mz4dtHkMxa9GbD4ouVFHhkcK1uhi34MlSLQR7XL5E=;
        h=From:To:CC:Subject:Date;
        b=wZ02txGNoVnV0I3hk9k04diKdXqxuyo5vFJ4w/OpjLmzVftfAlV/RTKTs5CYdxzeC
         r88REF3kTkj9DzLctLfWdvcXuVLkA8hXaw8s/KXIofd+53xDvjrjlVKNRAlfdiPEQb
         jIUzt+w5DYnF+LS237uh68HiRNI5w2p+EP7lpugA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10FJWQK2031166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 13:32:26 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 13:32:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 13:32:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10FJWPHj064609;
        Fri, 15 Jan 2021 13:32:25 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mmc@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: fix compatible for j7200
Date:   Fri, 15 Jan 2021 21:32:18 +0200
Message-ID: <20210115193218.5809-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On TI J7200 SoC the SDHCI controller compatible defined as
 "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit"
 or
 "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit"
which causes dtbs_check warnings:
mmc@4f80000: compatible: ['ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-8bit'] is too long
mmc@4f80000: compatible: Additional items are not allowed ('ti,j721e-sdhci-8bit' was unexpected)
mmc@4fb0000: compatible:0: 'ti,j7200-sdhci-4bit' is not one of ['ti,am654-sdhci-5.1', 'ti,j721e-sdhci-8bit',
 'ti,j721e-sdhci-4bit', 'ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-4bit', 'ti,am64-sdhci-8bit', 'ti,am64-sdhci-4bit']
mmc@4fb0000: compatible: ['ti,j7200-sdhci-4bit', 'ti,j721e-sdhci-4bit'] is too long
mmc@4fb0000: compatible: Additional items are not allowed ('ti,j721e-sdhci-4bit' was unexpected)

Fix it by adding missing compatible strings and their combinations.

Fixes: 407d0c2cdd12 ("dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller documentation to json schema")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.yaml  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 34e53db29428..3a79e39253d2 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -15,14 +15,19 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ti,am654-sdhci-5.1
-      - ti,j721e-sdhci-8bit
-      - ti,j721e-sdhci-4bit
-      - ti,j7200-sdhci-8bit
-      - ti,j721e-sdhci-4bit
-      - ti,am64-sdhci-8bit
-      - ti,am64-sdhci-4bit
+    oneOf:
+      - const: ti,am654-sdhci-5.1
+      - const: ti,j721e-sdhci-8bit
+      - const: ti,j721e-sdhci-4bit
+      - const: ti,j721e-sdhci-4bit
+      - const: ti,am64-sdhci-8bit
+      - const: ti,am64-sdhci-4bit
+      - items:
+          - const: ti,j7200-sdhci-8bit
+          - const: ti,j721e-sdhci-8bit
+      - items:
+          - const: ti,j7200-sdhci-4bit
+          - const: ti,j721e-sdhci-4bit
 
   reg:
     maxItems: 2
-- 
2.17.1

