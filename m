Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73354C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 17:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKGRdQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiKGRdP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 12:33:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC61F9FC;
        Mon,  7 Nov 2022 09:33:15 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-096-035-235.ewe-ip-backbone.de [91.96.35.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B647166023A6;
        Mon,  7 Nov 2022 17:33:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667842393;
        bh=I5nGG6JUHVwZMZBXP5eZJMglpJE+L4055H0JxM8aqmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DK/qrYG9emNCkBmFd7xouyl498094nEf54CsaYY7LZNAOnKxDLckx+AHlcCzlGEYo
         GHJ9MPQJ534/Eb5+NUZD0Yg54P5gSWLaiBxDCVffYfHR/YhWXCwri4LVoQ/d11bcnL
         R97c8TMX6HYqFR8/MkUu05qR8iLByGByVBssdM13kDHmRJnKT8cdTNOHM5Hj+ZfRgf
         /LRcZtfa/k8Y9QX3aEaAw6vUQAZik1dyORpuP06dTAiNufFWSZgNIJgqcYtjZTWX+P
         sKFNtIVzoFHAPTQIrRSvk3AzPMzbHUeubYzrLZZERFGNWF5UV0RLUFj7a9y/+Sykdb
         1UbxE5b/hUbVg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D15B148011F; Mon,  7 Nov 2022 18:33:11 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 1/1] dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset support
Date:   Mon,  7 Nov 2022 18:33:10 +0100
Message-Id: <20221107173310.60503-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Properly describe reset related properties in the binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes since PATCHv1:
 * https://lore.kernel.org/all/20221021171654.87071-1-sebastian.reichel@collabora.com/
 * dropped minItems (Krzysztof Kozlowski)
 * reset-names are not copy pasted and intentionally the same as
   the clock-names. DT looks like this:

   clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
            <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
            <&cru TMCLK_EMMC>;
   clock-names = "core", "bus", "axi", "block", "timer";
   resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
            <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
            <&cru SRST_T_EMMC>;
   reset-names = "core", "bus", "axi", "block", "timer";
---
 .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 71f8e726d641..51ba44cad842 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -45,6 +45,17 @@ properties:
       - const: block
       - const: timer
 
+  resets:
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

