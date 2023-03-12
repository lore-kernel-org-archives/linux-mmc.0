Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43EFC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCLRDM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCLRDG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:03:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76137E391
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:03:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r27so12828361lfe.10
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640582;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNccjh9ehO5GzEa2MK08HfZDjH6EdpZB9/Uqslpa9j8=;
        b=hE33n7JbOe66TjKw4piavM6ZukrqbaSiVioWTSEF7W5pZG1iJDpCv6aXJR8bHVAH88
         2xlpC2IchkiYLKZF4puFrdrCUix45TNhJSvizjoEBIYvmeSh6LVpXY6TLm47ZKsn2mbX
         G/kmpd0Q+vyWjhInX4CVcGmqz9HSXgoBT3TraGjmcRetR8yx5OwfiSLZzIvcrsAIFmjz
         L6sFad9PSpofYvhkbW9qb7+THIWTJGG9ulLCw4LxxCtULLKNspjlMdU9hWC581lCjfGn
         N1AwB6oc4TNor44PtUFJSvll6xdkQqkj/pCEpihgcHcNyWadshvgyYTQ/NsYRzXSqqI0
         eAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640582;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNccjh9ehO5GzEa2MK08HfZDjH6EdpZB9/Uqslpa9j8=;
        b=LUHE97mbWr/kKhI62o2ToGIES3FiXgNMEAUduEcDoqs4sIzMXX7seAx8ZoivRwyduX
         4m42nNm05AY/dtEURrrjqy2oi5aoSRSaoc4JNfie/B+d3zkbv6HE3uUyWrFxS7s0OmJW
         xd/euMBVO0p5B/h0t66fsEWz7HdBWH9IyKBOQwvhU2fShpgnbMuvmPwCsmjFvFNAhPnU
         w2xmYbMAONkX9tvc8jCTp4V+BF3xrW+Fj6PhnKEv962y4kwAAwC5kBZ2rurUja/K3H5t
         tTp/6SEH3WK18szoMWy27NX8YwfWI4O+57sx0jW1sz+4eJniX0A4vXVSu7ZrkB8e/jtx
         omng==
X-Gm-Message-State: AO0yUKXOOgB2sNte+sC8mxTKC+xdH76/2jWbhtXEzZnlVq2AMKfVi/AA
        RuxMUa/7XEc0KxFLfutOpAtoJgK5MvOw57AA
X-Google-Smtp-Source: AK7set84iUlCSmIfGI5y109cxnH2nyVnIIBDIRwoFQ/v6mzJVZqMallu5Lvk+1TN5XgS6XSb7Zb1yw==
X-Received: by 2002:ac2:5195:0:b0:4db:2cdf:4c12 with SMTP id u21-20020ac25195000000b004db2cdf4c12mr7995708lfi.43.1678640582603;
        Sun, 12 Mar 2023 10:03:02 -0700 (PDT)
Received: from 0002-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25111000000b004b5480edf67sm699454lfb.36.2023.03.12.10.03.02
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:03:02 -0700 (PDT)
Message-Id: <1678640497.9030156-2-sleirsgoevy@gmail.com>
In-Reply-To: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:29 +0300
Subject: [PATCH v4 2/3] arm64: dts: exynos: fix wrong mmc compatible in
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
very short data transfers. Update the compatible string to
"samsung,exynos78xx-dw-mshc-smu" to reflect this fact.
---
 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..4b94ac9da 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos78xx-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


