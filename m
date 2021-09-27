Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114C6C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF25E60FF2
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhI0Mwb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46064
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234434AbhI0Mw3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:29 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95BA540198
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747050;
        bh=fg5AL23aTrFGgdddnLfZwpvVHS8H57YnvdUfy7tZi0s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LU8opipw0oFRXrF7ujUYUfXWp/tG3hxHE/krscOVPQwhgbCAHWo7r3ZSk8HUUWybN
         Jwc4CkjMnn2nJVLme9HUIJReuLurmYdfKHGM5IxznE6a/6LYtvJvUoveLpwr5UF8ZZ
         0I3CHIOqhtqE2WtRz5n1TZezQM21bxvnM/uWnRupmZXGWOnn+oJIztRkdYSt+WzOj7
         PxpdgpZmhkbI2km3S00lj8+6qtWs2bj9LH4c/fgaTwVNPLx0Q76f/W/b5j6hp9r5Ca
         5lLhTXAyzPjXnjssUryiAbUw7oh15fAMJgyxou74u55Pn3T/K3HuLi9TZtYd1wqObH
         eqFjiEbqiCsAQ==
Received: by mail-lf1-f72.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so15735816lfv.18
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fg5AL23aTrFGgdddnLfZwpvVHS8H57YnvdUfy7tZi0s=;
        b=VoHPdOIML6RH9cSHYO9eYWLcFKFUzzyDtfKXEiIXkJIgszey1FPV5aJDijr7amH7ah
         milcGLhrQKwxRROrfMnYKnqx7tJFCCKNHIcC3Ofk0PS0aChzcQHCNFOC6dh2iYmRW76L
         6R2g03WhosNV1LHIeZgDjzbML8x3l+WNqml7YWXqqA0vEuR9vlhfe7qHZBuxztRZiC45
         WGR1Qkxu73t8UujIRzw5t7BB+YiGG9QD7xz0zeQakbO28Y9cf6RrNcUVYH9YtSoqy9Hf
         U1kfC5sKlphi/Vy4yDEM5pXPFeOYjx/BYteJnnEnma8isXQzfVg8FI6skFENVEm27CeK
         /V0Q==
X-Gm-Message-State: AOAM531ARAfNMmOE1oo2zj/SoO8ILVBTEw3FAMHMXpdeJhsWHh0fkgAR
        es12vcliogVniWQ9pVLKqInH1Q0Un0ovBQAKvFfrL2ddcrAl3rN5g2MBDRdTbKLz0NAQW5aZ3KI
        P7Gn8qwZQ/xsytO71T6N0vHsWwpolnGvrqoeMtA==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr29935197ljo.178.1632747050065;
        Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/5dTX/1Af1ajiS9j9gLC6Bz4Td8g8uT1FEsyWbZSka03MXx5jiPjSYFk+SSYjibvpBFNOdQ==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr29935186ljo.178.1632747049901;
        Mon, 27 Sep 2021 05:50:49 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 2/6] riscv: dts: microchip: drop duplicated nodes
Date:   Mon, 27 Sep 2021 14:50:40 +0200
Message-Id: <20210927125044.20046-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

