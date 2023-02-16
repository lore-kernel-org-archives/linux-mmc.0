Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E59C636D7
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBPTu3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBPTu2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 14:50:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11853A853;
        Thu, 16 Feb 2023 11:50:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id eq11so7086883edb.6;
        Thu, 16 Feb 2023 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WbCjPVVHxVyatJVjIE5iJwBzccUEGGzVCMAq6wVW1E=;
        b=mSWg2oBKFkPul+atB5VeAVNgOr1TfqCf5rNbQI/cRUaUs7SZohENoUOegYtyDBgdjW
         qzbNn6w4RFuvRyuzzg3IWSMvIdci+iSlK2Q6Yk8z00moPhOyPu6U161NhgodpP5qbafP
         8xKOC30NdV+mzkTEPOVY3kNASR/RasCLNFZjSGML/HPDHtRP6Nd16tDvhwoBkpw//LG8
         1cpb+6Q0IXAEPOlvr/2nyrA6ZpNxbdkyctEAcOD6Fiyn0HOCVWzXhKHGb1sU2O4jhCrg
         GBokeBVilUdtDrjdZYJjWkm2rLyaC6gevc78uA84if2S6smLsT38P1KyCe2HbK8t2KXO
         pbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5WbCjPVVHxVyatJVjIE5iJwBzccUEGGzVCMAq6wVW1E=;
        b=i6/5jU3r6EZtny1lAKHNPZ7PEXqOnmEEDJ2IQ9hVsox3xVjIdeHVEpyIB/YYNe2cd3
         PUC/ysoN+mqKCtGn1eORbrhlc5HgDSLDABFOCBcXzKvTE5J5/4K+M5qHOgj5vMPaaLVm
         Py0uOGY5Ytow+h+w4zmvXdBeoOS7LEDV4yuA7u6CE0iQLFVtym1xEculCyuvzPDZoXFf
         ueRCH4frJ6M7PTSbapTjYTxrWf1e4TE4UGm1PBqde3Jf/1zhFtRcSKYvkdHrAQ8jXr+l
         C/Yfgool0Y5LBhOveIK/C6tiRVjZBQjeSwiBnJveVjgH4bcpX57dyqOjmdSApdj3fIAX
         b9jg==
X-Gm-Message-State: AO0yUKWMUKO2+CLqHZnWmNxznwsKSatRyEu1PYGxokvxiS77Q9cC4xCz
        85+4gezR5WayfWvrBd2w5tM=
X-Google-Smtp-Source: AK7set/8hJwZaPL25gBs7qCnElf8JUzDRNCJ+vB+zV5BWa3yWWyCY8bo3aUHbv5/JFssem5zK4+evw==
X-Received: by 2002:a17:907:98a4:b0:8b1:32dd:3af with SMTP id ju4-20020a17090798a400b008b132dd03afmr7489651ejc.28.1676577026386;
        Thu, 16 Feb 2023 11:50:26 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:a039:5cde:fa47:7ceb? (dynamic-2a01-0c23-c4f6-7c00-a039-5cde-fa47-7ceb.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:a039:5cde:fa47:7ceb])
        by smtp.googlemail.com with ESMTPSA id hf13-20020a1709072c4d00b008868cd4ef98sm1178667ejc.87.2023.02.16.11.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 11:50:25 -0800 (PST)
Message-ID: <c1437eb6-0c01-809f-422b-cb1109489355@gmail.com>
Date:   Thu, 16 Feb 2023 20:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] dt-bindings: mmc: meson-gx: fix interrupt binding
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Reflect in the binding that the cd interrupt is optional,
and add a description of the interrupts.

Fixes: 09b31a610328 ("dt-bindings: mmc: meson-gx: support specifying cd interrupt")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- omit maxItems and use items
---
 .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index c8c30300d..bc403ae9e 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -28,7 +28,10 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 2
+    minItems: 1
+    items:
+      - description: mmc controller instance
+      - description: card detect
 
   clocks:
     maxItems: 3
-- 
2.39.1

