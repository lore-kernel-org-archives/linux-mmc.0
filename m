Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC1C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhL0NgG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:36:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54560
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236698AbhL0NgD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:36:03 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F8053FFD5
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612162;
        bh=o1chKf4rhRGoYEviXpRjKWITlZ+Zc/lnutNkUw8AFLM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=st8qkPdz4Z+/tSG+GnVOk3xmqAUSe4OFgTvQA5fZSLwdfw0/GfdXNmD+ARJXyFTf+
         FobFIe5UWf4rFRpeRbS8hGs3iOp2tU8Q6+/iE0lKqH33IMMbO4DJk4BIzLiLhSHDYA
         5DKV6uCzXAj256nSuzqKaw9aEQ8WvGOzNDxz95jP+dVbIsJoBEZrxQ2wVVPFsc8aSp
         84ZUHWbOJ1NsOyyULxn4qM/zcvNclAIeB71nmm1cThueoXJM0QitaIG9fxhraOE+Es
         n0AH17wCtSKTU1oN6VcM6BbY4lsszmTY9w/CIdGBR57QtjB96nMaX4IG2udtlHnNjz
         RwTOg9+vAxUUw==
Received: by mail-lj1-f200.google.com with SMTP id z9-20020a2e3509000000b0022d8e7f5889so4607820ljz.16
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1chKf4rhRGoYEviXpRjKWITlZ+Zc/lnutNkUw8AFLM=;
        b=Caq460YRslVeEwq9S9rglHP2g75NTyhBQtsBZY+/6cyMP5WOYxgvB6VIla9/Rw4BAL
         D+sHQvq1ax7iilRvNq63TmKw/scHXte3LYm4QbcjHCFB0HGShEF6P+MIructg2WxSSIQ
         6uB+LcpluMMA4GPiqY/4NpXXT3R0msAPlsvLQSHyz3D2WQFSVfuwlORKa0ilF6NMvBTG
         vWYdZqWuf9+25ODf5T921qb16stE/KpoEn8zUKUyG8nrezNvEbznHygVZg0CzrVVrp4o
         F0n2vbprR77cxmh5k8qaxp0+N9dIrILIlDu4qWcGfm6mO0PPKoLDxx3r0DUUhKxv+SvG
         uTtA==
X-Gm-Message-State: AOAM533RIyRTQiGPk95er/L0KSCSrz6ntPtkpJrBtZV0TbJMKwPu8C61
        PYjTk8tvgl5ELp//CD1329O6O1rf3qeZNs1QgQezir/OlQD0SOLCoQNnhkijlN38cdkWxptQX9W
        MfOL+fbNaGSnit3hPXmiWdB29NA5HS7k3ScE0rg==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr15088859lfd.330.1640612161372;
        Mon, 27 Dec 2021 05:36:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwva8zKPnEw3lVn3bSljA913LVhJSEpc5uwboSFZa19Mf6V7NKXYAZqLhEQ/3hK1oeP7iLGxg==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr15088851lfd.330.1640612161216;
        Mon, 27 Dec 2021 05:36:01 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 07/19] dt-bindings: intel: document Agilex based board compatibles
Date:   Mon, 27 Dec 2021 14:35:46 +0100
Message-Id: <20211227133558.135185-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible for Agilex based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/arm/intel,socfpga.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,socfpga.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
new file mode 100644
index 000000000000..6e043459fcd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/intel,socfpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA platform device tree bindings
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: AgileX boards
+        items:
+          - enum:
+              - intel,n5x-socdk
+              - intel,socfpga-agilex-socdk
+          - const: intel,socfpga-agilex
+
+additionalProperties: true
+
+...
-- 
2.32.0

