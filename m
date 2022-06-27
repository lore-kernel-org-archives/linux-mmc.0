Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050FCCCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jun 2022 09:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiF0JQK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiF0JQJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2022 05:16:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF53893
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw10so17796056ejb.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K34hpsdoOs2C6XrJvtKH3w760bg8Auw+6PiZE0x6VBc=;
        b=MAElcMcBy7W3L/1NKFfqUIL4Wywz4AR35JwPl0uMCOb6A+oI4DcJFaKERYdBLvPWPk
         fA9e/6uebjkiX25xG64pxQtRrIylNg3diHR2LtEbpHGfwcwvs6ZmXQoTXX6SRQzEmwTX
         rj0wtE9mlT7P4OfJwUDThH+RJ4MCFQ0Yk0hb/41e+GwRM/2wU4N70nwLQLkdofIw0Yfa
         Uz0TT4LNLgIw0Yiq3TMj05cRTBVrl3iSNIjm3rLeve0M64xWmvU4WnPnLN8CvasToBIR
         ++S+LDxS5A8ebjiN7e3+nYOZk7ydfmODN7Qu3H5/9V5uJIW/6DFhwktvXV7Plum6s+Ze
         nApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K34hpsdoOs2C6XrJvtKH3w760bg8Auw+6PiZE0x6VBc=;
        b=0P43VvHx7K5IVFpplqQf5nFoGZ+kescm6WX9+VV17sq1hFk/0pzYOJ2u5nRzWNTwvv
         sErP6Ba0cmkYmaSRMKbRW5k1mZkZttITpOWeEYHZ2/s7X3IyY2hsmMXe4I6DSDh2ZHu9
         vs7I1oQxi8wPwT4cfT5AdsM9DIH89dVrnQRu7JUnhPtYvOeXvFxwOZE7hNvYDPiHI+jf
         z7Uk6WbKDt2iAudG/uzunzZOuM4CITJQAGHxja3Lfg3DlDh493UBasqNjxJNCuIkXLxq
         GduvKk4jkP6cynyfK5zHO/HJicBLSRwCI7ikfBWiW54lXSMVR1gBp6sJ2OPeEVYS7lAe
         zOoQ==
X-Gm-Message-State: AJIora9b39H000+5RMAVYYinUyKw5tpxSavHobGPKtf9DzHN9UDahDTB
        yR+Y2vNofU3eK9MGc54UdbvOxQ==
X-Google-Smtp-Source: AGRyM1u1vjhgnzc4Js62EwbqrVQ6LGAtw275UTldHmzMyP6y4Bv0YMffKknJ9apG5elKuoIakqp30Q==
X-Received: by 2002:a17:906:53ca:b0:6fe:ae32:e01e with SMTP id p10-20020a17090653ca00b006feae32e01emr11405770ejo.455.1656321364523;
        Mon, 27 Jun 2022 02:16:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, jh80.chung@samsung.com,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with dtschema
Date:   Mon, 27 Jun 2022 11:15:40 +0200
Message-Id: <165632135506.81841.3968515588802309460.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Jun 2022 14:03:38 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects "mmc".
> 
> 

Applied, thanks!

[1/5] ARM: dts: exynos: align SDHCI node name with dtschema
      https://git.kernel.org/krzk/linux/c/c805b77caba9e49d43321112f272508d2b1acd25

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
