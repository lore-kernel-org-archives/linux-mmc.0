Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECFC433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AEF606A5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhITPKi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:10:38 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39914
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241168AbhITPKh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 11:10:37 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA1BF3FE01
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150549;
        bh=405kNu3dtB0zJ30yHuYcgVnAp+AYJ1QTK0vyYlLZaqY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=B860XeaeCJ2mRKiHEU/o8TbGj0puEcPzB6IPDIVcv1aTGM7/YcHe0ua5E3eyT/AMq
         MFQbPPWM9ouxJJd0R1bkvI2oExYJmLiir9VT/EGqsZkJ+C2yXR/ZkUjFshB2xqFKux
         0Hed+HK1QYtY36fqh3OVgyFGJknZfeCzB0A1iCteX54ZZn0FQU1yUHTvdZSZASblFe
         m049y4b87QNSTB3eaFiSF1166bHKUNUmTDp8Sl8E5QEczSq5Po0QAAZ+SDIJix2+GJ
         20Nq8zJ8doCLm8cmCrXK6lp9G03v5DDMjHHknEVgPRJgbXimiDkV6TckBggmuiTTd8
         +h3qfiMNosZ5Q==
Received: by mail-wr1-f71.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso6361620wra.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 08:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=405kNu3dtB0zJ30yHuYcgVnAp+AYJ1QTK0vyYlLZaqY=;
        b=wP5RwSOWIgTjPNa+sxEaI0gPXqqu3ySVqwn25ezI+brt5QeiQhM+ip2p5rsh+Tv37S
         lHnzUjK8Rh74jGhRAla3c0TO2Ze1qH68pDwf/TFR3/Rp4aCVYz0eYi2nOlN6Efmw+hXC
         DuJcNhjAgbkSAs6AULbvz+QOqnVFgrfwahlX0DSn2yGip3GQXU15blZi393AmPQOFt/B
         IA1/hZBtKU9y57Zlv6eWa3C0c/vzu9O6wV2Dg5anFky5hdfVr/+MAabA4RS8vLeH67JB
         v6w2VbYY/JNP512YgoNn0MW+Y4b5dkSrfKStuNH5gRowxA8r98zPsFJvDf5NsfGshQXJ
         eErw==
X-Gm-Message-State: AOAM5306jrY3NoV1pZOWXgfILJ2Cok7NiioAM5AaaKnTdmnKox96hGkO
        8iUm/8pLgJymNpMf69XtKZx5zB1Rv15rcvlJdzAwQLEcJZimg3K+VOuTFokc42f8btfujpBceOb
        XTLWEaADi+0G1rznESpriGp+g6fnPh5oxU/eA1w==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr29637077wrq.213.1632150549338;
        Mon, 20 Sep 2021 08:09:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaf7A+XQqcH4LxJ/S2BYB7M3Xi66LL55Zn0Sh/VmFgsRmUSD1/dSX6l4Dsp8K0+aE14mlaWA==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr29637030wrq.213.1632150549106;
        Mon, 20 Sep 2021 08:09:09 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/6] riscv: dts: microchip: drop duplicated nodes
Date:   Mon, 20 Sep 2021 17:08:03 +0200
Message-Id: <20210920150807.164673-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index b254c60589a1..3b04ef17e8da 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -9,8 +9,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
@@ -35,9 +33,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x40000000>;
 		clocks = <&clkcfg 26>;
 	};
-
-	soc {
-	};
 };
 
 &serial0 {
-- 
2.30.2

