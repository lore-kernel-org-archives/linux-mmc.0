Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3604BCCA47A
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiFHXkI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiFHXj6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 19:39:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEE16B2E8
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 16:39:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 2so16098298qtw.0
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qQ2RizqshOjzvB3iH/wwzC+NVOLya1wNYtoVU7GxDvM=;
        b=UAUcZUkiV3VZQTR71Swi9iSLP2iNUgDgdZHzGDfJ1q/EFyU2zOn3EEmie/e/d8eyrk
         BCOb4HzXqzi46EUby2v8egnyivPyJ7IOpkpbUgurwodmXHMd2jq472sLIjoalYSwQxJO
         4YxfrIRcr9xYU16fuugZ8uiVRNZdTkZQ5gpERziLKwu4cAfIa2ye+Iq/EB/Upc+nwD/b
         Qr8CG2/CjIe6vW19WYbiVvTvibQB/Nc9ON1c0nmBWGmLiB5d0N8DNXHJeZLE4sJmxDqx
         uOIBbgt+OPOL5bndMn27FUTwT/Qh0ZyJHEztS4IoOPqfcby1uaM4OWWT+HBGl4wCGOtN
         ReaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qQ2RizqshOjzvB3iH/wwzC+NVOLya1wNYtoVU7GxDvM=;
        b=JO8InGGNAdpFeaEDx8/GGGNa/A5oEVDE1gY+b3ocdsqiWef+nmuT530Y1DYzAmlz9L
         TBdC6Ote78UYZtMzngEhK71dFxainpaP/AqfIIM/2sLlVTsBlDfqOlY7/RubZvTEAUTo
         P2YPhFEtd8nKYc9RCWX2fAQghMmCpNWoTXech/Af2ws4HF4VzSoRYAR4lRnssn/uD4l4
         uFHKPgQdgDD8PNHLPghXCcDNgWVaZiDzg9f0IPzXQugTbGkc4O+Fwo0jebYpJjUCCEtP
         4pWZO6JWJ42nI9jqm2j3cr/8hWoJKjfvNSZdR0LofiOMeIRuKAJMOw9LvnSdCpNZG5G/
         CbIA==
X-Gm-Message-State: AOAM532EFiuTcFDPOLVTtrw3qcxIJp16Ejdy/yFXIMcKAToTHvLKGvCE
        QYxOzrChsclVme+rLB5hs/22YLWHkcej3BmGHTEAOQ==
X-Google-Smtp-Source: ABdhPJwtH2lhtilN1G9Xw/rEf0VpiHf/XCVrIWgDPfCF0plfDp6bJ/WTYHxyxCYLxZFEeB0dzqn7AnVcRfYOD7c28rY=
X-Received: by 2002:a05:622a:5ce:b0:304:c37f:e7c5 with SMTP id
 d14-20020a05622a05ce00b00304c37fe7c5mr29342704qtb.398.1654731589495; Wed, 08
 Jun 2022 16:39:49 -0700 (PDT)
MIME-Version: 1.0
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Wed, 8 Jun 2022 16:39:39 -0700
Message-ID: <CABMhjYp4ChJ3KfP=jQmA5nnv7YB=Kkanjb2KwDEVWSS+Sn5m1g@mail.gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: sifive: add gpio-line-names
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atul Khare <atulkhare@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes device tree schema validation messages like 'gpio-line-names'
does not match any of the regexes: 'pinctrl-[0-9]+' From schema: ...
sifive,gpio.yaml'.

The bindings were missing the gpio-line-names element, which was
causing the dt-schema checker to trip-up.

Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
---
Changes since v1 [1]: Rebased on latest version
[1]: https://tinyurl.com/yvdvmsjd
---
---
 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index 939e31c48081..787ce7300118 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -47,6 +47,9 @@ properties:
     default: 16

   gpio-controller: true
+  gpio-line-names:
+    minItems: 1
+    maxItems: 32

 required:
   - compatible
--
2.34.1
