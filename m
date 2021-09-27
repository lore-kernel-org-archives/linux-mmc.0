Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D69C4321E
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC960FF2
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhI0Mwh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40438
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234474AbhI0Mwf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:35 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6881F3F32F
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747056;
        bh=HyJUjHjlK3mirIZ1mWbxEOM/yJgRijm4GthGtGsI3+o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=sTaluSXJlk/YFnoSrKgHjFenPfTHMyatRl1VIaMgceJas6GzTFkJAty97NuE03G7b
         q6wkrHkUATYOs/awOSEWY/Q5rXuCY7exEplpcYBhtesvKgiUES25XJYtgiN5385f7F
         +8a10ACBxqR4vIhPJW/LCZHF1CMqPNo9a4Nfv4coPBGCTSkPUuan0w5PsltEP9uOBN
         /FQYkwzl7wEciAHfRd16PiPSw06CwLhKopZj7RbdnreF7MEdXqY3NwReEU/SiXGvbb
         4RLRCaZa4Lb4eAgVIE82jgkYLIBMb/9Fj0+FRKjnWID5zoc4fA2w/h2KWlwa3AciUu
         gj7loYYpE3ZGw==
Received: by mail-lf1-f71.google.com with SMTP id x29-20020ac259dd000000b003f950c726e1so15708449lfn.14
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyJUjHjlK3mirIZ1mWbxEOM/yJgRijm4GthGtGsI3+o=;
        b=Ky1XoVP0EJifVc+Cwr8QASXc0roPyoigZ+m8mkXyn1Xp+tFM6RUWRoRJWk56M/uy5Q
         yZrC1Ry0M13LQ0leEabxoIf0KpUOP7UiUQLmasHlOudrCW+vgfAqT/VAenAQV18WDlwK
         QHrkQHtG72GdfgDAzRLg0/yJ8dQLdGtKAAo1Mymqv8R0oQ6wi0GBGkxyYWOduUSSh2U+
         SG1gppkLpWabrzm1E10GChRpBGSrLxTxfhPTppKYzmkQblmRSCwE/0ItAuFPWPtK8s8G
         pBh7kAfUXYTu+XJ3ok/kJlM1M9+lUJH2POtrxwMLVvQk/8IwsUOYUEBsNoD7M7xIjIW6
         zDpg==
X-Gm-Message-State: AOAM533fCrvumlPymYgoh5DXIjV9qN2klpeQTbBTshQ29XuQSBMl77Ij
        d8c21Iyrh3t4gYdMk5DikAfZmZ9dKUeVIzsDvO05P0J31cYdItEYqVlkUWhXPt2F3rHL1USSAj4
        m/J1Amx505LdvfBrwbzzRQ7VGic0PVrOPx1QmCQ==
X-Received: by 2002:a05:6512:150b:: with SMTP id bq11mr24378582lfb.495.1632747055581;
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxub5gxPd0btgj0850I+iTNBnTY40Um3nPH4TVM4BxueRLq1HcvaTKOdlAvhZ1R1kGJjV++gQ==
X-Received: by 2002:a05:6512:150b:: with SMTP id bq11mr24378555lfb.495.1632747055433;
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
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
Subject: [PATCH v4 6/6] riscv: dts: microchip: use vendor compatible for Cadence SD4HC
Date:   Mon, 27 Sep 2021 14:50:44 +0200
Message-Id: <20210927125044.20046-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Licensed IP blocks should have their own vendor compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v3:
1. Add tags.

Changes since v1:
1. New patch.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 63984e53c0b3..c9f6d205d2ba 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -264,7 +264,7 @@ serial3: serial@20104000 {
 
 		/* Common node entry for emmc/sd */
 		mmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
+			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
-- 
2.30.2

