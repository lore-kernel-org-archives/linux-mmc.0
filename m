Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604DC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Nov 2022 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiKDRWM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKDRWG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2022 13:22:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A74199D;
        Fri,  4 Nov 2022 10:22:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5DA2660299E;
        Fri,  4 Nov 2022 17:22:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582521;
        bh=ah3iLCOsM4WqktW76W9/Jw9aCMvs/EiM65WkIIXTGE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD3By9lHSHlN885jyaYWtT2AOSe/3EXd6A249e4p5EBy2uxwP78s6g/rYBI7EWd1E
         AanCDy9g4jyKBjfGeI5pbaT8Nu3Ab66uN9G4+c+cCr3UoFqWpK+yXgm9wujEQjwYRf
         4aLxPcv3GkEkk8GJRL1y9vae9JRglgH1IoAQ9J+U4yBV2kQr9cpQPcbTSuW2MSxY4N
         nuO0dAdAXOIbtZ1xKN2u2MEdxMi72aFvkBz0/bu2ZepEhRRqvIpRDisNUIuren4U1V
         Y5o5XwCZlwmS9nFgn7yzdyg04I3lWjybxx46EUFglmVtVKfptzF+5/CCQtacBFyUNB
         u6wBTlXn87HHQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/9] dt-bindings: soc: qcom: qcom,smd-rpm: Use qcom,smd-channels on MSM8976
Date:   Fri,  4 Nov 2022 18:21:17 +0100
Message-Id: <20221104172122.252761-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Like MSM8916 and some others, MSM8976 uses qcom,smd-channels and not
qcom,glink-channels.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index fef7f29d44ba..11c0f4dd797c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -81,6 +81,7 @@ if:
           - qcom,rpm-apq8084
           - qcom,rpm-msm8916
           - qcom,rpm-msm8974
+          - qcom,rpm-msm8976
           - qcom,rpm-msm8953
 then:
   properties:
-- 
2.37.2

