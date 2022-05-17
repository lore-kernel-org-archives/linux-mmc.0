Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D36C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiEQSV5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352065AbiEQSVg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 14:21:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E09192BB;
        Tue, 17 May 2022 11:21:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so18088504plk.8;
        Tue, 17 May 2022 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVtCL90Qae4d8alJpsZ6NZkN+XgFY1ihCUWrdlNKxKc=;
        b=Ns3zTGCV5bxHw40xDp3VvAthF1xfTEFgaFvFAcXm8fAcnll3uJEabiAtrDv85TYJFB
         qdBuU0cPg28gvFb7iDiWaPMk67BwvVAHxkxM8baxgpCUe2+rtG8d5F7YTS2a7ZaAj/jg
         Um4lyLoBefdjgWB4TCahnJi2S5OK+YhrzXRw+Rbq+MGZfaHYQMOIbHKTJ9X8eTi+gW0d
         jZdyiK0CRg06gWbqbWe2ObqodmBGC2SSSduF98VrWMqHol9liDaJwCwZnKpS3pOiUndy
         UTQ5T/8bz5REucg3cIrOJiuvBnXDFGmgeA4n9mUrcp8giCWbCfOFT91g/brocYybGIo3
         9LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVtCL90Qae4d8alJpsZ6NZkN+XgFY1ihCUWrdlNKxKc=;
        b=FXGDdUufLs3p88NrOPQnFJ9gFIoqmQbx+w0UIxUCJb9B2bkIlwuyRmsoZflTrh2uux
         kj1i1li42F9ay2feaaMS1VVitS/6TJoGULupHHkV0VRZn73uUucrugMTB4WhVyjNeDqK
         TOKhkQja4i3GZmDplR4Hr7XZhl/SPUfSORxpt3ldyPQ5Rio+PRlzp772KFdct8WU4ZxH
         OnK2OSBWgjGiIXfuUMK1m8VTSjlUyp4/MsQfxAnbX0JSq4zDU9pYvjpM+M9rGphScpAV
         ipEIDn+j2KpKLeyKPxKQc3iTxJDZ8OJXkpXuPIHFCXotp3II68twH2o7ZLST04ZpDYJ2
         uV5g==
X-Gm-Message-State: AOAM532NkG4cnDdZpkilQRPUQQIpFGYz2Z3E0srfxiQyMUIB7XqjdC79
        h291Bpdlyi5DPrLTj8BGQmE=
X-Google-Smtp-Source: ABdhPJxlluvBJbnqIYOpmCUiFPEvBJtmJAd/7DRkLs5+AKWgfCAKFaqwI49KsBFtxQ4gqmkYHb26dQ==
X-Received: by 2002:a17:90b:3903:b0:1dc:8fe0:df4d with SMTP id ob3-20020a17090b390300b001dc8fe0df4dmr26374159pjb.191.1652811695225;
        Tue, 17 May 2022 11:21:35 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id 125-20020a630383000000b003f5e0c264bcsm837641pgd.66.2022.05.17.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:21:34 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
Date:   Tue, 17 May 2022 14:04:34 -0400
Message-Id: <20220517180435.29940-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517180435.29940-1-kdasu.kdev@gmail.com>
References: <20220517180435.29940-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz.
Optional "sdio_freq" clock is used to drive the bus clock if present
optional property "max-frequency" specifies a base clock frequency
in Hz that overrides the base clock frequency in the CAPS registers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index b672202fff4e..3a4f6e75bf5e 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Al Cooper <alcooperx@gmail.com>
   - Florian Fainelli <f.fainelli@gmail.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -42,23 +39,39 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description:
-      handle to core clock for the sdhci controller.
+    minItems: 1
+    items:
+      - description: handle to core clock for the sdhci controller
+      - description: handle to improved 150Mhz clock for sdhci controller (Optional clock)
 
   clock-names:
+    minItems: 1
     items:
       - const: sw_sdio
+      - const: sdio_freq # Optional clock
 
   sdhci,auto-cmd12:
     type: boolean
     description: Specifies that controller should use auto CMD12
 
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        clock-names:
+          contains:
+            const: sdio_freq
+
+    then:
+      required:
+        - max-frequency
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
-- 
2.17.1

