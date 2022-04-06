Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65013C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiDFXjK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiDFXjC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:39:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08C1FCD39
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:37:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 32so1369705pgl.4
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t9+gL+y5i/QNCIpTjrcXEFiRInISCquyFyxbsO8XL7I=;
        b=lQrv/P4hn6LlciweT4SqZd0iOxn/16y7L9KiKpSME26a0sh0Lx3lmpQx8Bux/PeMie
         6oESrbi1ZDk+AeB4gmp9ssD+tBtvnO/2e6lbfSO6V3ASIzy5nDRSQk9jvhj2SIRwyzOk
         4oCixuJcyRhb8Yi+pvL9vzv6O6fWGV3JixIG9gnQBbV48WcrzdWiyuRfUPDF5oVq4vaB
         OCzAzCbGVDlvE+xdjAgkkAZBUyFO3TpVStor6GDEcMP/4mNfEaILG/BR6y0kl5l9lQXK
         hA8tLndD13GXUQQcW1sY9MazzEHiVaJ6Hx+fO6hn8cr5F5kTGVjIgZo18icnwnNq7Rus
         VnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t9+gL+y5i/QNCIpTjrcXEFiRInISCquyFyxbsO8XL7I=;
        b=DpdaEvhfo8xB3VY3MmQspG+pJNAiyV7Eorza6GqWmwZCGxl2MU5q8fa8NnEZ/LGy1S
         uMStpChqK5gFQodQ9+orQ++TkxiL5DI8Pr4uw+DlhWVebRS0WDJS5IPOCyqR5nQIOmcN
         3vOw8/Dy5d5G4uormlGe1ToVgxD4BRcNffgyoSRUakbQR+9UpFWW00kxLd2fxfiTaAO6
         5tJOWqgmvgb3i6MiHGIQu4BLVIx0fFKNhznyPkXy6NrggVAT+d4W7jcz6Y0417ED42Y5
         vupmf6g7NBrdTB36dceFFySdNDy/dKANaafFe49sf2kvCafLE3IKZ5xPaqGdr/M/sMe8
         bP0g==
X-Gm-Message-State: AOAM533brSEygjfMTPnugKc8VUC+na8sB1m/6lxOmX4QWvQMhLeZ4m6l
        47k+tazTXWz96jldjM2qwd8kWw==
X-Google-Smtp-Source: ABdhPJyoPs4NfFhETcRlRVHyTU1R8ztOjFcl2xaEAaNRVRkgtvbj80h35dMSkXq9sZjkkjDMfvNPiw==
X-Received: by 2002:a05:6a00:815:b0:4fb:e46:511c with SMTP id m21-20020a056a00081500b004fb0e46511cmr11195728pfk.54.1649288222881;
        Wed, 06 Apr 2022 16:37:02 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:02 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Date:   Wed,  6 Apr 2022 16:36:38 -0700
Message-Id: <20220406233648.21644-2-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the compatible for Pensando Elba SoC boards.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Add description and board compatible

 .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml

diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
new file mode 100644
index 000000000000..61225f2d6ce5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pensando Elba SoC Platforms Device Tree Bindings
+
+maintainers:
+  - Brad Larson  <brad@pensando.io>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Elba SoC
+        items:
+          - enum:
+              - pensando,elba-ortano
+          - const: pensando,elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

