Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA8C43219
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhL0NgN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:36:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39642
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236827AbhL0NgL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:36:11 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52942402EB
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612170;
        bh=2raMQbTEO7GSuDvkY6ovvPJxx8orpnvUqhVxP2Jtxb8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fHVPWDsrQLpAkWHylDsinT47nIqW2hqgWtK+DlinUllZ1r/nb3FDRfxQQ2OGfNa4n
         sw3Yu7ePew6n7p/1pFV9ROqRdtjEUkUZcGiaKwZmjaqet7obSWu0LUH7Pm64iR215Y
         Bgpm3eDptWIBz6y8lSa59U/fwcyzfS6aJ+7V09WyvQqqGeFEHGOIWKJnzpfi2pWQEZ
         7z9u19Uk3r8jvVJHYpUxEbIAmXxVYuEfHWv3wXjJNJ4MyDX+G8NfUzhl3nK+5u8CZ1
         apjqDKrMwG6MbGh6hCqqrSvK1er70nU84p4ZKe54Y+2Rtc3Ve+tyrFwOPKy7Uh3FrB
         R4AxEgHoIctLA==
Received: by mail-lj1-f197.google.com with SMTP id j15-20020a2e6e0f000000b0022db2724332so2624929ljc.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2raMQbTEO7GSuDvkY6ovvPJxx8orpnvUqhVxP2Jtxb8=;
        b=TsYfMUMzExdX4d5d6l0rsLIBXGxNm/995xdAGeBEb6CTD04qRZxdR2AtBec3XetMC2
         6htp2l8wy2LEfneL6RbhkkO+KVz3QZcNp2auG/cLBUZ2ce+Afp10h9xJOQX59/EfZBe2
         wnwp5pJ245lyJcjSYEOoKS/EKlhowaF7Y13QoTAAMJpbqac3J9lbYjCqA9M6sH2wN2rg
         p/qQiOCyj5TgdLKJD25VTAnc+7ah/6mipVyWttKK+1EAYHXhBdCQQ9EQAvgEPvOjq/jH
         tgkDmUp+LVgyavh53JN9lyMtuUS997Am18IydKghUgwc9pmjMP4OColhhkCOBeMp01ec
         aHAA==
X-Gm-Message-State: AOAM531kgxMG3hk8B9bSpIauUULP2SAY5zSyL3cVifxLfWhHoFu/9pnW
        EozVzFFkIxIPmOSF8qlpF/EzHTDWyIUPQJ3/WejbF60OXslJNTe2ydsd5UBkaRw46OW3xcDdzX6
        hcL1PHAMajnkpDO2fNmDaeYtfq/JlfPbWL2nNxw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr14726557lfr.295.1640612169356;
        Mon, 27 Dec 2021 05:36:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8X2sqRJEu3DvxBtUDtpU3Y5uc/tMDwNZZNmfbYtUwIkhKBrQTFmqTLlfc1ZtsOof7nER7vw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr14726540lfr.295.1640612169204;
        Mon, 27 Dec 2021 05:36:09 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 13/19] arm64: dts: stratix10: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:52 +0100
Message-Id: <20211227133558.135185-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Altera SoCFPGA Stratix 10 SoC Development Kit is a board with
Stratix 10, so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 46e558ab7729..12392292c62c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "SoCFPGA Stratix 10 SoCDK";
+	compatible = "altr,socfpga-stratix10-socdk", "altr,socfpga-stratix10";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index bbc3db42d6e8..2d53a06deab5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "SoCFPGA Stratix 10 SoCDK";
+	compatible = "altr,socfpga-stratix10-socdk", "altr,socfpga-stratix10";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.32.0

