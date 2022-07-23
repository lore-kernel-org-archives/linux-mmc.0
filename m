Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A223C433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Jul 2022 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiGWUos (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Jul 2022 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbiGWUor (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Jul 2022 16:44:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19631B795
        for <linux-mmc@vger.kernel.org>; Sat, 23 Jul 2022 13:44:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o12so7160344pfp.5
        for <linux-mmc@vger.kernel.org>; Sat, 23 Jul 2022 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnz8KtlLCVShEDXOBH4fLkKrMCVF+oQhhCLrqdUx4uU=;
        b=AkLPquELdVZFdKsl5L1dqydn2AMRu42dCdVIwYpfYKFAjZUGoISFM8bmWfkNbuCD4O
         SkRgi5tsKnkWK09/FsQP8cv0Ic1r7KQpzhdUspRlW+JHZqDyAMPrtupMnQbaa7baYu68
         DXhk6CVlZJxATYd4QPHmEPq1dgrPZM5ctK2hFcpoy9BFbebM2nfQ4b85qmz3S+vqDVwr
         cdPLKXW0oZdOp0hhPXLHokfErKSL1J1nKD410Jx/oCGLSCo7xISBPtB3C76EUyPX6uAT
         9TqDsxo6oP9REPqy7+3n1xgfWmJ4RkrNOZNq0rEV7SZFWxQ4fcEHPxAy0FHNIhVPn/P9
         inww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnz8KtlLCVShEDXOBH4fLkKrMCVF+oQhhCLrqdUx4uU=;
        b=DIkum3bpS3Y0oFskpWOUl04zoJoLWiyAX8Bcojm4LU1cBiSKekuJHkNDRkm+B32nsY
         x/1InpGxl5wGWGHhmL9EAjEr2Mj8Gf8HTDjMI9A3mWW3dGNL2Ltb3xgbzyWmMK0oDZOV
         NFA2Nn+GLWaGReADl/aroaSFHA0bgJ80d96WE/iRgWmBba4BxUasJnZ4FXlB4TyCu0vb
         0N9gzONyBDwKoTGPU+4wxCnK+lzwJR62sIVHmiR5NAPePoeE431X3DYqWiv3XC95Szs/
         AAHxCDpO4mFiTULQAs8WrR/gKWdGU42NhOOhrF5TEBWvE547pEyRn4tk5+JDc8dU1Etp
         zKHg==
X-Gm-Message-State: AJIora+PpAV/5BLsg+1PCNV9F1rfGYuu9ua0Y3yw/miY7Q8btVVlEHpT
        zun3V0XO/9ZcxEXj6ssOv8MkLQ==
X-Google-Smtp-Source: AGRyM1vcjLOLjkuzKVFR3gktiaujZIDm7gd5DyEJi2HmNt2fT3M104n755k3GbXZzTRikp45GJJkYg==
X-Received: by 2002:a63:8b4b:0:b0:412:96f4:f154 with SMTP id j72-20020a638b4b000000b0041296f4f154mr5061566pge.281.1658609086392;
        Sat, 23 Jul 2022 13:44:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a073:a406:cc30:f4ec:f10a])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b0016a6caacaefsm6187950plg.103.2022.07.23.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 13:44:46 -0700 (PDT)
From:   Jagan Teki <jagan@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jagan Teki <jagan@edgeble.ai>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/22] dt-bindings: mmc: rockchip-dw-mshc: Document Rockchip RV1126
Date:   Sun, 24 Jul 2022 02:13:24 +0530
Message-Id: <20220723204335.750095-12-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723204335.750095-1-jagan@edgeble.ai>
References: <20220723204335.750095-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible string for Rockchip RV1126 SoC.

Cc: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 54fb59820d2b..8d888b435817 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -39,6 +39,7 @@ properties:
               - rockchip,rk3399-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rv1108-dw-mshc
+              - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
 
   reg:
-- 
2.25.1

