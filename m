Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786F8C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6821582
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3JM89Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgGFRnm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgGFRnl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 13:43:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D91C061755;
        Mon,  6 Jul 2020 10:43:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j7so2259330plk.13;
        Mon, 06 Jul 2020 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3qlWcN7g2R3ufNiJ3QnG2MZ3162eOXdLVXk7i7fibM=;
        b=d3JM89EcsC6xzPgS+G5KDWriXj7NgqYy0rRdr7yRF+6IAWuzEznQRXsCjtPhPt+lvn
         wTVkb83oZHFQ98glR+ew6b8LxmfNc22kxrh6h6V526beQIiQZNhh6fW03MJFQLDEhG+s
         8x85LirICgME+iSWgiPLQ7Sb/BYNoTqtdUuQ8wn9ZPOdFMG7jTzT1KAUGI4m/hMP1+4e
         Q86kX4PZlappop5xb8B0yVHkd4aHVC/JkqA3puzMw4PZNo9aEHix+x0jSRVe0SDt3+Zp
         DTEY1hjRZpGQgIfud3k+cOqmEpEqtihT/nezk17Vd/Ik8K7Dt1KaBYa/jIWEMEKWL5S0
         q8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3qlWcN7g2R3ufNiJ3QnG2MZ3162eOXdLVXk7i7fibM=;
        b=iPGpDbpkr4+YX7df8SBmHGRrK0yh83D5BClwjjj0G1DBZBvI+p73MLY5M1rMdHi+nS
         KGzgUHC9EhXds9xRp+uQnPE4tAG5wmtTFg+9seBntwP7SrmyPI38Dd7w43AyL/3oT0+4
         FaAPAPfvLs4RZiKnKpEvqVrfwURmpiQt8yHHQBsY58vhdcE1SJqVjgZVqI1wmcwuIhGx
         o4PWm1nskP/M+oSc3n0JQmP8r476tvbBZbWoRifx47M4GUHr94xZRhpXXY3mL/b3hEJ6
         h7MNgLcxvmYnGY3+g+YSPeR0wlGopeaRv81pOkE6ZfyiGH5z7Z95R5y+zNvK5TCcVy4o
         n7/Q==
X-Gm-Message-State: AOAM5321e9p8CZFdyRn+DVyZZtrlGwL0F5SY5uOPqWP24ZhGZq9U2Bew
        bE0RMR0d2FPeOfVY8o64FWQ=
X-Google-Smtp-Source: ABdhPJwFZoDu8NhQobie5Dp41SsuH6SnXScpx0FnWwbrHuWQzRUO8AeSFCkFV1ONk0VTqYSAJdFkgQ==
X-Received: by 2002:a17:902:b60e:: with SMTP id b14mr42510318pls.81.1594057421401;
        Mon, 06 Jul 2020 10:43:41 -0700 (PDT)
Received: from localhost.localdomain ([1.240.193.107])
        by smtp.googlemail.com with ESMTPSA id c27sm19599779pfj.163.2020.07.06.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:43:40 -0700 (PDT)
From:   Kangmin Park <l4stpr0gr4m@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Convert sdhci-sirf to json-schema
Date:   Tue,  7 Jul 2020 02:43:36 +0900
Message-Id: <20200706174336.27251-1-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the sdhci-sirf binding to DT schema format using json-schema.

At the same time, fix unit address to match the first address specified
in the reg property of the node.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 .../devicetree/bindings/mmc/sdhci-sirf.txt    | 18 ---------
 .../devicetree/bindings/mmc/sdhci-sirf.yaml   | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
deleted file mode 100644
index dd6ed464bcb8..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* SiRFprimII/marco/atlas6 SDHCI Controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-sirf driver.
-
-Required properties:
-- compatible: sirf,prima2-sdhc
-
-Optional properties:
-- cd-gpios: card detect gpio, with zero flags.
-
-Example:
-
-	sd0: sdhci@56000000 {
-		compatible = "sirf,prima2-sdhc";
-		reg = <0xcd000000 0x100000>;
-		cd-gpios = <&gpio 6 0>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml b/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml
new file mode 100644
index 000000000000..46269378d9b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-sirf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sdhci Sirf Device Tree Bindings
+
+description: |
+  This file documents differences between the core properties in
+  mmc.txt and the properties used by the sdhci-sirf driver.
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - sirf,prima2-sdhc
+
+  reg:
+    maxItems: 1
+
+  cd-gpios:
+    description:
+      card detect gpio, with zero flags.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sd0: sdhci@cd000000 {
+          compatible = "sirf,prima2-sdhc";
+          reg = <0xcd000000 0x100000>;
+          cd-gpios = <&gpio 6 0>;
+    };
-- 
2.26.2

