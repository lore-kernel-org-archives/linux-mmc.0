Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE58C43460
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 02:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255C0611BF
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 02:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhESCrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 May 2021 22:47:52 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39751 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhESCrv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 May 2021 22:47:51 -0400
Received: by mail-ot1-f54.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so10500158otc.6;
        Tue, 18 May 2021 19:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdESKQMh43nC6JZr8BTSQsMvdc5KFh0MQVjejGwQt0Y=;
        b=tTjqqI56+FxdySyFkRVJgZLE2yZ2PIlGAKXp2uiMMe7r+KTwYfj5ETqzbAHh4Ntwzo
         6xEItnDMmlY0vkYqkCDReb7jcm3rZF6T9CRkUad9zKfnsaLBkadKQAxz3kVsz8pRb8jH
         AaJQ1oYW4EVwKdPQh440aF6CzwnG4omyCyh4ml2M1tNrOEokuUv1DpFvDINu75kBgMNR
         dE5+jno7qEIOP8/9EC2Neojj69q+WM+jxoIMYqDbYG1OyaDLK5sF15Lryow131n6xdxg
         otfxYSkZXJLsODaNAgkcRwGVRDSuuyI+iBtCwnjOr3UQVYpO3EwmIIxEaR7MaNmQX0jr
         gtKw==
X-Gm-Message-State: AOAM533gaee76CxuHO+H9L4wYkm4+2b97trUgyNPlBhRtDehL7tlOyB6
        4BwqEZyd/UcIfe22nLt3XlZYALQcxA==
X-Google-Smtp-Source: ABdhPJyLtwLU5cVvUUA+7JfBr/dF1/lkXauFhjIqpLcKY7qXxLRlJUKcALQm7of52aoqdd3FZ6HNqA==
X-Received: by 2002:a05:6830:1df0:: with SMTP id b16mr6692001otj.40.1621392392035;
        Tue, 18 May 2021 19:46:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x11sm4268909otr.36.2021.05.18.19.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 19:46:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Drop the "sdhci" compatible example
Date:   Tue, 18 May 2021 21:46:30 -0500
Message-Id: <20210519024630.1902477-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The "sdhci" compatible is not documented though used as a fallback in a
few cases. It is also not supported by a Linux driver. Just remove the
example as part of ridding examples of undocumented bindings.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml  | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index e141330c1114..6bf97cdd9507 100644
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
-- 
2.27.0

