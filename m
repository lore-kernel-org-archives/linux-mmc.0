Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC98C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C92610CE
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 15:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbhITPLb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:11:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40076
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241177AbhITPLb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 11:11:31 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB3B73FE01
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150603;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jDqtzdfjvI8+2jZzyB54FKMBknPb+GMEs19nyvOP4V4lfloVG9chA9Bh8VbB0KAEb
         UjbYUEsBWnu3NhuprcREA8hkweFl2hhlH2svygQO3AwCHHUMGQLrBtPDAyWeF1F855
         jEKfzyZUTQ/dGKwDK6jPZvZHdePs3uBjBjrpHp7uRz7oS3mjJ99dSohHgAgYfO5RDO
         dZNqFCOBP8VQAMLrCAfWyiS4oPZV7JD8UNtuDp1iLceAByGuNcUksZ7ushXwP0VVSe
         +oOYR1WKzD/G/1AoMYQV7WDS88D8d8MnRrU2CjUb3ON8EMcAfYudqG5LYsUS87JtEe
         /GNj0jUsXPkbA==
Received: by mail-wr1-f70.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so6356218wrt.9
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2021 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        b=xBkrl2f+4ax+HfgZHQqVdATodoYCjNOSY0/3Oq6oWM0Um5YoYEu7wm+BwM+nlDABpP
         niZDTHYHB/2FG12sC/c362GI6nYBNr/9c+vfbVnvpfloIvFFjzvGD/XPopW8Q0cOO6j7
         mSxAlFtOiGS+eMncRApAk59gT7ivx07eousUaK8gMkJUu+Ngg3wC3ys3ePjRAsewm3qy
         /OVWytJL3wbWl+abtWrwzJD8NGQ78byITaKzURQcn6zVLdukQyvBYgpT807XOqaf1VVL
         X8WgbhHdFFPbaszb+VdaLuljVioRTewvQeqHrNpA9mKlarcWAVOGtEajA7xOjd3ZwoB2
         oXgg==
X-Gm-Message-State: AOAM531iM7RyA9G9sv569qjcPYsJSo8RzktDAyXbI+ml4oIsCBWb8mji
        jGmtmf2JWRFBdPHvtFWe+uZJmY3b6E0m258NTcwMpfTsxOFsr+P46aF3k2r62EG93BCOJVajphM
        HRxJDNrSUBfXtSf6NVyRyQyZrl5q/+6EQDbklXA==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30067252wrm.49.1632150603566;
        Mon, 20 Sep 2021 08:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBBPH6zennF6+WXOjRYxYRZdYGj6tYy+clID7FjBpMnrSmFriKiZD1slG3/cFHjNMZVecHAA==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30067220wrm.49.1632150603368;
        Mon, 20 Sep 2021 08:10:03 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:54 -0700 (PDT)
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
Subject: [PATCH v3 6/6] riscv: dts: microchip: use vendor compatible for Cadence SD4HC
Date:   Mon, 20 Sep 2021 17:08:07 +0200
Message-Id: <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Licensed IP blocks should have their own vendor compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 55d86b078c53..7948c4249de5 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -263,7 +263,7 @@ serial3: serial@20104000 {
 		};
 
 		mmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
+			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-- 
2.30.2

