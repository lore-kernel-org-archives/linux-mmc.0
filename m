Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E876C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhL0NcK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:32:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39416
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234019AbhL0NcI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:32:08 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C1A63FFE9
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640611925;
        bh=y5MJv5dkFEWJeZ+ENEwYHJsdTdmbB9oIwbRFldgvfL0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OlTKe6KeG2/7bC57ZIRaMavtYKGfOpsZKDm6xj5yt9352qMk1H9M8O+jZ+NArmoFf
         2oCx509lTNOosBXochYb/lGfHyuSmGvOBOO9oNi0bKWdkwd4jmF631UgfsB1NobxWl
         y2ze6uRNz9Q/jTBj7ilkIaMYGOOdi7t6zOoVKwn1X+yuk2ng+GXbfKGvDowbwdZA44
         PnlAdAJvw+QstLcV9GVg/DVHbGn1WhQ2uVGg0DF0roYMYABP1jYRz6S/kvlSIvKf3B
         bMApBIUjNwb+/m7kNQzZEdVE5tlBOrtITzySB7JOox4UIypVPra9SksRz1QFetG+Kc
         FNBdShAVB1KmA==
Received: by mail-lj1-f199.google.com with SMTP id k20-20020a2e9214000000b0022d6b13bc8aso4943703ljg.13
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5MJv5dkFEWJeZ+ENEwYHJsdTdmbB9oIwbRFldgvfL0=;
        b=yaqicjiuDZ9n7EX9wGEKYT80InRvpL9s4h8XHu68Ps4vtQpVNR9BvCuI1VyYHgTebU
         iX663aQPCwD4N9GsfcBJUwA3otbEdEbaFXtRHCSAVTb7k6b0GzvHARp42pQD/IaQ5fnX
         TAQ2he3CAQiq06+lsmH7oAIIk5xsoA/F8xWLeiSGRYY58CQQ5xw/FRiG8tdDMI4HqqUO
         r1DQ4arQwxqRMf+6kyGl7m3IT2YHT8ueSn22dmiI4r5bD2l7RZYuIxXQxnzBl1TfwXze
         NNy+PHW3N2h/MOESOWB/sAj6OqvhWDwE29NsRxDcImXXSASbs6D3jQ1WI0riYCFA1q2Y
         1dDg==
X-Gm-Message-State: AOAM53168W5plKXcw3PhNSsT+yzFyesIRNM/dOzWnAoowO7/sSukhXPE
        mtgpwBCF2aB6+ht8NQEczMqzZAW9lXOImyY5V+qnLwbi5gmNiozEvD/SISL4BPHnHtsXarWPKXS
        g8MulQq0y5e2E5YPtomA6hAnttQbQo5L/Ffc3PA==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr15350139lfc.226.1640611924613;
        Mon, 27 Dec 2021 05:32:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdC9kbL0s6EJ1Ul2bU9vVLa0PpXYnccCSTpvf6T3GQkXGRZJCOybKlDM22aTnjracXRomVlw==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr15350120lfc.226.1640611924436;
        Mon, 27 Dec 2021 05:32:04 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d14sm1433510lfg.18.2021.12.27.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:32:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 02/19] dt-bindings: altera: document existing Cyclone 5 board compatibles
Date:   Mon, 27 Dec 2021 14:31:14 +0100
Message-Id: <20211227133131.134369-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Several Cyclone 5 SoCFPGA based boards have additional board compatibles
which are not documented in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/arm/altera.yaml       | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index c15c92fdf2ed..0d62c2bde053 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -13,12 +13,30 @@ properties:
   $nodename:
     const: "/"
   compatible:
-    items:
-      - enum:
-          - altr,socfpga-cyclone5
-          - altr,socfpga-arria5
-          - altr,socfpga-arria10
-      - const: altr,socfpga
+    oneOf:
+      - description: Arria 5 boards
+        items:
+          - const: altr,socfpga-arria5
+          - const: altr,socfpga
+
+      - description: Arria 10 boards
+        items:
+          - const: altr,socfpga-arria10
+          - const: altr,socfpga
+
+      - description: Cyclone 5 boards
+        items:
+          - enum:
+              - altr,socfpga-cyclone5-socdk
+              - denx,mcvevk
+              - ebv,socrates
+              - macnica,sodia
+              - novtech,chameleon96
+              - samtec,vining
+              - terasic,de0-atlas
+              - terasic,socfpga-cyclone5-sockit
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
 
 additionalProperties: true
 
-- 
2.32.0

