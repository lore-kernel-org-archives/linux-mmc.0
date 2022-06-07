Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E094BCCA47C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 06:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiFGGcx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiFGGcv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 02:32:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA128991
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 23:32:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v19so21595303edd.4
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kUL0/+TW0ZmFocb8yDY5jqKbncdLIBblavQc/eaSQJI=;
        b=sftAmM2OlEfC6VJ8zIEA0Xfsy6v2HTaNTjUKMfYdtxoSdcD3vxrEO/PCEGePaDtozC
         xyHlmLmsdRgR2yk1elTff9tbXqil/B41tk+0WtgEj08Gm/1Kmpx2r/HeUOPzdA0SMfGc
         wFE+ZMwPJFu6CpQ03yhMFxJ04tcjr5hJhfqrLepuc7NPW50CeYYD/ZycxufDQK3A+vuv
         T2ZpVYajmKu/RZ+gY+7+/lh8OekW/q2hi1jds/Xh06lKnW8KXQa4oJEoM09itLbjopST
         PwShn5HcVR8etj+2V8Zl0LAGZJFoRFdvIEiublN0VZCnbQrafYQwBrkLSxB59YhB/GsV
         tuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUL0/+TW0ZmFocb8yDY5jqKbncdLIBblavQc/eaSQJI=;
        b=VmaQubV7mkqkG38LD6mIz3c0bHMmMxoqAQZVWnGMjVMNOua8qFXoqcADiKvgWfItQR
         Suz4hOxE1pcGuz2Wmdg345mFaOqF6AQCdps+UanKI5hEV2AIURdvlrGQs5Xu4etYksSe
         7oICRNIk3YXGN6ymeaYuTiKKsntz7TUjLhk30ccXKq6hFokAdaJ1G8bUPQRwx9OoG6d4
         duYmCoc6042xQb52i/c17y1lXv0S6Gx7VkZDQnZsXffK7gRFEo88uCKkhJyUHX0uX/sX
         DEHm3NE2AZsMEoCpBr46CB1RYvSaWuoTgyisNkxrAcCLPpTadkJjWxqkU+O8L+QrbaYn
         Hfow==
X-Gm-Message-State: AOAM532nOpQlhZVFmQG59CSYVf6YTu7/4AgrUVikhoc+VLUB5r02y/K4
        /msVyA9CaGT5S0Gjhk+8bZF+ww==
X-Google-Smtp-Source: ABdhPJzMq/JTC9wN4RGWyrxYyQtSlviJZtlJ2Wjip2i6n2thkVBo2E+uQfiitHipF1MrM27CgRNrQQ==
X-Received: by 2002:a05:6402:139a:b0:431:6b50:11a2 with SMTP id b26-20020a056402139a00b004316b5011a2mr8272850edv.72.1654583567642;
        Mon, 06 Jun 2022 23:32:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm9796349edb.13.2022.06.06.23.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:32:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 2/4] arm64: dts: exynos: align MMC node name with dtschema
Date:   Tue,  7 Jun 2022 08:32:41 +0200
Message-Id: <165458355453.6489.3351290853657960731.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-3-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org> <20220605163710.144210-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 5 Jun 2022 18:37:08 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and MMC controller dtschema expects
> "mmc".
> 
> 

Applied, thanks!

[2/4] arm64: dts: exynos: align MMC node name with dtschema
      https://git.kernel.org/krzk/linux/c/2164784a4b2700d1929854b5ec6b2169ff449814

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
