Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B5CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 20:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiFFUOd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiFFUOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 16:14:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86813AF10
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 13:14:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so21278186wrg.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKndGtfRMJoB9VZHAXJ3155b6Ocgr/Z/0m5W/nSp3fk=;
        b=R3sETjnSuiHTlG/IUAzV7fv8dB2d7Wfi3qLYLNc9aIyzyelXvPU2/mkdqHiJ8OxdOK
         9EjpPrT+BIuW9BnpUX5pJVptwi19xM1aqlQ3ntH2S40hkm/uJRXdQVZ2TmJvQMr4XbcF
         VdIoxfrs97B8KLigTlKKPvrC5tp6w+YaeOg06kxlzvWW885WtneFPzVamFPzvto1kl5J
         vu0AV4mMAvhrfjf9qxND5ndORn1bpfOaJhqU1Awf4OwE7Sw7DDLNBxys18uyxQ/GpZwe
         95O9Dx832MZjcqSiJ39v5GdixKb9ETtsnviT6fuZDmmM44dK4epNnYyydTHlDDHRy08U
         Yhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKndGtfRMJoB9VZHAXJ3155b6Ocgr/Z/0m5W/nSp3fk=;
        b=cNO+HHLDSfxmGnCBXDJmrgivzVn8HCZ/q/GdT8RuEn504sCdjzkziCkIzx0UWNBzKh
         3byMFbRO1gk+X0TWPy2HBAiuAlDf25zDLkqgpwNMzmZXlnlmEDb7IYWCUY1H0GJjvBh6
         PWfzgHt94cwjV5DUbholgmKn860sSpoJiHgsrtzJRUSaUaOUf05330U9srlXUbhIdJf2
         3X9+SdIatbAdTm313z+Ed/DXzELFg+OoIF3gCWEReymOSVm2yJsAvkx2qMeL3A/VKdr5
         u3nYg4fLfygeHhSiqPw8fiNLdmqJCFwN2LlwuaiyZXDHfY1vP0YSPLeaCF1AxgTqBmcJ
         fcrA==
X-Gm-Message-State: AOAM532cNZYgoL63pbq185PsXhwxGhgdRwufpUtEf1fG7dxRtnx18XNd
        2SL+IGgQBkCTHo9x7NPBI1zCyw==
X-Google-Smtp-Source: ABdhPJwht5UACwjuoVJK2k9+/Vd37V0UwaPay+ABBXzqJFR7D3rCMgEzfyarZa6XGbyJAiiVBloG5Q==
X-Received: by 2002:adf:dd0a:0:b0:213:ba65:73fa with SMTP id a10-20020adfdd0a000000b00213ba6573famr18855142wrm.521.1654546447347;
        Mon, 06 Jun 2022 13:14:07 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4589000000b0020fcf070f61sm16038489wrq.59.2022.06.06.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:14:06 -0700 (PDT)
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
Subject: [PATCH v3 4/4] riscv: dts: sifive: "fix" pmic watchdog node name
Date:   Mon,  6 Jun 2022 21:13:44 +0100
Message-Id: <20220606201343.514391-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606201343.514391-1-mail@conchuod.ie>
References: <20220606201343.514391-1-mail@conchuod.ie>
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

