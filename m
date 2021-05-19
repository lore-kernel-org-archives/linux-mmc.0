Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A9C433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D52A611AB
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347685AbhESPih (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 May 2021 11:38:37 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:40744 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbhESPie (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 May 2021 11:38:34 -0400
Received: by mail-ot1-f42.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so1571989oty.7;
        Wed, 19 May 2021 08:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lURPJ0Tp6cffWbdcDk/gcuyUI4e1Gvlsemg2z1HRt9I=;
        b=riTnsh+RTStj0kiWrzAqNgeglF6kRja1stMJ1LrTloeY3UgE7c4FULiWr4Eb6SItBO
         rRFFN7EKGSEy3LCSjnEzmWnRnoE0WlbFZT5S78zuYeJfghXiOD5cqRtYmm1rh7uEYflo
         9L93kIEyExJcWqWavrHowvFuchIowDrohrbRfIenpmVyMaLr/L1H+B25zmceHNhBdH4r
         rhColDnwxf2sB0jvtsO0iFqIYy8vgzoSr2fQ3fQlHYob4ckm3diJ4Mv1QwQXXHxIYOur
         kpYOakCZ8wT0Da8Pe0CjP6L2HT739vQjPNtmRzMTr96GPh0K/NqRrYCWgPqxTl98LS6B
         BLlQ==
X-Gm-Message-State: AOAM53206NgCRmENFUNrn6fPYse3/bdx4s8bsDbnFmMrgjqYr8NWsaMI
        3Lo9g1i2ffuYH4hMULE1bw==
X-Google-Smtp-Source: ABdhPJy5qqoIeYSdUlTFzaSAScsD6TfO1CmRuwZqBB5r2Iri+uj0quO8xqC5W7HSBR+xQkcIFE6nbA==
X-Received: by 2002:a05:6830:13c4:: with SMTP id e4mr8990725otq.315.1621438633698;
        Wed, 19 May 2021 08:37:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v22sm4100046oic.37.2021.05.19.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:37:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: Clean-up examples to match documented bindings
Date:   Wed, 19 May 2021 10:37:12 -0500
Message-Id: <20210519153712.3146025-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The "sdhci" compatible is not documented though used as a fallback in a
few cases. It is also not supported by a Linux driver. Just remove the
example as part of ridding examples of undocumented bindings.

The "brcm,bcm43xx-fmac" compatible is also not documented. Update the
example to use one of the correct ones, "brcm,bcm4329-fmac", instead and
use a device class based nodename.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Also fix "brcm,bcm43xx-fmac" example

 .../bindings/mmc/mmc-controller.yaml          | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index e141330c1114..646ae768d625 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -357,22 +357,6 @@ dependencies:
 additionalProperties: true
 
 examples:
-  - |
-    mmc@ab000000 {
-        compatible = "sdhci";
-        reg = <0xab000000 0x200>;
-        interrupts = <23>;
-        bus-width = <4>;
-        cd-gpios = <&gpio 69 0>;
-        cd-inverted;
-        wp-gpios = <&gpio 70 0>;
-        max-frequency = <50000000>;
-        keep-power-in-suspend;
-        wakeup-source;
-        mmc-pwrseq = <&sdhci0_pwrseq>;
-        clk-phase-sd-hs = <63>, <72>;
-    };
-
   - |
     mmc3: mmc@1c12000 {
         #address-cells = <1>;
@@ -385,9 +369,9 @@ examples:
         non-removable;
         mmc-pwrseq = <&sdhci0_pwrseq>;
 
-        brcmf: bcrmf@1 {
+        brcmf: wifi@1 {
             reg = <1>;
-            compatible = "brcm,bcm43xx-fmac";
+            compatible = "brcm,bcm4329-fmac";
             interrupt-parent = <&pio>;
             interrupts = <10 8>;
             interrupt-names = "host-wake";
-- 
2.27.0

