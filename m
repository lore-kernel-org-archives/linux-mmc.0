Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E06DC4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLDJrb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLDJra (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 04:47:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA0183B1
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 01:47:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so8420684lfb.1
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2022 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EgtMAreZX6v1a607duaaNtdR2Ho0lCLyBFIAD2u3Bg=;
        b=UWp5jxo5SgZmhR0ShSmbaFj2r/WTYvATnZCcb7Y1/Z8uIpW/2lS9xmd8kKm1Amh3r0
         SxbkFRMragD1BtlHGxx9EE1jOkLTJpdPyZVkEeCmuf/lna+QNz7teiHwXzcLr2C8TN1X
         He16v951Ffc6greL0gE0+xyxeOf27PkSE+u2iExhp+PVEBMsi0l+U5DukPYjVxhxRSlI
         ZsZTLazwK2iceFkYAGlt8LQNcwijhJa1ZmuGvNdFwwtwgGnhoYwvlIYFBdQcRUt8uKrs
         snrLHZvchdcWFOVEB82bx3MNaGN4fAIjSYzESwO0D45AW81gxMudu1AO/Qujy498EyKT
         radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EgtMAreZX6v1a607duaaNtdR2Ho0lCLyBFIAD2u3Bg=;
        b=7n8MJzfPatKMatNzcgPK10gL1JZYrbpzBRUu18+lono+i2/GX5IMYHDO/b9a1NDSDn
         GvgEVMPorXzmE9kqE4i/9LDpAU7VVgHIjkeYGMJh3x+qsrIL0Cf3gDCXk4fFf007cp3S
         VsXUdCCymnZqTDW3ZvM+p6h9kit0H29iEKveyqcuWxhYs9xcQ5UNYn/XRVfN+bY+pUik
         3i7OR6cGeF8MwHnZbiLKL6WpKxLpxL7xEl94Zha+nw4ouvf7jP7DdF3tq7H/fUZxZa1R
         ebKPPupMyWTKYp+REA4OrtVkrZy/32cFipuqEeIn5exQqbSgB+1i/oarYbh51pgzWBJT
         ZXUg==
X-Gm-Message-State: ANoB5plo4CrFr75GdOefY30Xab2GrqWpoDhdLVXCPSpMUonb9eHm/2IB
        5jr7IYVJugB19rs0x/U9CkJ4Zw==
X-Google-Smtp-Source: AA0mqf4W++yII+JEJwHg1ZSnJBcLnVCaLxtGiBo9TVPZxhyKrxyFYE9NY5p/RQ+ELRJQi3lL/QqSWg==
X-Received: by 2002:a05:6512:1515:b0:4b5:5785:625c with SMTP id bq21-20020a056512151500b004b55785625cmr2429989lfb.361.1670147247643;
        Sun, 04 Dec 2022 01:47:27 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] dt-bindings: mmc: sdhci: document sdhci-caps and sdhci-caps-mask
Date:   Sun,  4 Dec 2022 10:47:13 +0100
Message-Id: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Linux SDHCI driver core reads 'sdhci-caps' and 'sdhci-caps-mask'
properties and few devices already use it (e.g. Qualcomm SM8450), so add
them to a shared SDHCI bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  4 +--
 .../devicetree/bindings/mmc/sdhci-common.yaml | 32 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  2 +-
 MAINTAINERS                                   |  1 +
 4 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-common.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 382d5face49a..c4c73ee1422c 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
 
 properties:
   compatible:
@@ -49,8 +49,6 @@ properties:
       - const: clk_ahb
       - const: clk_xin
 
-  sdhci-caps-mask: true
-
   dma-coherent:
     type: boolean
 
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-common.yaml b/Documentation/devicetree/bindings/mmc/sdhci-common.yaml
new file mode 100644
index 000000000000..1664615187c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-common.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SDHCI Controller Common Properties
+
+maintainers:
+  - Adrian Hunter <adrian.hunter@intel.com>
+
+description:
+  Common properties present on Secure Digital Host Controller Interface (SDHCI)
+  devices.
+
+properties:
+  sdhci-caps:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Additionally present SDHCI capabilities - values for SDHCI_CAPABILITIES
+      and SDHCI_CAPABILITIES_1 registers.
+
+  sdhci-caps-mask:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Masked SDHCI capabilities to remove from SDHCI_CAPABILITIES and
+      SDHCI_CAPABILITIES_1 registers.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fade797af150..2736c9a79f65 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -169,7 +169,7 @@ required:
   - interrupts
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
 
   - if:
       properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 3583c5f6889d..be71999cea73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18732,6 +18732,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/mmc/sdhci-common.yaml
 F:	drivers/mmc/host/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-- 
2.34.1

