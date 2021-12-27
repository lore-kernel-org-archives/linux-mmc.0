Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F64C43219
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhL0Ngm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:36:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39756
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237032AbhL0NgV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:36:21 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E90C3F07F
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612176;
        bh=JFavKQ4EpkcOZ7wQmRTeTvx/mZGmly/qZElot/QHLH0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z9U5rdJcOtHe9DMjh0otK6nZ77vPGZNAQQ15NecpofHYh+qJ796act2dZv2mc9Qbx
         iVCBrfHGutb8zATIMRwlxEVW9gAprFZ8GbsGjOqekF8MJnjJb0iuOlbjBctl622wUq
         u18x/LVEJ0KADUl7eY9n4v3IbzEwQpkTRUgFhaNVZHyyodIGPuYySo9t+eGRtYI9Vm
         bR4ALx1VygOi+jFmeZNBkGEiENovx74yetlmfZxvczSXH5vRLlbj3C0IC+PNIWgNGu
         mCD/0z/H59fmXfy8MNLQKHM9eTo4DjXPHvrZ2iac8rrMckGcyoBh35nWVlNMV7r6ST
         g59QiQL5Brl5w==
Received: by mail-lj1-f200.google.com with SMTP id k11-20020a05651c0a0b00b0022dc4d55f14so1984950ljq.22
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFavKQ4EpkcOZ7wQmRTeTvx/mZGmly/qZElot/QHLH0=;
        b=kPGK4UwkRgmEyYeC1ap+RcjitS4/iLIh+l6CbmWyJ5wGt53i2lCyNRFm10XFW+npgy
         1XxmDlV9VVfLZ2O8689DXILos0Bfxu7iGtiycy29WnuDqozrFL2/aSAAthYkpvYPxDYL
         /WtRu95kSA7/biRxD32n9UEQgqbyRF5LY6sr7Sm0tJFn7Ygy7iBQhvi1NmHFv0oQ49XP
         cSgSaEfOfsy5qsNYiIpeaOG3QZS+YZOLWyKmLys9Mld79cHMZ1NWD+KOiEuwoB62cHOf
         yfxTBXRlojwD3o1NwWj4/NYZBYazYPwxHYr+cDuUVi/JQMe6THfEb/D3Dcuzh6yKLSlE
         ES6A==
X-Gm-Message-State: AOAM530E3WhoaCAu11i4SU0QKMsp3W1yGKm5UKGnRvuhDBNQgpNfjX5r
        gmto+fHUY7brHhB0eQ+3MO6G6319uA04cl/fvnXXV38kfHC8AqPOZu285961XqokwUIAF/+g5y+
        hKtUJpsi748uEgMBMeV0GSgtOvE8IOO0UupAP7Q==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr14341426lje.383.1640612176050;
        Mon, 27 Dec 2021 05:36:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyigWSTBhHMTJw9c+BMRCCqABSOCIw31rtBFtt3dBgwEbcNUZTxOPbnbqo+v1WaY9WCE71FlQ==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr14341415lje.383.1640612175896;
        Mon, 27 Dec 2021 05:36:15 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 18/19] arm64: dts: agilex: add board compatible for N5X DK
Date:   Mon, 27 Dec 2021 14:35:57 +0100
Message-Id: <20211227133558.135185-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Intel SoCFPGA N5X SoC Development Kit is a board with
Agilex, so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index f3c1310dae0a..5609d8df6729 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -6,6 +6,7 @@
 
 / {
 	model = "eASIC N5X SoCDK";
+	compatible = "intel,n5x-socdk", "intel,socfpga-agilex";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.32.0

