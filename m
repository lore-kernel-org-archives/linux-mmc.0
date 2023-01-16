Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86249C677F1
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjAPTpD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjAPTpA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:45:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D02CC7F
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so8400336pjg.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkEROvqe/oVHJlSyZq7hsGS4ZpUmek5M63T+j5fOoH4=;
        b=AwdRFkobago4vsiJHwMe5Dh6GYla1J8byNau+Y1/W/hjY2G9cukKkxlc1DsOe/0tWc
         B1RmTtiLoSQL2qCQUne4j8FBSI6E8ZCREkl1qMQPGbcLruI70RSN/WgKdR7nbhLn7fsh
         TA4b/8dGaliM2Pqi2OyM53mXBZCDTZsltB0ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkEROvqe/oVHJlSyZq7hsGS4ZpUmek5M63T+j5fOoH4=;
        b=xXlPbMZH3k3gWgyx+hCm7oltKkPC/sxRmQUS2wTbksf/PSXU+uErfsK5+BhNrHtKZU
         +vvrExaWItISCMDuyUaO65+rJQDOTj3h8lzWMQZPhjeODrGIcr0eeiG6e276Ge7VGH2m
         czzof+8GL4S43yEU6M4clzSqcC6zzcW9diXN2mPgr67bP86QR3KUfEme4RzNgoGmZoBi
         oCfsSHv5O4KCpi/j6dEDNn+YEgKu7iF9T123G/ZFgekk3uGIPiQq57cSMMFYP5WL9USk
         2AkKGQSSwtEMv1IObwvup4cnuF7GQYTF+D56elcbRhFztXrsvlJG6AKmbt3qfkQkuv5D
         PVow==
X-Gm-Message-State: AFqh2kr7jK5+q9OfNN7GAI1+/ygKwrvTlbw5VDvLktB2aQmDV9OS27tz
        +GnOjI7ayOqWWr6ERHTRpmLqow==
X-Google-Smtp-Source: AMrXdXuD0kGeKwPpNjEc/1VtIg/Dq0/glQdIA/fz68EmdD22rK1QbkqKrW6o1OxjbZqLwtS8MazGKQ==
X-Received: by 2002:a17:902:e303:b0:192:6c8a:6b81 with SMTP id q3-20020a170902e30300b001926c8a6b81mr721733plc.31.1673898298698;
        Mon, 16 Jan 2023 11:44:58 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:58 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Date:   Mon, 16 Jan 2023 11:44:01 -0800
Message-Id: <20230116194401.20372-9-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible for the pxav1 controller in the PXA168, along with
optional pinctrl properties to use for an errata workaround.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 3d46c2525787..09455f9fa8de 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell PXA SDHCI v2/v3
+title: Marvell PXA SDHCI v1/v2/v3
 
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
@@ -34,6 +34,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - mrvl,pxav1-mmc
       - mrvl,pxav2-mmc
       - mrvl,pxav3-mmc
       - marvell,armada-380-sdhci
@@ -61,6 +62,22 @@ properties:
       - const: io
       - const: core
 
+  pinctrl-names:
+    description:
+      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
+      SDIO CMD and GPIO mode.
+    items:
+      - const: default
+      - const: state_cmd_gpio
+
+  pinctrl-0:
+    description:
+      Should contain default pinctrl.
+
+  pinctrl-1:
+    description:
+      Should switch CMD pin to GPIO mode as a high output.
+
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.34.1

