Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D88BC47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiLBDOL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiLBDOJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:14:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97748D49DE
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:14:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q15so2665767pja.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZkOOgenUOJB+3MNGPa5Gxr5GLs9ZGNUzq9AquBy3H4=;
        b=gRSfbbdD7UbFjuhxzEcUcf4ybuKWiG9TFNobC9GJlIVcwgb8BYfdhQe/AYFWGN/iTc
         p6UNf3TfzXhIE/JrHe+4PaVHgznKEyEPUI6/eMU4XA5NryAXkOWIHoFgcNw19HC6AwnB
         5pYv0t7P9iGWSZpCbHmJ23uhJ4OUkb2kFqOr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZkOOgenUOJB+3MNGPa5Gxr5GLs9ZGNUzq9AquBy3H4=;
        b=tSagBpvwAMvd5PTGQ67tZL+MVV8T9jUJneayCn0Ao+4RwrrtmCgaydEx2XCIOUX7Jj
         96bESgsRDHfiZATvoiXBv67CxkiaRF25jVje/ZDwrsRXFrqJbXpS/2x6zxZtou086naU
         zM7yWr0Q7YZJg0B5g94Rd3fm8OYkiSVKay7TON6XMma12VACEAWmyFRnKtJ+mz5eUStA
         cXCAnQ4mpVdEpVto5kgV6dHuPkXmo85wfI40/3JumbW9NAbAa6j39A3sitfldgrexSQt
         BP6QnJ1Nh0JH2D1viBwfGYssk1dFrzfhow8H9tFe/OLpV7hnGXffgu0yzEccjfD1MC2H
         OYYA==
X-Gm-Message-State: ANoB5pk55mD+y50qEUzNRIbvUFAEe6c/6pzZTcizihDRQq77IG15G2xS
        1q3YIvg16j76Al9uR0N9Y95NMw==
X-Google-Smtp-Source: AA0mqf7eDqXjqXHvi9BpcPFLs3p7l/319UMdwsPF8Tt6idO6YQlGJxf8lCwlbe7/B1LiIQbs4STmiA==
X-Received: by 2002:a17:90a:d106:b0:213:1944:dde2 with SMTP id l6-20020a17090ad10600b002131944dde2mr72723184pju.193.1669950848040;
        Thu, 01 Dec 2022 19:14:08 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:14:07 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Date:   Thu,  1 Dec 2022 19:13:30 -0800
Message-Id: <20221202031330.94130-9-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible for the pxav1 controller in the PXA168, along with
optional pinctrl properties to use for an errata workaround.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 1c87f4218e18..8bb0eca506e5 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell PXA SDHCI v2/v3 bindings
+title: Marvell PXA SDHCI v1/v2/v3 bindings
 
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
+      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between SDIO CMD and
+      GPIO mode.
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

