Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B180CCA482
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Jun 2022 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiFENdY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiFENdW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2022 09:33:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573238DBA
        for <linux-mmc@vger.kernel.org>; Sun,  5 Jun 2022 06:33:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so8685131wme.5
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2022 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxHo2G/MFjOMreF495XhNz2LYNZUg8qT/+RBpI9PUtU=;
        b=GyflWBfDey8F7h0aXmePopOxBzCwMdrBZ/rms2VWXDiLEAKingS6VFUymMjDnTB9eH
         lcf2hErSL3bZguOFLwFMqQtt4ZClHUReRvpI0APoAYwE4Qo9xjhtmMntAJmyVQ2ewEds
         F7J1Jh3Od2Rb1uKnbyr0ET9dEc5LUc2jkYSa/1y03QTjVTNValhQqWMEKUxpE4J1zamc
         piBKUA32qYzp5OCQT97iQj+icCEIuUA49n+C8pN2TB5wvjhI7bukPPcdjO94in0lUdaY
         z/jzeg1XMh6GnLlEnpLrM5UNiEjhpqHWnKi5zZpjx2e4Y2US8g3hoxoOz5P0ShFrU5JV
         Y+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxHo2G/MFjOMreF495XhNz2LYNZUg8qT/+RBpI9PUtU=;
        b=PAKKuRPc8N7GB6gbmmngIWT7TAyopeZPSo/uWNONMKfGWa5yxFh19VUfxJOMb5dHjx
         u//c7UEFrLFjn1uegRQrDOE7pwg/E20tWMnwDe9agByw/HQju0pbgtqIyB5E6jk6W8sP
         wYHcIm92eOoRht2oRws8SbeiYvAjDIV20P90zO9Lcjr6lqG9D/q4GXKgdpUAFcfwf6gP
         cdedr9Q0eANhHqqGkSzChgSDekjxKYpjGlpPCcwhEsYyCIkFzPGYyPHIwJ3EWUpwM3Ek
         P+ke81fpTh+NvUdRCqABft6jn0TVCEmMYwjcKWukw/KaQwIAVexlAxRoXH6tRI9hxwrI
         L29A==
X-Gm-Message-State: AOAM532zVoKjkGjicHy0FJ/LTou4WlaCGI7Bv+5v/21ISi05Nlzdm3hu
        /rGiUjaKwFSn+WpWZZnMtTkazw==
X-Google-Smtp-Source: ABdhPJyEHIjQiJuKOu1YPJQ7jg0tsDoGPCGhSJazHb2r3q+Ax+V2lnyXRbTFBdqUkBxVN8dXg+h9Hg==
X-Received: by 2002:a7b:cd83:0:b0:39c:46d2:6ebb with SMTP id y3-20020a7bcd83000000b0039c46d26ebbmr7211195wmj.187.1654435999213;
        Sun, 05 Jun 2022 06:33:19 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id n187-20020a1c27c4000000b0039c151298b7sm18217076wmn.10.2022.06.05.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 06:33:18 -0700 (PDT)
From:   mail@conchuod.ie
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
        Atul Khare <atulkhare@rivosinc.com>
Subject: [PATCH v1 3/6] MAINTAINERS: convert ocores i2c dt-binding to yaml
Date:   Sun,  5 Jun 2022 14:32:58 +0100
Message-Id: <20220605133300.376161-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605133300.376161-1-mail@conchuod.ie>
References: <20220605133300.376161-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As the ocores i2c dt-binding has been converted to yaml, update the
maintainers entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1b4b77daa5f..f799cf34ea52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14826,7 +14826,7 @@ M:	Peter Korsgaard <peter@korsgaard.com>
 M:	Andrew Lunn <andrew@lunn.ch>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-ocores.yaml
 F:	Documentation/i2c/busses/i2c-ocores.rst
 F:	drivers/i2c/busses/i2c-ocores.c
 F:	include/linux/platform_data/i2c-ocores.h
-- 
2.36.1

