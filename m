Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A9C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 04:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiKHEPK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiKHEOi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 23:14:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7DB1A06D
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 20:14:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d10so12718622pfh.6
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 20:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvVKBdD+O5vHgZ+WUSF5TR185G5cSVikAYO7GBsOUyc=;
        b=Q8jmaePBVTwlbLFxwaxJK2Eyh7lMIse91drNfCwWtWfseBIbUofCImwGWuSQWdWOgL
         KeSXzrYMZ2aPQlFwM0JpspT7ruyJ4ykJQUq3aFnFjDQm0iHC7Zo4veWiWKrS/pBL9fCe
         huOf2aU1YuTImJYADUJFvUOA5b+pEj9Rsqp5KB5oA+kT67qdBWfh76c2UZc/FW7oVBlH
         HaCTpYWCYvWBvpY3dnVncb1CieLXHKIyfwlPJNmhyEJ47JagONqNSgiZ6pAIE+EkO3s+
         c2ACVwEyQyhTI/Z4HQ6al2f4CYUds1oXWF08XmFFNwFeoaWTjy6x+F88aq8lRaglFS6A
         kl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvVKBdD+O5vHgZ+WUSF5TR185G5cSVikAYO7GBsOUyc=;
        b=rwnPfuHAWCTfuDbL6X15V/Duur5x6sVMzRTO1vLvPcT0BQX8QgzFWyx1K9bNltOoDM
         bWfbTlnmQgzVH/rmSbF6UQGjXnyMN6hCMfLsAiEGQrbf46rwBZAOpCm/P5EGWCqiyccn
         eCornl+zi5CDQu6Xb9aNdo2TJygxyzY9GtJtK9hAMLNNl3eoJUfSRW1ItwPF2TA0mwS8
         jku9Ps/7gwktVJbzjwcCqf2rA+DNih9Akgw7ZLZ7WbCNNZs+E/sLGAbZ/9VJTzsrUgUg
         HIIRfXjClhhbm7T95QtYtyaPdH5jEt+2GxAMT95flQv7jHf3XxLGNM3fFbuYJ/qDG+yS
         yF0A==
X-Gm-Message-State: ACrzQf15/LAOfPL55TikfIdL7kdeGjwWiH/ghpY49BCBpQgDZjwXHmjl
        lh5J/ZjV86UT9wKtfngf+zWNNg==
X-Google-Smtp-Source: AMsMyM6wsYcCCVpobtd0f0K57c6DyDwurbZLCHjPx7BRWoNlRXbMXPqq13o+JkUY8ua1OJZvF6IKTA==
X-Received: by 2002:a63:fd4f:0:b0:45f:d7ef:9f94 with SMTP id m15-20020a63fd4f000000b0045fd7ef9f94mr47171172pgj.137.1667880874769;
        Mon, 07 Nov 2022 20:14:34 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a809:63d1:2564:ea55:4e97])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902b78500b00186ac812ab0sm5799783pls.83.2022.11.07.20.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:14:34 -0800 (PST)
From:   Jagan Teki <jagan@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@edgeble.ai>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v7 02/10] dt-bindings: mmc: rockchip-dw-mshc: Add power-domains property
Date:   Tue,  8 Nov 2022 09:43:52 +0530
Message-Id: <20221108041400.157052-3-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108041400.157052-1-jagan@edgeble.ai>
References: <20221108041400.157052-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document power-domains property in rockchip dw controller.

RV1126 is using eMMC and SDIO power domains but SDMMC is not.

Cc: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v7:
- new patch

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 95f59a5e3576..c7e14b7dba9e 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -71,6 +71,9 @@ properties:
       to control the clock phases, "ciu-sample" is required for tuning
       high speed modes.
 
+  power-domains:
+    maxItems: 1
+
   rockchip,default-sample-phase:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-- 
2.25.1

