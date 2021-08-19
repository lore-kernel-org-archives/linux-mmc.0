Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A66C43214
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B361029
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHSPp7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:45:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52780
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240560AbhHSPp4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 11:45:56 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id B8FBB411C6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387919;
        bh=R7D35cbra117D9PxgbQHF85yjpBLQZ8KDhGISFH2tcs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vZiSX1PyuE/9tBTRwkHxG21YU4abO1BKVXEsDfVsnLY2VwinKu0LCXDZ16yhGnIsZ
         7tGH/WaBGmG2UkH/vGKFiUkxEGtYgkT/0hA1gPVUbcEDdA3poqiR7EUhFkumEDft0N
         k4CMkweHn8dY0tjWa5HNznyT2XErlWN276JonjrZaoesGTsaDjeDlwFhfJae6lT6kt
         Pi3bxIB9du+z6ksrW5rjXm0UuOzckGWPTmfJa43n2rxKnyplcQbGcL/3vv9K3rmc+E
         74NYDhh72QVRalSAY9RRvR4/BOeijdMYiiLKy5BZA87v9vh1OxRpD/X1f/OKQR35QG
         YWg0soMYdk9fQ==
Received: by mail-ej1-f71.google.com with SMTP id gv53-20020a1709072bf500b005c0428ef7e7so2389710ejc.21
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 08:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7D35cbra117D9PxgbQHF85yjpBLQZ8KDhGISFH2tcs=;
        b=YHniFZoSqKmGWSj7Yd0IdGy4akSqpiKyBuGcUfZw8i+HxoIpyMi0XNKdQ96OzvzReJ
         QnVZVrLququcDvPdwj8+RdJrceNqSKVUARN0qT5RHbY/s24KXvzQyPBPy/4al112aI4E
         WymEePNmZ31vYkqDguLFR6k/JrL++NwywfUk4dgmxEjO56D+wIMJb4zGVTZyj01x1EVM
         MemhnQy5kCunb+dtfOVQsHrhAErhgZe6PIu9oXVyMyBrUdXTbtMzgzC+1gSKXm8Ln0Ox
         rirmbJu0o/hLFx8waPjRlwmHWOqJCUunRrJjlNdwizpwimPotDi45ReNrZ3v0RMH+Qty
         zS7Q==
X-Gm-Message-State: AOAM531heYnVWzE+gROfL9WBHyHH9dQAyGpvlVA+8bNlwq+bw2hREjuE
        jn+cW/5TTrItVpCx2tzqUsvOOO9SV6pdcs6uoFVgZUf/WY0jgMuHNKI5Q8BJcipRfhOW0E1oOwu
        VDtT3ILbtgexXPrFojjrqh1+i4NZ/lHquINo7Rg==
X-Received: by 2002:a50:ed05:: with SMTP id j5mr17338664eds.256.1629387919477;
        Thu, 19 Aug 2021 08:45:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwExpdLPWOGCIOlhdKLAezKk54YUmCNyk9hkQhVf/OBX+C4Dw+NBvBYgBjE6TzVYrSx7HyOxA==
X-Received: by 2002:a50:ed05:: with SMTP id j5mr17338650eds.256.1629387919373;
        Thu, 19 Aug 2021 08:45:19 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:18 -0700 (PDT)
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
Subject: [PATCH 3/6] riscv: microchip: mpfs: drop duplicated nodes
Date:   Thu, 19 Aug 2021 17:44:33 +0200
Message-Id: <20210819154436.117798-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
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
index ec79944065c9..237830583514 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -9,8 +9,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
@@ -27,9 +25,6 @@ memory@80000000 {
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

