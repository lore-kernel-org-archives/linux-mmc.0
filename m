Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F85CCA473
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiFFP03 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbiFFP0X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 11:26:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C0328EEB
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 08:26:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u8so15999318wrm.13
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKndGtfRMJoB9VZHAXJ3155b6Ocgr/Z/0m5W/nSp3fk=;
        b=aJEoKakPceXnbp1/ZlShcjfkeytqJDUAJr7R96RlUzYUysC5vsKDlaQOFn4CuEJOqt
         6lhIxLXlNtmdxeKHk4mesWxv20OXnO5LbD8vF2oZLoegnB2ohozQL4HS3QodkbprZN68
         eZcOZoVKCoZSg2pDCktQ/G5fQsz3dGyKfF1I4rfJgO3VIn0v3Koz48s/4rtU2+lGkcU0
         WMCWFmkoNYTPPCClc4bd6usX25oVt+CHu+IA7WfdTxpBR3jb8GhFQ9pkmZFKu133Y/Oc
         CCPs1nMC/CN2VyBK7h9NZBeAIn3I9T082Zz3ShRxaViE3KN9EEM053orGKLOrGpV8TXL
         DWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKndGtfRMJoB9VZHAXJ3155b6Ocgr/Z/0m5W/nSp3fk=;
        b=IUQXFcgRTFPrTM2COPzru/H+NYsdecHvvmqNhUZEqLmEwL+hzUXyN54tE6xQCmRLA5
         5UEaYuDRTgO2l5L9Ij7eeIpCWoXN1U25Ew/wDfVC6nB4WRSTbVIy6tfUYlNJlKNui5sa
         pST0rIb0PfUP/7ht6URnb6ytysEmp+1Q/Iz5/SDoVhdUU6cTzJO8xt7+/9JRmUQ17mEA
         l0/Umle6w2CmYMJLjKSq9vILyRMR5c760McFV5L20dICXTpsCfbCPJekAG2+ongOgcJu
         DI/mqyclTgEk2LK9eRH3kGfa+q0USrwTrogXLlfcUOXxcSw3kIDqKbRhgzPdC27sgsjL
         K+EA==
X-Gm-Message-State: AOAM533HSbAa60of+NdxkSaDeT+kT0BWV6nnB7CAyESFaxzIW3XyOhkE
        iW7dne8ScecVs32QtUatVjILRA==
X-Google-Smtp-Source: ABdhPJxv5R9KdhXC8FcRfcFRcCDgFBV2z1vjprwaGxWfFLbq88Rm1mz3L9kBxgErlQ4yXKLde/16gA==
X-Received: by 2002:a5d:5142:0:b0:212:af29:530 with SMTP id u2-20020a5d5142000000b00212af290530mr22119805wrt.444.1654529174889;
        Mon, 06 Jun 2022 08:26:14 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b002103aebe8absm15623944wrs.93.2022.06.06.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:26:14 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] riscv: dts: sifive: "fix" pmic watchdog node name
Date:   Mon,  6 Jun 2022 16:25:58 +0100
Message-Id: <20220606152557.438771-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606152557.438771-1-mail@conchuod.ie>
References: <20220606152557.438771-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

After converting the pmic watchdog binding to yaml, dtbs_check complains
that the node name doesn't match the binding. "Fix" it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index c4ed9efdff03..1f386b07a832 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -90,7 +90,7 @@ rtc {
 			compatible = "dlg,da9063-rtc";
 		};
 
-		wdt {
+		watchdog {
 			compatible = "dlg,da9063-watchdog";
 		};
 
-- 
2.36.1

