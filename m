Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56594C6FD1D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCOS5h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjCOS5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 14:57:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663828E4A
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 11:57:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so3364288lfb.12
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906653;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+Z6yMufViGivHBpi3ybAlT526oTlR6qrL1yn4estsw=;
        b=RF1h7LFH138tCY9kTL2ybEQ9KerX/5fYP0a6Fo4UuskEjKz0b4IXSNeqeXRNHBAHdo
         C/D/CtfyW5ZbVzZVZyBV0UwH+UxcUKUXILAAk6LpoHQDReiZpNKA8+PtxZUv7J6BjpK5
         WlXvsljW+MrK4GuHu9a3EgFdEdb3p4NmEHmPtcsUAFt2ffVdXhx1OsAGZvlN4Fo2utZd
         bixVk4SzZx32qIbGU0W9r8j678q+L8UfhxWKRnoSWAwfenhcEBCo6XH+ip+shSaGwI6r
         Rg7YHYAPl8w8tVWVx2lLVQw4yRnk+xe94Kn228IGyAuCdSKRK5dQyLsqu05idvSD6i2y
         b4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906653;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+Z6yMufViGivHBpi3ybAlT526oTlR6qrL1yn4estsw=;
        b=WNekYK6nkOYWduNMKw0kor0uk3zoRN01qxUiyaR1NjEwOJ5+hFl9+GwjcaipMiiu0y
         M2LAjco0gVcJ/pkCjfhyvDa6Bxe0FtkWLe9dU6ftKAsosdSPg+PHAYmRlxbFoLxyxHXm
         fwP5ojzFGd5F73pcTQin1ce5WXRH9O+dAZ5RYxiC2JlDf8+JKHw2C8k54Aiy8RQaAEiz
         WR2HmdtS2o7+4uhbncfG4u8bM4G+MhOMVqD1V+G+ymlc1E5zUewYBt5u1qUXipMX+FYx
         UQn32y7YqxuSaYERZjCyoDfN0COzq5LJLislbvx6oLECBnKUJpJECY+l/wXCnkcDn4IF
         lyLw==
X-Gm-Message-State: AO0yUKW6emdR/AxhZnT0c8u6KhqAy8JyprrgkLNDUpTcTkqQ8G99xll6
        fXHP85woELsHarvS3dO0nT54p7w4HVIoIfe6
X-Google-Smtp-Source: AK7set/kH0E56fzlYeGvT8XSXDFmmdEdnU/AkMVVq+DL5sx7WlFgRkbrkGyITGYATozSIltsWq68pQ==
X-Received: by 2002:a05:6512:408:b0:4dc:65c0:c74e with SMTP id u8-20020a056512040800b004dc65c0c74emr2374568lfk.29.1678906653229;
        Wed, 15 Mar 2023 11:57:33 -0700 (PDT)
Received: from letter.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512014400b004dc6070e121sm909932lfo.83.2023.03.15.11.57.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:57:32 -0700 (PDT)
Message-ID: <6412151c.050a0220.36b30.3190@mx.google.com>
Date:   Wed, 15 Mar 2023 11:57:32 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1bd962b1-2fbc-9bdb-8b7a-9f2c70c316e2@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> +      - samsung,exynos7885-dw-mshc
>> +      - samsung,exynos7885-dw-mshc-smu
> 
> What about the if-then at the end? Since this is pretty compatible with
> exynos7, then I would expect being added also there.

Makes sense. Also it probably makes sense to add "samsung,exynos7-dw-mshc"
as a fallback compatible to the jackpotlte.dts, because it probably
somewhat worked for whoever contributed that.

