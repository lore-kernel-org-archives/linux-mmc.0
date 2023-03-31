Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7511C77B72
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCaRzl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjCaRzj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 13:55:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0A2221F
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 10:55:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p34so13363619wms.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X9QsV9/LyrqNbg7T/d+xDRVkLo4KEmI/Lt+kJ3J8UQ=;
        b=WQgrqRggpUC2NAvpGwIZ+aVzYzjpU65hI38zU68+ESLBi3LeZLy7MqzISwJWs2tKeH
         v+Kynr2DBRR4dl/s27O7yozU9FIuoFe+6T4hP866340Pg7qVoisM0D/Rfpaw7/ZzCe/8
         QLD5+UhFLyv0tVy89VSnBvTyXIBj/UmTK4moZzWcWZWVjWwuYCgrwLHgi2fXKYv8TiA9
         cjHGi8O4lHk3LYSsUdXmUKptE5DgglSWPW5VE+fC4lcD/ReIrEAIjg4F+WVF5UkBx4Ia
         Rsx6z4UZf6pabewb7baz/BuH305id47jPgY8kqyjBrJibHyTHx1i8I0FhaVQPjPXyF/Z
         hUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X9QsV9/LyrqNbg7T/d+xDRVkLo4KEmI/Lt+kJ3J8UQ=;
        b=f+UC2Uq7tFI2Dm83c/ZFOcRRWZf867xvQdNPSz2mqdJS6HAUltXgq2eDWG6j7XBLHJ
         Pd+atb9cQZ7oBDygoGxvLkiJ9v9X1z7btG+tkictAdGzZcT5JJiTjApJC1FM+g1KYfWj
         JwA7abARIgaYnqD+lZjYfKfnIKFTJyfKbbqmt2o+OlKEXOWgLq94e4rrf1/I2OMswNxz
         zHiA92lyU/ynRbeSrRnMj2sR/CAK2uZ/TxK5A2kHlcy5Zukc7rei/Xe4xRMxwYjDpSUK
         6fVsGecNf24xOaV+QSVVVqA+AtMCKSyMFuEnsnfNPQCTWuob0DXrleATlBdVVdKMt1l4
         vmzQ==
X-Gm-Message-State: AO0yUKVThP6BzTxhCcelu8Q6Tk5tGzZJkF6i3TIW28OdilnxehfZcacZ
        fnIyRrnrrg1VVwWE8z59tcQ8eA==
X-Google-Smtp-Source: AK7set8LXk8MGcZxkHFo/cUpFNkBaTHtM3PNM2BZD8vGkKaYKAXxnw5lu6FxBcIN6ciVOkC2542xoQ==
X-Received: by 2002:a1c:6a13:0:b0:3ea:e834:d0d1 with SMTP id f19-20020a1c6a13000000b003eae834d0d1mr22112353wmc.36.1680285335909;
        Fri, 31 Mar 2023 10:55:35 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:46 +0200
Subject: [PATCH v4 02/11] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xlWHZhxtm0yXUQxDn68Sgf/MoHrbwggc8aGclOBYQIw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6T99FfMtpFkuU48Et3y/qOSZvfZnpPnVu0aq5L
 pHHO68iJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcekwAKCRArRkmdfjHURTeHEA
 Cj+We5q8HnBwf3AGOj3djXUpNInuJoYFw6juyY4xlR4yKWMZdkoTG8mViEkRgMTdIyaUu+aD4SCpd/
 2b5azbeBwLyBZlIUa/n91u4j8mq8SoTvOpfKzohQfbFw71l/H5djaxf/ewkaeqNYz4MJhXquv1ZxML
 Yhs9Oz8SCM4uGtg3Ah0UasSMnbzLacOC3iI/yYb5Pv4pjsEQVwOaWAgQt9znDf056YnZrVHf5I5gPv
 ynQ4YQsCqYRoHq/buFGCbwOhJMVmuAhAtluiwSDlAx7eyhBQkWOcU+xsVcy2aTVvONB4QfPLFUljkF
 kGSNSUSTopoHBNIhPe4FdSZDpDxVl8eeb/rhaPONeGqFPFG/4qkvh5hbNE5LQpQP1Q3EVbeckH6wo/
 qbx1Vfne4DdktBTt9jHEx20Nkq7fyqB90M+3Ee51WRNq86b7gYibDr8/fDd2MWnym3HYmzkPSr1ICo
 PVxtecCmcuQBhjCcknuhtcQ2k3P/aYy2aSvuxoKiQZLR2SgM+L0n4Q8bnCeIvGgI1An8/dxNawgR3a
 RmJ6SAeHjy1nXdrCIUIqBhlanKHfHNuuUNno8UQ2ZZ/3tEeESrQBy5/r7X9P2c8ARNFeMFBweodh1O
 2gpmV/NwRMv4/vMUWDyQjwpabIwm0W+vvxG4GU+K1Lav2GB7mMhjFmDmayBQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This SoC is able to drive the following output current:
- 2 mA
- 4 mA
- 6 mA
- 8 mA
- 10 mA
- 12 mA
- 14 mA
- 16 mA

Then drive-strength property is set with enum to reflect its HW capability.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4ebc7f1caf55..df8e9b32ac2c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -99,6 +99,9 @@ patternProperties:
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
               3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
+          drive-strength:
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
           input-enable: true
 
           input-disable: true

-- 
2.25.1

