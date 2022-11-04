Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B1C43219
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Nov 2022 17:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKDRWP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKDRWK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2022 13:22:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E46419B2;
        Fri,  4 Nov 2022 10:22:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16DDD66029A1;
        Fri,  4 Nov 2022 17:22:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582523;
        bh=bJJKGQIUdKlBSLPJiUpn9VKFemzRIMtNb7tKeJ4IU10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuL8zpOjdB4/NlSWNrQpyJ2nE/geAifVIVY8Uwub101TNz4CPKGaC5/cDllTv3z1y
         HOQa8iVDWwRkzaZ2zFpQGlVshkMDaXmTVZ26Rz1jrjAVF+9kkjHSIE/jZYKVdslySX
         Yq8l4asF5ICszatrEg16pUlkgGNYHWf/byAa1TbQ2UEZffJOnEh0B6lcfM2eRxB/yu
         WHsL6qkX44hS6d5zB2gkah4B/l9qyTnt05uGY1Flx5+H+tT4n08GxsZNEJ0M22Evx8
         xgsX4X0VK8ybGdwxFdy5rsGxMWPePdqLnsxvN7LqBCYjA0+1SVVr8nEMbwxH+lYXk2
         nM7KxvSvrDZpQ==
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
Subject: [PATCH 5/9] dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976
Date:   Fri,  4 Nov 2022 18:21:18 +0100
Message-Id: <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the compatible for the SDHCI controller(s) found on MSM8976.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index a96f143479c7..fc8a6b345d97 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,msm8226-sdhci
               - qcom,msm8953-sdhci
               - qcom,msm8974-sdhci
+              - qcom,msm8976-sdhci
               - qcom,msm8916-sdhci
               - qcom,msm8992-sdhci
               - qcom,msm8994-sdhci
-- 
2.37.2

