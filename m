Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B43C38142
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 03:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjASDnD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Jan 2023 22:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjASDmT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2023 22:42:19 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F66CCCB
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:40:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 78so505323pgb.8
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9zD9oWQnbZ75azYdkubAjDxtGIPkmpxtF5o8raYmT8=;
        b=AvBIk3D/NbOYmdCx2aXuzS6kUyfC3pJMNs45qBwLp+DKUjfDJon/3928NgGXA5ac37
         MSmSH6IR6YYmwA61psHNhRqKjnHsR/5VLNIJtmV9tTnQnHre0CQKOq4xph/66zqb/bo1
         ueTytX2YGnHKJWagl9y3AyFZWTXR9hQvnpFac2pX7C1prSLZ61Rw8bKCH9hEB4vzNZtV
         T3bGu9QzZ5Tk/ppiVOySFaAl4D+qTWltDzPoRm8FlZvxOaH0wZ4mqJYz7DgEpQNcbQhQ
         LupXhoTKA10YB3Avqy7VqQ0BdXoNEOgLLaMPX8p7IH0LeQYcbugBs4X46BXp6zoxaYVx
         iUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9zD9oWQnbZ75azYdkubAjDxtGIPkmpxtF5o8raYmT8=;
        b=qH+S7//J0UV6tDVXhx4PmH/PxrP3O+DksfAEvkKQcSzAl+stg01b5NqxHtUFMzN4Qg
         vSFwmt7LCgLlaokyQ2TiOS89FETNFcVPd6X3zga7KMYF6jACflM4ex4KiBLZd4uRKC4y
         y+CF9JPqhCNKn6AVXvE8WiSlqFaYq2ZXQC+QJCapGMY1JAmIvKfzY+swachjc5SPJnP8
         PVj34ccFZQb5D4/FVb6BJk8bmoB2m6ogWIwA708taGT6iuLKxm7HpYshRFsaT7scKiMJ
         FsfhtJnAphFSUru+B7waS8zwjO/kn5NxTqeA1cTDMuPb6jVMs91K9iOsDy+/cWxJCWel
         oShQ==
X-Gm-Message-State: AFqh2koy9WZ1kfJ6UR92Y6+FT2crpl7RZnq/SnPjZJpXfuO7/L7hrBjo
        BCd/0bdcsm0a4mDqWvGP8bXXFA==
X-Google-Smtp-Source: AMrXdXtBHrbGDP4nBgKCy8YDpYjY1w3ldJH/cA/P9YX2sDEU3ICzJAm3gg68VjxWq9PBdt4hJdQPYA==
X-Received: by 2002:a05:6a00:4519:b0:58d:f047:53b7 with SMTP id cw25-20020a056a00451900b0058df04753b7mr3260299pfb.3.1674099602358;
        Wed, 18 Jan 2023 19:40:02 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:02 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:39:06 -0800
Message-Id: <20230119033918.44117-4-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the cadence qspi controller compatible for AMD Pensando
Elba SoC boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <blarson@amd.com>

---

Changes since v6:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 4707294d8f59..a6556854234f 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,23 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
@@ -48,7 +60,7 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
+    enum: [ 128, 256, 1024 ]
     default: 128
 
   cdns,fifo-width:
-- 
2.17.1

