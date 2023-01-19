Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4BC00A5A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 03:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjASDnX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Jan 2023 22:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjASDmQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2023 22:42:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9F69B38
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:39:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so1091848plr.10
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
        b=qoqKcYS8f6LMfCltLCw76kTijQXNvX8/VfSXOt8OQrO2E8WQaYIhFmesf6yohs5pCL
         CKe9/hsZiNYjWzFOxE8+B9URT7SJoH8qGUey1J4QXn0UcWxlbgMZNlEAFjewsp5T4lxS
         oKV5aeT3lsA7bO2sBGFyhsj14m/2UucKNjWqsRl+8fuy+YCWQ9zlFLvQZdrDjEoYqug4
         Ol7di2eThl9GBfTVpWJJQUHB0bMtZv6nv244CE/TRC4TFC53wNdW9mkC/kWX6d4MsdWK
         8uAfsPcBZUSepvXvgxsXuSf/zZIMFO/79KjunLxONC5XWH2tN8ihE875BDx9+hLxAtvh
         Cdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
        b=KVPvM2Cq5xoQN1XtbWi+8OwfFIb8RZCRQfqnWMfMWpwLH02uX6np9f091gnEFLsD4O
         T/3gIEZ4WWFVtxvWMzXIPE88vPHMaOKY3OAJm6Zy1ocRqVbGg/oUpWcxVM4y9tPQFARu
         OSFRoCWrSUk2O9RGNlSFwMsNPMA74dnuh8HMsukipXWU5SEk4idxHR8ivsJQc98agmhA
         0DG6mbwpVIrAko7KqHXBUYf1HXx7BUWMqSEL/C6/E0OMfPkGB4BYxdXGydCGNFLJUcIi
         TwseHPwKBGuVbFP6B81nG9618mJiT3Ya3Q4KSM6AjFOKQUd/n+m+LwBahPP93+kO+YRp
         lqqg==
X-Gm-Message-State: AFqh2kpnaIbVGOUMSVDUx8nFhgHIh9Yb3NKD7WdTfUhsX5f66JVqQ+Oe
        dnFt5ihv7ErJDrNjSlI/PQoa0A==
X-Google-Smtp-Source: AMrXdXvbKqKaMAq7GGHotAAAqe4B4wwrXEa//ZM+fYtZneMxVJOeS6SJD7B7/df7q0hm0iWG4UMHMQ==
X-Received: by 2002:a05:6a20:8f0f:b0:ac:9d6b:c1f0 with SMTP id b15-20020a056a208f0f00b000ac9d6bc1f0mr13369763pzk.40.1674099585005;
        Wed, 18 Jan 2023 19:39:45 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:39:44 -0800 (PST)
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
Subject: [PATCH v9 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Wed, 18 Jan 2023 19:39:04 -0800
Message-Id: <20230119033918.44117-2-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

