Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE43BC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjCLSOe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjCLSOP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:14:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989B532A3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:06:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n2so12928386lfb.12
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644311;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=FJP17E64FDjzwdG9Ah5KMF4FEj7///U44CZPLJH9yPpLMLeysodo/XMljvOm2E4y0J
         VJwmDZCh0WhVzKE8wwU+l6F933rmZHgzmPBHRR7DZcmiGEGuub63OcvUpGGm8FHM7cvT
         hr6BFPgI4cvEjRBm6UVlE/JMmPvaocgxjjo5VdunynahTJ3H4HCqCAIV+bpneaJf5J0p
         La01zc4PClvh5btkDpZ9RCx62PGBvecJBDZ47KTtH8C9tzVQwnDK4QQnHvd9Yne0gz0b
         auSHzbwRqdiiFqcdcalfQOb4QuAeRGYxNy3vJvWIezjCGqFmVQ29gp9IXt3khkDsVw8C
         epOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644311;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=WY87xocKlO/ZPz0MFl+QgdKpjfU8YqSk9Wtr9owj+1buHIYmoqRSWq+wk+TN8IOcpo
         bHaMVt1B/6jzjoll5q12ZW6vGRccXo7ahQKY6UNsVI74i8mPrzjE6w1i7c+ZaojQrMrc
         I8prbClomJwzdmqeNA7SLb/myqgY3WtDjIzRep8aLCGifrQ+Dii2ZOBtxahq+QZhk7NS
         fkMBsBrfopICX0VWiime77PoZ+QeraTu9Wnjx0t2Cdv7wgSp89neqBP133YdUYec6vN5
         /lqwmPaon8cF4Whmw437I2fMB7mOBNodw+Oxmt5kH4vI5ztvj7uaYlW9MwboZTro6vJU
         AiSg==
X-Gm-Message-State: AO0yUKVg8oE8/ofWSSlyOQ83YuRsrF8skHaUH+9mF9a3jkBRan/wEQ0n
        DxHqT2R3HGAD53Vtx34S3tia/WG4Tn5f6fmM
X-Google-Smtp-Source: AK7set8+FGZ3HYrdpDcyryufB70LqLwtD7cbaVuK/li/DcZayvDB1xMJPHhbMhkIvzP+x1LehhHU7g==
X-Received: by 2002:ac2:533c:0:b0:4dd:a7fb:1e7c with SMTP id f28-20020ac2533c000000b004dda7fb1e7cmr10135115lfh.3.1678644311424;
        Sun, 12 Mar 2023 11:05:11 -0700 (PDT)
Received: from 0003-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id v23-20020a197417000000b004dc807b904bsm712172lfe.120.2023.03.12.11.05.10
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:05:11 -0700 (PDT)
Message-ID: <640e1457.190a0220.75a58.1af0@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 3/3] arm64: dts: exynos: fix wrong mmc compatible in
 exynos7885.dtsi
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This DW-MMC variant is not actually compatible with
"samsung,exynos7-dw-mshc-smu", and requires an additional quirk to handle
very short data transfers, typically used by SDIO cards. Update the
compatible string to "samsung,exynos7885-dw-mshc-smu" to reflect this fact.
---
 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..b0addb0b3 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos7885-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


