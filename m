Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C8C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCLSdQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCLSdA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:33:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5044344E
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:29:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso3380415wms.3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645692;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=EZvmqTi6k6RkyqxQ0DvNFlpHfE2jSyE5lJZJxdT6IYfqcG0TzN0ENp3jVTcHv/sEmK
         46CNTtflHXgKEBWsnSxFVaSUtw7YXUZlplE7tUci6OYUsVVAluW57GSizg6lhtXTLsKL
         UvkIPP3vfXyLX/1nqcUtHpe2j9lmo9Lx4/UJZlJrpbcZhCGbeVf573hCypff+CqR5onD
         071mdJL+M65vsScSJAWTpHsz84BZhNKufKrhFHtR6YSDDdNvn7EzG39z1409chRPX+IO
         mXmhxkaZlg+ydhTl3QqvtXuhcpHgMbPvtpHROzJANJrwVgQCKWL5V6dzLaYAhggYVGKv
         Y3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645692;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=lMtWn7KcTgN6TAni2bmzPxI2zsqZCm/eDQgeYaQAfi12b/n7R0ow3IdutbZL/O+X2K
         2h/XqSndPNryrFrxvPhsrrL3QGoNnW8LGRYGiWeBS5HF8NEI3QaV3nP5iAIBzx1fqRPF
         nGeHh57cpLT+smoqLCBtn7OwRbhZY3S3W8KMa92tcORqI7q1tl6cHvTjSvB3yZB4YvrT
         l+rL17sPYbNUPgC5JpZk5+ClOcxhoikmwg0I7LJO8qDr6xxWSJTZuNcJ5Vgih0tuJnNz
         1UGrc7fQiALZ+k3qeHr2TJJS22zwcy+kDnpwk3jgoI6f+0LZVMtdBmRyjw5AwMO62bem
         CD3Q==
X-Gm-Message-State: AO0yUKUz7ZtXMw6pZdthkHzCRQ1ZkXbvm4xT2AGHpXFkrSCCuVXdfOrJ
        yzIrwJpTPmf5hKNrptJTxb/DN2ikowObBCFR
X-Google-Smtp-Source: AK7set+/gtaDBsqOTn1k2aHZu3m0kmBjKR8t9SVnq+CSA6jiG1onQi3i/Ar4wYTyFyn/cZouB2JsrQ==
X-Received: by 2002:ac2:4342:0:b0:4db:43b6:77b9 with SMTP id o2-20020ac24342000000b004db43b677b9mr8604258lfl.11.1678644700318;
        Sun, 12 Mar 2023 11:11:40 -0700 (PDT)
Received: from 0003-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q21-20020ac25295000000b004e817c666eesm709078lfm.193.2023.03.12.11.11.39
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:11:39 -0700 (PDT)
Message-Id: <1678644516.665314-3-sleirsgoevy@gmail.com>
In-Reply-To: <1678644516.665314-0-sleirsgoevy@gmail.com>
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


