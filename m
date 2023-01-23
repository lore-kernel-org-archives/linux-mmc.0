Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08330C05027
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Jan 2023 10:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAWKKV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Jan 2023 05:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAWKKR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2023 05:10:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A3EC7C
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 02:10:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so10233498wrb.11
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGsfIAFzoH7ggFb2voxRa7ZKIwz9PZMg5nKhBB1/kDo=;
        b=Xym58FVi/DyBHzoH5aFBOh1zqQtKsbxeJoh30xeVcts5R8r+TNBO0kMt4zeXDHFr8F
         HKIOtA5Te56KxdrZp+PwbV6jqqz4IIr6ek1oCdi1wqakg3VeTdmNYXT8AV4hA4FkpUwb
         RJwSLPpcTSTE1iL2LmxubojKsnoVwPOkEvL8xIyrNYVmfM3eNSguXyLunrnjCOZuXIpO
         S3cAutOmEpI4Da153O1lCX4NPzliTH4PuxQ1jUA5FCri/UXHpRrGYcXfe6FMpB/Wa7md
         DuJBl/ASQWwUnYopd/CuLLOH9ZGT9reXwj44KOqpuMmDs2SBWu9KPLoBRNjiPuxqLJj1
         Ewww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGsfIAFzoH7ggFb2voxRa7ZKIwz9PZMg5nKhBB1/kDo=;
        b=EVCLXTPhr05yfLrKg0hdOEzjCrjz8oI+dG74ioytL3jW71Lb40z/Yk8c4G99+AsqF/
         LdEs4Y8bg0okLPB+McjOS5p8dP1ajR2TiV1yUQFEkBB6weWxdEYJM8GGGaOAPGzaUjPl
         60lSJwtvylQFVL180xPYgev+sgKFVx3/icltbBaqshJJN2gt8GElkNVRaDJnAZm8N0zf
         CgKzKzdMqHhoFdwl0EnjX+lFmoGiRJuIee1e2D7oK4Rm11CTgiISSC5ALvQd20HA0JvW
         ZKmS5bukXKTyA1t8bwoa5WTZ7TZtDoUmCV93TjXf0D//oPyKZQ8TEypHH6l3UwHFu3og
         saEg==
X-Gm-Message-State: AFqh2kr7Mvh6LVXjctiN5kP4hysM+uI/PwQMI0jNSVDpBrVyOe/1Xqft
        fD1QmVPi3VphvpiuefD5knoCog==
X-Google-Smtp-Source: AMrXdXsuzAGVJdfpkA4r0vuPCPAnhlDTbdaJ8hZuZDAIdxluKGkX6uczQJsOtnSp0EZuPyQGa9j6xw==
X-Received: by 2002:adf:e44d:0:b0:2bd:f31e:3460 with SMTP id t13-20020adfe44d000000b002bdf31e3460mr19527988wrm.2.1674468606016;
        Mon, 23 Jan 2023 02:10:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:05 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 11:10:01 +0100
Subject: [PATCH v3 4/7] dt-bindings: media: convert meson-ir.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-4-e28dd31e3bed@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Amlogic Meson IR remote control receiver bindings to
dt-schema.

Take in account the used variant with amlogic,meson-gx-ir.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/media/amlogic,meson6-ir.yaml          | 47 ++++++++++++++++++++++
 .../devicetree/bindings/media/meson-ir.txt         | 20 ---------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amlogic,meson6-ir.yaml b/Documentation/devicetree/bindings/media/amlogic,meson6-ir.yaml
new file mode 100644
index 000000000000..3f9fa92703bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,meson6-ir.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/amlogic,meson6-ir.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson IR remote control receiver
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: rc.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - amlogic,meson6-ir
+          - amlogic,meson8b-ir
+          - amlogic,meson-gxbb-ir
+      - items:
+          - const: amlogic,meson-gx-ir
+          - const: amlogic,meson-gxbb-ir
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ir-receiver@c8100480 {
+        compatible = "amlogic,meson6-ir";
+        reg = <0xc8100480 0x20>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>;
+    };
diff --git a/Documentation/devicetree/bindings/media/meson-ir.txt b/Documentation/devicetree/bindings/media/meson-ir.txt
deleted file mode 100644
index efd9d29a8f10..000000000000
--- a/Documentation/devicetree/bindings/media/meson-ir.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Amlogic Meson IR remote control receiver
-
-Required properties:
- - compatible	: depending on the platform this should be one of:
-		  - "amlogic,meson6-ir"
-		  - "amlogic,meson8b-ir"
-		  - "amlogic,meson-gxbb-ir"
- - reg		: physical base address and length of the device registers
- - interrupts	: a single specifier for the interrupt from the device
-
-Optional properties:
- - linux,rc-map-name:	see rc.txt file in the same directory.
-
-Example:
-
-	ir-receiver@c8100480 {
-		compatible= "amlogic,meson6-ir";
-		reg = <0xc8100480 0x20>;
-		interrupts = <0 15 1>;
-	};

-- 
2.34.1

