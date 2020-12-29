Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE10C4332D
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 21:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A41E20727
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgL2VS6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Dec 2020 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgL2VS4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Dec 2020 16:18:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DEC06179C;
        Tue, 29 Dec 2020 13:17:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk8so13767494edb.1;
        Tue, 29 Dec 2020 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ly6Os6k6N2Ri2J9ieGw5EEhVNhuWAlWHSrjzUJz6NSc=;
        b=Qt21tKtjFsWYdLlcRf8YmQXkV8zPiv4N8uyDheJRAHYoidKYbk9urIq6DoTjn/NUgk
         7/W8+auhkQYLhWmyjDxR9X3yowckpAtR7dRI5kDfRgTMdYWOZGJLKh3PhYdolgs6ha06
         QiLDE+mo42+lN9biQ23Z1oB3duuRK11Kc1k78caCxkAiEAzfAmPrpVWVXmrU5GiOWTTH
         jRy3jVNfoGkhmlBHZRTeaJVDgkFvEAdK9tff1SBJFTCl+5wLDsBScyEIsvgeT/w3EZbC
         UjUbCE0AhXDg0IjUQQSe54UOLI9p93/eObBebGwlG58U5ar97+hPsHEPBvuvVAezNqAW
         kyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ly6Os6k6N2Ri2J9ieGw5EEhVNhuWAlWHSrjzUJz6NSc=;
        b=O8s0FVrERwdDzf3COwNrv5Dp8g1EcwUzaQtIqYIWsHHuLaWrxSjVNrOP087XWyHacb
         5l7+fCf8Be97LZUxIHKPILM2dgNM9Oj5VNPdRZeRlI7x9AaRdAoEodkul4HH6Kns7yhI
         zuisS57GlfVfLzH04alsUYu6OloB0JE26IJF0bp5BfiPO2fzaOQjNW+6fEs3i403AKPO
         Y562qmDYDeWFiSYHrPUKOLZHLxGlFdI9ROfvfmAINEIR0Qprdo5T3BaTLmiMOJ+LYG1A
         mbnNso09ScJ2WhJjGB2IugOGgOLuQ90sbyLIVpCGgwt9Fk0x7Ecsddc2ExsMnIxAQtwj
         u1CA==
X-Gm-Message-State: AOAM533pdh64hEiQqh5Kcm/di3GXKLgwOgM8H27WGHCXzy00qcUc5beU
        stc8mNto8Y+aP87V5a0vnR0=
X-Google-Smtp-Source: ABdhPJxaK3LnwbcIWRiy10L7zjfGiK6X5x1CZDTEeeYUuX7EGgXteusFQDoAfx0d+wJHLtaWRKcnCw==
X-Received: by 2002:a05:6402:513:: with SMTP id m19mr47943583edv.244.1609276663548;
        Tue, 29 Dec 2020 13:17:43 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:42 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v3 08/13] arm: dts: owl-s500: Add MMC support
Date:   Tue, 29 Dec 2020 23:17:23 +0200
Message-Id: <94e75de6c982c842feffcf63c285b55b8c5fea02.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MMC controller nodes for Actions Semi S500 SoC, in order to
facilitate access to SD/EMMC/SDIO cards.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by tags from Ulf and Mani

 arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index b16172615db0..7af7c9e1119d 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
 			clocks = <&cmu CLK_DMAC>;
 			power-domains = <&sps S500_PD_DMA>;
 		};
+
+		mmc0: mmc@b0230000 {
+			compatible = "actions,s500-mmc", "actions,owl-mmc";
+			reg = <0xb0230000 0x38>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@b0234000 {
+			compatible = "actions,s500-mmc", "actions,owl-mmc";
+			reg = <0xb0234000 0x38>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@b0238000 {
+			compatible = "actions,s500-mmc", "actions,owl-mmc";
+			reg = <0xb0238000 0x38>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.30.0

