Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A742C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4A610A6
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHSPpx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:45:53 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52712
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240269AbhHSPpx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 11:45:53 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id E68AA411BC
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387915;
        bh=oQMiOvmPhv/1z2rOKVbJqGE7XkhSX2/8Th51kVa/d5I=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=htBWlaaLdGvz0lxlml1X0CluvdqZon2zJK2DEszSZd8usVuPWLphcSYUz5nULn6Cr
         caG/2Bd58qi+51NOO307um2X+C+uN21A5UN+/GNGUkW8gtUAaHvp4BVIU+YIPUX4Mh
         Qj74/I5o9DBiw0b2l94eCK/Q3KKFJfuNgE2Pk6K+V5G4++on7CcD75VhiibpeJdNeC
         dhv2+PfEZBDFP8yO/Ps5rzDH7lhkX/CJoobeJLNnJd3UJPwqrhmjRfJmr9jsj8pb7w
         lASn3N9Ek2seiAJU3cei78cBUw0tXuglKgS/jeeOABDwu6Yr5lTUPvG7Rx+rwpnpnV
         BC5wQUbcvCBoQ==
Received: by mail-ed1-f70.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso3028955edx.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQMiOvmPhv/1z2rOKVbJqGE7XkhSX2/8Th51kVa/d5I=;
        b=BVUzibbFrTJF07aHGF8lIX2875iezMkHJUM+oqq4MvquP2uoJ10PoyxOZ4IAV56Eyb
         cgrpbUMRXZYFZwpXWLP6oXTSzU+gtr/URYPrMIn2COl7O246D3pmlK45o64vsxXdd4yW
         dM5bJYzsxxA1GZPT9wGfziziN7W6Y5P4tYQbE9uUQUCOEDdNG3anLMoxLQd/X7jxXrd0
         TsS3veJWvHNpIoTkjn7DpH/xf1VZQo9egJrfpNfd0iytPuPDv//hzaCFZfGqYOeWzo9E
         1ezk+3SCu/MFVIXjoOaYcLfOcVFDwXLqkJSlOkbuyiHoH3cRdVTo0L8wA6D2vs0ppCoJ
         MMkA==
X-Gm-Message-State: AOAM533AWwAGFJAsT+69uCnEh9/w5feFD8pTJWATFXAE81XVoCweRMh0
        eC5V6n3DXyFtajL81X/M3+lcLiufu11BB2+AYw+56qBKbjAII60ONahaACsF3Ts532neF32YQ5O
        w1NiVGxMq1tVT40Drj4faitV3BbE7BbIk/wu1aA==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr16901479edb.240.1629387915594;
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAEWiZz1c1r34QEyTMCWKIodNsdb2JaUuRv2nhyWDs0CmReup5t8cL3kDjjf8lf3M4RXzjlw==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr16901463edb.240.1629387915485;
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: riscv: correct e51 and u54-mc CPU bindings
Date:   Thu, 19 Aug 2021 17:44:31 +0200
Message-Id: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All existing boards with sifive,e51 and sifive,u54-mc use it on top of
sifive,rocket0 compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: cpu@0: compatible: 'oneOf' conditional failed, one must be fixed:
    ['sifive,e51', 'sifive,rocket0', 'riscv'] is too long
    Additional items are not allowed ('riscv' was unexpected)
    Additional items are not allowed ('sifive,rocket0', 'riscv' were unexpected)
    'riscv' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..aa5fb64d57eb 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -31,9 +31,7 @@ properties:
               - sifive,bullet0
               - sifive,e5
               - sifive,e7
-              - sifive,e51
               - sifive,e71
-              - sifive,u54-mc
               - sifive,u74-mc
               - sifive,u54
               - sifive,u74
@@ -41,6 +39,12 @@ properties:
               - sifive,u7
               - canaan,k210
           - const: riscv
+      - items:
+          - enum:
+              - sifive,e51
+              - sifive,u54-mc
+          - const: sifive,rocket0
+          - const: riscv
       - const: riscv    # Simulator only
     description:
       Identifies that the hart uses the RISC-V instruction set
-- 
2.30.2

