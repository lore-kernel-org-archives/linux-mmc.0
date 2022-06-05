Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA46C433EF
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Jun 2022 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiFENdZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiFENdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2022 09:33:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BC38DAD
        for <linux-mmc@vger.kernel.org>; Sun,  5 Jun 2022 06:33:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so6601908wms.3
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2022 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mkd6aXMnIDerQLoHrLWEjvYyGr3xupK+E9ATz84tnuI=;
        b=bl8GOPL/9Anc8bPUu5kO48+tI7Y4tEopw6WUpip5A2dIGh4+3aRt3lXY6dwxGUPfYq
         A85sZXax9VvKJ2EQXrR5PlrIa0KsLMDvcy/mz9qEdfd+BmbG25/QnoIB9sZmm40B+B4n
         1YPl6h5ocUoGZSOPLgCeMIctRYnP5Hc+4W/XhCkRghlvw20ny4WKudQTxVKKimVFmrmd
         UK71jcEk6sEQAt/v41CfLGm2yUNAHj2MJq/maynD7W0Q20Jzd2xtuJQ/Ne/P2PWEcWrt
         VczdkTgTYJ6vt/Sf8SXiE/qglL9oHLPoWDG/T45cwdSr8bgOj9G0EHASeO5yecZ5b6Fd
         cYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mkd6aXMnIDerQLoHrLWEjvYyGr3xupK+E9ATz84tnuI=;
        b=A7QA0DABcix4JvL1Z/+dG4iC3+vYijq+W17hBbYD/lUeXxo0rbmqTndo0xd+ZWFFqv
         KhIpQCvO6p0s/YCl2YfmVi++SPjK/r/L8UofC91JSRSIRz9arnll/scxBUGWp/eaJfrn
         NCsOSbIAHXYsN5QSdUk3V1IuQqJkzaINszRF97bezwaZBQkLjkL9Wvl6/J5688tFOmRc
         etSAwYUZiGT7rpoyxyvOrnzlczY/sGSCR2UfiMI8lkxCCp6v7rf0tJTzXu13g9DA2PIy
         yjOKkjzuatwghaPmZ6K2YxZpAcYdudpParOXiWB9feLwdMaotzemfxECP3EsmUf3ZbcO
         EC5A==
X-Gm-Message-State: AOAM532B2WG/LMu8uIvULf7j+CXR/SINxeDAZFNXNIjoyh4bhs8HDbmJ
        dvZ3gy/i+Yumo6liZQQ51qNzOw==
X-Google-Smtp-Source: ABdhPJzmtD/Gqhq7VtIjO7czq3hs4rt6LGJN9waxCjTI4IbAjjLaG5Fwrvpsj4ytTsG1+gypnWX5rQ==
X-Received: by 2002:a05:600c:4e91:b0:397:8870:a3e9 with SMTP id f17-20020a05600c4e9100b003978870a3e9mr44366442wmq.141.1654436001738;
        Sun, 05 Jun 2022 06:33:21 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id n187-20020a1c27c4000000b0039c151298b7sm18217076wmn.10.2022.06.05.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 06:33:21 -0700 (PDT)
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
Subject: [PATCH v1 5/6] MAINTAINERS: convert da9063 to yaml
Date:   Sun,  5 Jun 2022 14:33:00 +0100
Message-Id: <20220605133300.376161-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605133300.376161-1-mail@conchuod.ie>
References: <20220605133300.376161-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As the da9063 dt-binding has been converted to yaml, update the
maintainers entry for it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f799cf34ea52..8e51bc154584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5805,6 +5805,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
+F:	Documentation/devicetree/bindings/mfd/da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.36.1

