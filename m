Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A156C64E7D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8722248
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 23:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG0WjrUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKSX43 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgKSX43 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 18:56:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1688C0613CF;
        Thu, 19 Nov 2020 15:56:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cq7so7699702edb.4;
        Thu, 19 Nov 2020 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2nMrkstdfaLwFQPrDRfpgWYF3hxA8+qBOcuVrcUVdU=;
        b=QG0WjrUyiSQyl1uPZUKyCtBUSPT8K9qMbALM4qRh1lT/o4anAGNMAMzdtOOutzqr2j
         vCreXFHVSI4rbfKsQpAgHaUw8BfIrxbZGgQ6P6lVJVe1SdgNflMF95ainw9c3YIvq5P6
         uEsP/rn3UtFHJM6qE2yJJ/NUk295HS2RtEufc8Nsf3cZEJaY2TTcJQwFod2/jVZRVVm1
         O7267ALG/cdIYgx54+tu8e+98JGXUZUhEhzhYUUq1js0yZ4ZeG/OwcuL4C97ULunFKms
         hXj+E+8/IQNLpft095NOEx2N5ABdlyXq1vmoVG4KQKzbEMpq25eFF+ie4dkt5tpcGF3x
         v0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2nMrkstdfaLwFQPrDRfpgWYF3hxA8+qBOcuVrcUVdU=;
        b=ttAloN/51HBmSYbuCspfi7f/Vv17vd6hHvyyWlU74i1IwilJmBL106VoO/zxrv97K5
         gjuR3KmQR7SQn4g8DBdI4TLEoEmWOLHh/846d8nSW87Uo2UJHZPwJ+v1cQjWzhOd70ch
         79ueQuI3bWjh9saldpgDQX8gKxNanQVM3T/tj29pzYGHRzvBi/DwRzV0hmy5dD/o0PAW
         ArKFaAsV0kCAPLM9wj9xuIy+iC25PjIArjMK7FJyRx8EousoYlX89oiZG62BzVYjAqlc
         2f5ih0xkyJY+L7xbqPcJBhKv8HNol/oJyMHUtumD0eChgBw950jAUXB0x/85i1b6TUMW
         uGTA==
X-Gm-Message-State: AOAM530aclse9ykjiqiyIqFWC1TMiBVHDniDXYTedN3leuljR/U4lzrG
        PrpOsGIDxEge+/OGUiiKIsc=
X-Google-Smtp-Source: ABdhPJyKKb86MrjM+HtW2Mw3fcm/pY4Y6IzNi8CjmaqbB1/5FxnZ+xhG+fpQ89KivVofPrXQhtzpsA==
X-Received: by 2002:a50:ec86:: with SMTP id e6mr20060994edr.111.1605830187508;
        Thu, 19 Nov 2020 15:56:27 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:26 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2 09/18] arm: dts: owl-s500: Add MMC support
Date:   Fri, 20 Nov 2020 01:56:03 +0200
Message-Id: <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MMC controller nodes for Actions Semi S500 SoC, in order to
facilitate access to SD/EMMC/SDIO cards.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.29.2

