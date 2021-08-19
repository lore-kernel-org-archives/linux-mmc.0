Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE832C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9125861056
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbhHSPqD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:46:03 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52914
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240641AbhHSPqC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 11:46:02 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id B99EC40CCD
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387925;
        bh=8A01Ti4iWFCly0K7Cu7pOp84vfobY1MUZZvBkKJ35Ik=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pYLYrZUpqwJqpFdhVmug8yPxw9y6G8FR72yA5faNq1VnPSvYDtlrJSsCmnpR7yC+Z
         eII3Pk2/YDga/EaogRD9SrarfudPbiIPGlQyPvVTwyWNHeImp0CuByhfeAO+IhRN2N
         Umt9elLMFlRVxGEf+kxdhEgqoxhU3WBmUSyP3vBQA+7Pepn5H2svU9CvFL91iP2Fu2
         fNKuM4e2h+hJgIqRrtj5KNLAPbHZp58oBRCMVY7LVyXTX4heXZtdqnmuQI4zVId9Qa
         w3C1KPy0D8Vn1Aox2N1iURLcfezl9QQ9AS8/oAoLPGgt1U00P+dqo5zKeC475hyoSD
         CcJGYiLjgaNag==
Received: by mail-ej1-f69.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso2403079ejc.22
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8A01Ti4iWFCly0K7Cu7pOp84vfobY1MUZZvBkKJ35Ik=;
        b=W6EM3A1933rNmWxmtjc1yXhllzGfAyR9oDwDBwaYKRkqmf+HMZp7Mex0+TuUbfXL8f
         3TGy6kT520gvK40B4kc5P88VKHb/6tBOvF4HJOLG6tgz3Txtc95/uRD36BRzu7JRhFYJ
         9k3+ktAYh6qqr9Q7poquRQqWkP/kJJyWhUawiHjPjHPMK/NDJGF2sbRCOLHq28eLoKjL
         fhJ86VmPB2jwo1UdYSE4Q3ddO5A8dk/SCAlmcdGfNTyQA+gUrXNi64JRs7lEj5E31cGx
         Ato2w8+/n2Wz0JEc0v4clRQEhvR6jA9r1f88gsoFK+EP0E7KZ/um0Juf80jwUYfJ1NtV
         4YGQ==
X-Gm-Message-State: AOAM533SCAmGSpQ59aZ7IrJor03kSNiic7ezz3lPmNRnoAVaPIUdlk5X
        2LIjrNyfPfoKjFlLZZuUbdF72t/qpNqzT2cRwuawtODcP4NgEEmNEJpNaPyzDf7buSXDt13jeqN
        AMcXw7r5dv6rJDdA0Nw8DxffQedS/Tfjkw3YZ2A==
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr16394841ejo.14.1629387925483;
        Thu, 19 Aug 2021 08:45:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzop3xk9uOpzYONSS6eh+yJG5Jh6O2SpXAk8eo8bL4yAUYTFJUcq4vRwvvEVjARPWSfETkepw==
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr16394819ejo.14.1629387925347;
        Thu, 19 Aug 2021 08:45:25 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 6/6] riscv: microchip: mpfs: drop unused pinctrl-names
Date:   Thu, 19 Aug 2021 17:44:36 +0200
Message-Id: <20210819154436.117798-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pinctrl-names without pinctrl-0 does not have any sense:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c4ccd7e4d3eb..d9f7ee747d0d 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -267,7 +267,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			bus-width = <4>;
 			max-frequency = <200000000>;
-- 
2.30.2

