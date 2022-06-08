Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FFC43334
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 23:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiFHXj7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiFHXj5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 19:39:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7EF16B2D0
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 16:39:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d128so8824874qkg.8
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4bA3l8NMW5sqINO1r/1lERkOkDyuT51+2Y6gy5uYSqQ=;
        b=mXaDkRe8akpJUduhvftHXEgn4sTGP0eEV2OaV+blJVeqoLJU1FEsR+FaDtaokIeTFo
         2lK9ZQ4Btqss0RkOkxW3x432KfPG90WprbHJVWggfQXq/JRB2Eq9KakDyq54PxapLUsb
         hc6YdA++zF2yvpOYXxd4kGmXlP5tGj74azeYSpCXzSP0+1Vit7dY6IoOTH7fSQqlIj1s
         yee9YeuMp2V1s6EzXiZugIO5erzHwONKUBaKeFuAOfghBQjn4RHqP8EMP8KRQjpuqLhj
         j/JyfzkL+nHfEYgjqoadJF0gmOwtxWmOPdx8NHbKw5rZr5qqyAIjW29A8Wlv2ZY5Mo2g
         8Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4bA3l8NMW5sqINO1r/1lERkOkDyuT51+2Y6gy5uYSqQ=;
        b=ZGU82jOnulmmpo3VDL1k8VDHtm/moZzEl6KmiNkuWVTP9yTePB5gDHpKmBZ4dMh13H
         n5w03SrOanJU/gwm4US+JCDQGIsiHna+2/xPXboyGML10YVN9GvfMZ4o8nhFCcosfp09
         dNQWuW3i2tSyTEsLMqk01hNNoBjFoKIu4q2Flvwlz1JeJ4ZWtPMuJU2rU2LcTJAkdPcC
         5ToDow1a7xgs9LyQNxhNljNCZOXQy1aSlRf8yc+pHbQ1FDtHT0pzsehRUaxDGC566H1E
         6UmWKaD1HxM5L6f0G/6c0gxEHZvZxTKVrSEeax/I7a5aOc32GV0mzjFSaaSIYI3IapLH
         +EiQ==
X-Gm-Message-State: AOAM530PFIMZeVMlU4upjTxnFPbNv5tbRpnyx0Cp5J7q9BmELz9eAvyU
        BWfAxlBEXnm+6OxV8BiNT5Wi0dtQW+a5E4yrjwIuDA==
X-Google-Smtp-Source: ABdhPJwxVJsLtov+PvfiuEXEacNmD+Ogc8ArgM4bwUX+jOqXRNefAAAkqXzWVsoVgFJ+AB4KhEa/eKHzBy+/FzxL2p0=
X-Received: by 2002:a37:9b09:0:b0:6a6:b23e:8534 with SMTP id
 d9-20020a379b09000000b006a6b23e8534mr14825420qke.214.1654731582051; Wed, 08
 Jun 2022 16:39:42 -0700 (PDT)
MIME-Version: 1.0
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Wed, 8 Jun 2022 16:39:31 -0700
Message-ID: <CABMhjYq8WbHcA=8dRxHVy=-NhL3+GaRKsBb3X2bG2-6Azd2S1g@mail.gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: sifive: add cache-set value of 2048
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes Running device tree schema validation error messages like
'... cache-sets:0:0: 1024 was expected'.

The existing bindings had a single enumerated value of 1024, which
trips up the dt-schema checks. The ISA permits any arbitrary power
of two for the cache-sets value, but we decided to add the single
additional value of 2048 because we couldn't spot an obvious way
to express the constraint in the schema.

Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
---
Changes since v1 [1]: Rebased on latest version
[1]: https://tinyurl.com/yvdvmsjd
---
---
 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index e2d330bd4608..309517b78e84 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -46,7 +46,9 @@ properties:
     const: 2

   cache-sets:
-    const: 1024
+    # Note: Technically this can be any power of 2, but we didn't see
an obvious way
+    # to express the constraint in Yaml
+    enum: [1024, 2048]

   cache-size:
     const: 2097152
--
2.34.1
