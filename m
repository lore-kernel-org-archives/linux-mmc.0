Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E0CCA479
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jul 2022 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiGDOgD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Jul 2022 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiGDOgA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2022 10:36:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D2F5F70;
        Mon,  4 Jul 2022 07:35:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q6so17021455eji.13;
        Mon, 04 Jul 2022 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qug+tGd/uv8M8y6IpXu01dxX5KR8Rz6tR9sYA3ZUCL0=;
        b=DxTAQz5O4CB1luNJIU1Up1n07gzJgXRIAnqXDgfOk5MQntouP1Y3dj6uC/gnuw5jZb
         TnCqelpJRaytapG2iG9OKN3RyZOYfVN4oMeaj646i+e3YXPnUbeGHAavTgvd3xKEx8+4
         1M1yS4FHQZ42jvzNMjXXzIYSAlcCrzsakzh/rws3fPP3KoYJhI/F9e6jMqNhypJdjigl
         9po7hoYnJkdD5j7AhrFb50kb501gZTkq1Fv3QL2tbLysbjNgvSCrIoGULUgJIYxV6UkX
         R2DSCGT5++IE6Y5owgAC9tRLJDeU3POgihCPWr2WQQ96hyrbHgpJAXl+wQWANrrHsVXS
         XTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qug+tGd/uv8M8y6IpXu01dxX5KR8Rz6tR9sYA3ZUCL0=;
        b=vOzzs3S6MYxdX0dcJdSgwpDk99R/XsrVo1oz20btf2uF2LMg2zmECuXJ/pa0amSGIh
         +19zdqprowXxinnxSpf68ub4WN0avSoNSVyR4s6SJV/P7B8Q1P09x80nWAo/Mk/VuTSC
         3MTFhEQr0ok9dTSYaeBXHbh7KJg/clFV/s6BnzvDxafJh99O+Ge7z/EvIJsPldFM9KtE
         hpXlY740jMULC4M38LiEAlBNR7nsN/HFlIjuHDWuUeNjgDHceLro6kH4ovLWQpkryAu1
         IvKDPPSxYthmK+SbhP1rVgYgbgmT3j97dhnbGlH9c8jAyseZKXyy36ADKtCS5ceqc3Zb
         thmQ==
X-Gm-Message-State: AJIora9CtnVhHOHMPEWGaAoeUbBCcveb1+6BBSPIvKZZBRT+Jsr5SGk0
        V3wc0kE8kGuFalMyMtttDKg=
X-Google-Smtp-Source: AGRyM1tkJnoELPZu2D35fsKBW/RVVFQHEATKOWvCaFZ9C9MpViczl3+svf0dmtNZ+x2KJOM1LC/RPg==
X-Received: by 2002:a17:906:938a:b0:726:942a:54e8 with SMTP id l10-20020a170906938a00b00726942a54e8mr29194260ejx.225.1656945356894;
        Mon, 04 Jul 2022 07:35:56 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k10-20020a170906970a00b006fea59ef3a5sm14286020ejx.32.2022.07.04.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:35:56 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        bhupesh.sharma@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: document resets
Date:   Mon,  4 Jul 2022 16:35:53 +0200
Message-Id: <20220704143554.1180927-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit "mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC" added
support for utilizing a hardware reset and parsing it from DT, however
the bindings were not updated along with it.

So, document the usage of "resets" property with the limit of only one
item.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 31a3ce208e1a..ca8814a80443 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -116,6 +116,9 @@ properties:
     description:
       Should specify pin control groups used for this controller.
 
+  resets:
+    maxItems: 1
+
   qcom,ddr-config:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DDR_CONFIG reg.
-- 
2.36.1

