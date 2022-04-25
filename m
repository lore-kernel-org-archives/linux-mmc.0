Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABEEC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Apr 2022 06:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDYGeu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiDYGeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2022 02:34:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6B2715E;
        Sun, 24 Apr 2022 23:31:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VVVM010135;
        Mon, 25 Apr 2022 01:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650868291;
        bh=MJjjRhU5iMB5CEQn17kMdjXHejdiUkwacjzhmT+hPlQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lyVeMzPx4xCfyu2WepF5TN0YrT30pfXkmTIBoR1GGbI07TRW3v9h6ghJjvogRftdm
         zB2NCJZNWGOXAHQAlTUm+a0Pervmw9ojEQaTepaAh4+0NqO7uVruAq7IomjfuYjtLA
         LC4LFnhmbv/YKEvUW9A2+GYQ7yGgpfvbfO88wZKg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P6VV2G125708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 01:31:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 01:31:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 01:31:30 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VNNO079479;
        Mon, 25 Apr 2022 01:31:28 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-am654: Add flag to force setting of TESTCD bit
Date:   Mon, 25 Apr 2022 12:01:19 +0530
Message-ID: <20220425063120.10135-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425063120.10135-1-a-govindraju@ti.com>
References: <20220425063120.10135-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ARASAN MMC controller on Keystone 3 class of devices needs the SDCD
line to be connected for proper functioning. Similar to the issue pointed
out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
sdhci-of-arasan: Set controller to test mode when no CD bit").

In cases where SDCD line is not connected, adding
"ti,fails-without-test-cd" in the DT node helps to indicate the
controller, that the SDCD line has been pulled down, using the TESTCD bit.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 0566493c4def..0ab07759b472 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -186,6 +186,13 @@ properties:
     description: Clock Delay Buffer Select
     $ref: "/schemas/types.yaml#/definitions/uint32"
 
+  ti,fails-without-test-cd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When present, indicates that the CD line is not connected
+      and the controller is required to be forced into Test mode
+      to set the TESTCD bit.
+
 required:
   - compatible
   - reg
-- 
2.17.1

