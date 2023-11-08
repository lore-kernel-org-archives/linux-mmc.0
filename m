Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AAAC4167B
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Nov 2023 10:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbjKHKpm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Nov 2023 05:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbjKHKpF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2023 05:45:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9111BD5
        for <linux-mmc@vger.kernel.org>; Wed,  8 Nov 2023 02:44:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so57070785e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Nov 2023 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440265; x=1700045065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV5diolHzkDYNZO8WufyA3F1OzLH/Kn/j0r7E3RxmpI=;
        b=q/fFqIm1pNWVw9RWz0hbxrB8zEjHFyWAKjlSgQkEKbcncTumbpZOBQQjgsLCqeB9c2
         TYScirxbqaQUEk4FyO/Ks0dAaRAy5TzlbXdoDJ6IVa331XbRyxRhp1Ovm+r+FMq1G9Ij
         zf5nwCYKSu+EZmS+Rs2A56cUEvdpopnia26x/aEuSm8Pn0rFXM0GhRyR1JwR4DEOl5g1
         elzgD1tNrCv99tR7Y1/YCOAOSO/0h9PrS6g25YzPImrF2kvQQ9XDXuVWrdb0s5+PvSHf
         7kNC+eNgqcm8ctHaQ64i5dbvCyYRsi92XdRVJN5zfjoEPYQnjyOS0wTZ2Sn3n40Rd0AQ
         MvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440265; x=1700045065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV5diolHzkDYNZO8WufyA3F1OzLH/Kn/j0r7E3RxmpI=;
        b=gj7q0SKLdx2IksnaOP08Np2r+ytPVClH9xPueXsH7f94Vvoz7SASIzsIZDVrzMVS0E
         vQfGBSkRztNI0yYxzpUBwzt8kow4BleXNp3jyMgXt9mETZa2D49z3yo1+9bUJtgy6jUP
         rZfuuqBKhIE6aI/WueBVO4EOnzkeOB0tPJlP82XbNdD5XPhELFK+qr/K7fqHERHC87XI
         TPLBa3P8QSFQBDQjF6VDN13axirCfyIN0wZX5S2qhCwfK2nE0dFX7dLBHYOcG5fGrp+y
         qRH96nAkulcGAbXjFVIohNn+RP+2XwnO2mLav7Uygm9juRKbPeJWezsPRC2UVpH2SCdz
         jBig==
X-Gm-Message-State: AOJu0YweGT+Gky637HJHcbBLx9sAATg1J1Mxsk6mN9KZhCeKe4AHgPqF
        ucK82CMja3YPaCpmBuF7IfGe0w==
X-Google-Smtp-Source: AGHT+IE6LA57XGwizIDEYldEFclmufoWGtfeboQZQs5v6tX5jMVi5UnfB4CCXBaPubn6aW9Tzqj6ag==
X-Received: by 2002:a05:600c:1f8f:b0:406:81e9:ad0c with SMTP id je15-20020a05600c1f8f00b0040681e9ad0cmr1347385wmb.41.1699440265563;
        Wed, 08 Nov 2023 02:44:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/17] dt-bindings: samsung: exynos-pmu: add specific compatibles for existing SoC
Date:   Wed,  8 Nov 2023 11:43:34 +0100
Message-Id: <20231108104343.24192-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 .../devicetree/bindings/soc/samsung/exynos-pmu.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index e1d716df5dfa..6492e92586d9 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -48,6 +48,12 @@ properties:
               - samsung,exynos850-pmu
               - samsung-s5pv210-pmu
           - const: syscon
+      - items:
+          - enum:
+              - samsung,exynos7885-pmu
+              - samsung,exynosautov9-pmu
+          - const: samsung,exynos7-pmu
+          - const: syscon
       - items:
           - enum:
               - samsung,exynos3250-pmu
-- 
2.34.1

