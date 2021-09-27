Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220DC43219
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FA16108E
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhI0Mwg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40422
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234469AbhI0Mwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:34 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E1A640844
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747056;
        bh=gL2n73HFUZMgICxi9XxH4YAlloJV26Mt1lAxrRgunho=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lNx+trnLPezcfVob9zFV9tc2LMYLcLEhotK8CYHYYBenPKGfwZNiDD3dsh9VLU6Un
         6RDZo9JrnfuuQ6ARvY7Rfkw3nQ1HfZGYoCHeJDCJbZA59WCit3Om4hrQzdpjkytb1Z
         8i7j7EhMv144Cez575suNq6qQFFKBa0lebnmpBWCB/848ELlhTzv6bGo8FzUrvG0kY
         Nn9M4gLR1JC7Pn0sWYynahOBs98nWTif7dErssYCpwIo5hRhiKeWUUC2QHw8epvKTN
         O55Hz527rOlSz3t/+MNEzZeNXHUAABjlKGKTAGM1hdF5oKwyJvNBlJTQ8fmKVleXXW
         jmdSf+4+RIyag==
Received: by mail-lf1-f71.google.com with SMTP id q4-20020ac25284000000b003fcebb305a6so2245256lfm.15
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL2n73HFUZMgICxi9XxH4YAlloJV26Mt1lAxrRgunho=;
        b=IxA3JoA9GBPYTiqmnwJUdzqkp9jEKFmiiPzG85zDP0WgHl9azQ5qOKS7s4OjFYfvrS
         p5foEtbNnsa7UoNV0rT1LhJHDs1pbnsXtDvaD8koVY2ibCQAuxwZZA4NdB/wmi8ELQP3
         kSGJPTTYAKcCN1z/h3eQmhGr5AwBMy9YwN9FmXdtw3F/fKKpXZ3x1VD+Nk1INmxrFzyJ
         NwneZxNtZKr9+BH50/BJmS2M3vrqco/IywL3wEGvo798p2fCjRsxpc48J8Vxvm9n3C/w
         tJkiJ0o4Thmv01g9k65+dNnI3eeMDjcyMIJTynYAYTrnO6PQi5DCjZkjCuB1STDcnncv
         401A==
X-Gm-Message-State: AOAM5338okb3JV+EMVq9huP2xO1CC5haBQ4H+XetEonaTnjQGLOR9kU5
        lUj0dl6YYCWBbmiKDCTx1r7+0Bu4DyT3/VmtC82pkp7lO/M9iKkRhKlyOmz+in//rqQhLsigJpR
        jgjfwSMp4HfUXntSowSkZRArw9rnS89AZfxSgJQ==
X-Received: by 2002:ac2:4d22:: with SMTP id h2mr24000842lfk.429.1632747054379;
        Mon, 27 Sep 2021 05:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyk4pwmdGw/4Ofbnvsd28i4hCYWPZtzP5PsR1gIz62OdaiPMEFoxgoIwLu67WJig5byBmk5g==
X-Received: by 2002:ac2:4d22:: with SMTP id h2mr24000825lfk.429.1632747054225;
        Mon, 27 Sep 2021 05:50:54 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:53 -0700 (PDT)
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
Subject: [PATCH v4 5/6] riscv: dts: microchip: drop unused pinctrl-names
Date:   Mon, 27 Sep 2021 14:50:43 +0200
Message-Id: <20210927125044.20046-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
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
index b15e93d1702b..63984e53c0b3 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -268,7 +268,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			max-frequency = <200000000>;
 			status = "disabled";
-- 
2.30.2

