Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E9C636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 11:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBPLtT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBPLtS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 06:49:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B78A4F;
        Thu, 16 Feb 2023 03:49:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c1so2417955edt.4;
        Thu, 16 Feb 2023 03:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZp8T9fi73Ck6TTiN9PFZMW2/xgQskNbCXDB3+L/Jqk=;
        b=msW4Y+9F7v3GP/Ws3yy3pWZUitF7Rs7w9AYX7TGacdEQJhPbfuFohCZfURFFpz/uuz
         R2/a2GDiDf9qFi3bTs4vvtNW9w4VAYzc6BiondacIDtdwNCqQWSNgMWaN1Kyb+laoxCH
         aJ2nqPcMKa/T3VZFPzr7I5A6jl4nZ3b+0NiLfVpAVzrHP4wiItxifBpMlzawJv7A8TQM
         BEv26XVmcbB+vcmSjOdjA2VsITiXp/hS5oz257vTfnlJART0GU61wFlQWI0ndEIRZc3V
         z2czMP/Oxj2722Ube2LnuvYyvWf4wrwA9yGPVpGg3F3P691V3gmgzmFTHQvWCvqRRpiE
         yIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZp8T9fi73Ck6TTiN9PFZMW2/xgQskNbCXDB3+L/Jqk=;
        b=EbFnnSEwBjgRFQDGb/gxiVDo98AsXfjgaXDvyClOQARcu/52UuvpR39AGOPn+daCeG
         iFcgs7Wc1Y4xgeZKDHqt57m0KFGb2kdrMGfcnIadwqaXv5feomRjeyy9dbGz5TIrEu1g
         1qzVZs1S7S57uNJSJ8fzdoqcLh9S8ybgzih6rtL4sbWKb8G3xHEMn03v2JneXxlCSo+x
         L+dsKzd0pKYvwK3IKsrcsIfdz5bSL5bRyyDD2enKkv86m+j/azldm2vZ355dbw2k/WXO
         UDNbsAlHMsYcaK+o8zg9u8Q4qneIaLz0Ot03pY69udR9Xv/yNWoEot86lOdNh7vpDSOm
         e4Fw==
X-Gm-Message-State: AO0yUKXr4DwDYanI4ZFmMMk6UO1fBw7M+emBJWcwtP0kddlq5BA/vjty
        KMZ3LGcfqKJQngM5o0ttEwg=
X-Google-Smtp-Source: AK7set/SXR4B4Vuo6SZP5T42kzznPPMtBk0rXOFZeXHmBv43VoLdr0/PcANMxUJFUzoRT/kngfrw/A==
X-Received: by 2002:aa7:dc13:0:b0:4ad:152b:8f69 with SMTP id b19-20020aa7dc13000000b004ad152b8f69mr3662830edu.17.1676548156056;
        Thu, 16 Feb 2023 03:49:16 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:7889:e4e8:274c:ee22? (dynamic-2a01-0c23-c4f6-7c00-7889-e4e8-274c-ee22.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:7889:e4e8:274c:ee22])
        by smtp.googlemail.com with ESMTPSA id y12-20020a50bb0c000000b004ad15d5ef08sm742451ede.58.2023.02.16.03.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:49:15 -0800 (PST)
Message-ID: <d5542f6e-920e-93cf-a453-b0601d03f48d@gmail.com>
Date:   Thu, 16 Feb 2023 12:49:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
Content-Language: en-US
Subject: [PATCH] dt-bindings: mmc: meson-gx: fix interrupt binding
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
 .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index c8c30300d..cd3f75821 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -28,7 +28,11 @@ properties:
     maxItems: 1
 
   interrupts:
+    minItems: 1
     maxItems: 2
+    description:
+      mmc controller instance interrupt
+      optional card detect interrupt
 
   clocks:
     maxItems: 3
-- 
2.39.1

