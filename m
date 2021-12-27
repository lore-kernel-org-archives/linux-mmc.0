Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C8C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhL0NgK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:36:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39574
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236827AbhL0NgH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:36:07 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E2583F1F2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612167;
        bh=6CumE1tdz/IiMkyzPEeBLg2u+UtItsz0xDBI5CCIEIU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S0i2QQtHA4bcBPSEo7b7oUAMfNF/pNTsJUk2Y2hSK9ssw91N3yCYiYciicL5qv01A
         GLmMhVqduENCseXQ3wLyNFOAgOYy/YPWuNH8MWWtcEg70Z+X2qmOwC+nvZtCskr8o7
         DsFmbBXFZWEa5a9U9uwp6HFsfYvShDEB4oIbsNLXm3Ujs0MUEUL2w2WJewgBUoWoED
         3VrdmMT+lsM1+J7rC8x4fRnR8lCiCGOdwhXCCHh7CuM07aV3NhpXDJCvuAo4rk8cOZ
         8G02jWFueSa+p0bPd3uI8k73NsoSJl7jGs7bQF5R6NhyOoHsQWRdlWzbIlqrHOyY+k
         FG1zf/r9Kuf6A==
Received: by mail-lj1-f199.google.com with SMTP id u8-20020a05651c130800b0022d6dad0418so4973202lja.11
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CumE1tdz/IiMkyzPEeBLg2u+UtItsz0xDBI5CCIEIU=;
        b=gQE78ZDsRHYJ+ntTOwbFaNW8EgESXazssNH5zXt+AulhvnwVsSYh0vBMYM1hDaxPAo
         mHK5vr45z9U42HX5Z+SKXGHmubz5K7VfPDa9y6JBEXeUz+/qBQq4jzLzVq+f07uBs+Sg
         /xr+fSnAY1ab9xWpMRTJakFMgfNtj64UqGAh0MfRYlhp+2Ysoi1Qym9jzkOlIPB11sl9
         s4CmxfDo47qGPDanwSnzeivfUcKa3w9mAvhkz353eYjJJVGXyP0id8Us9oobLcUYKxOD
         5FwiEuyq8Uut7XE07yHRoH7DL10bEUPXErXmE0Iedr49DpreaDaRY/ScMMTN8GTYtlCq
         fCpA==
X-Gm-Message-State: AOAM530x+maDIcHXvdRqzdh+ogi9pPyOhQ5UKWG9KcjIBVw4G0mpT1Cy
        kuV8AI5sfFvbaKkCVCpD4pzqfD7rbUIin7rtNearoXx1pDd2APR3p8ndEH5fp4uQSXTyqQy5/H1
        KUr73Pcg4I/AtVu2HaZNAAGYVkQqxnqCswKBsKg==
X-Received: by 2002:a2e:bf24:: with SMTP id c36mr14663999ljr.150.1640612166757;
        Mon, 27 Dec 2021 05:36:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXnVeuN6Vzh2Sk739PqVMNoEtG1DsCj0nvwPussspyosmpW1khavfDw2ZEC2G+P4qbT06Zlg==
X-Received: by 2002:a2e:bf24:: with SMTP id c36mr14663990ljr.150.1640612166609;
        Mon, 27 Dec 2021 05:36:06 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 11/19] ARM: dts: arria10: add board compatible for Mercury AA1
Date:   Mon, 27 Dec 2021 14:35:50 +0100
Message-Id: <20211227133558.135185-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Enclustra Mercury AA1 is a module with Arria 10, so it needs its own
compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
index 2a3364b26361..a75c059b6727 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
@@ -6,7 +6,7 @@
 / {
 
 	model = "Enclustra Mercury AA1";
-	compatible = "altr,socfpga-arria10", "altr,socfpga";
+	compatible = "enclustra,mercury-aa1", "altr,socfpga-arria10", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.32.0

