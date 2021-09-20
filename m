Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE06C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1991760F93
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhITPLU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:11:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40050
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241234AbhITPLU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 11:11:20 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CC6723FE02
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150592;
        bh=zUv3tXHbbUqWbaVvQkKggzK/iHQTdWabfc1NCBtXKt8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WUx+n0rTL1ND8eemSxyqF+F6WAqsNjGe6ANMG/wlSCu0rnm4EtFrpF4R58yJG0uMy
         ekB9bU4AIQwysB8Pg0vcjYVlJeqQSQb4M1Sn4BZhzQFZLty1ippUI+N1KUczyEngaV
         q4+Y7pwW+MamAh0PRfOyNjKNbxVIBFEBJzNjhJ8SS57jhjchB8SoagfkszTgecNpFe
         /CTH3akQBCOptJfP4enmXCRSF8hGUJiNUw6jyYoYUNNX2L6LgO4ehap8b/bNNFagnb
         H71nbO8igm4EQ3Qa2xI8Sw+F13roCsROX5YiY79N9sQiRPa/fUGjZt6Q2EIrnJY0K4
         xHmLrS3+xPe1w==
Received: by mail-wr1-f71.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso1316866wrg.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUv3tXHbbUqWbaVvQkKggzK/iHQTdWabfc1NCBtXKt8=;
        b=hcvvHxD77mrj2k6IIWL3Zm+rAvE9CRT0PRt0ICh1TfaO25vyA6RzKw0eZvXWP3dJ2l
         LfR8o6XiaNcLW044nkU8Ckzizf4zQDujnWZwtY5wAcxQTezOTwNoh/Bo8MTf7d0UKm4g
         S4jw7zWe8msLYaJvtaTGXoc+UnFyB5B41C1FgupwgTG66/J0g34aLpfAxoncpn8PECc/
         OeIv2glnbIIyarscSV//au2ZxBb6U+1yhvECi0liyxCPD8s+kO3BF/F+nHMfKvxNaicH
         F0TI/iRDInhlZbrimRzdJwTsjMdPQ6AIWmXUid+oe02FmZGlxBPMThkuU/+bDJp9yIGW
         vafg==
X-Gm-Message-State: AOAM532I281kpAzBfogA3qZKfIJU9xCrFxtJKr19CW9Choin8XHsDgF/
        vXs3VUlNkHA1YE3Nu+r3hw07Mt9iIUx4wSme3wJFL3hvLfz2S/EhI/v1MwCWzzvn4lCG7bXwtsg
        iE43vVJlEEEudhv4F8NyQ/Rex1ydxS9sFjiQMmQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23908196wmh.125.1632150592342;
        Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4go/KWD2wwvaGed5Gp8/j8w76ab4Sbq/2+KvZVoBShQAqdwysUAi7NfERcQWEBk3pzLlFbw==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23908169wmh.125.1632150592140;
        Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:41 -0700 (PDT)
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
Subject: [PATCH v3 5/6] riscv: dts: microchip: drop unused pinctrl-names
Date:   Mon, 20 Sep 2021 17:08:06 +0200
Message-Id: <20210920150807.164673-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pinctrl-names without pinctrl-0 does not have any sense:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v2:
1. Drop some patch garbage from rebase, pointed by Geert.

Changes since v1:
1. Add review.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 83bc14860960..55d86b078c53 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -267,7 +267,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			max-frequency = <200000000>;
 			status = "disabled";
-- 
2.30.2

