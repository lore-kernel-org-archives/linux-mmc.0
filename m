Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC8C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 16:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCLQnm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCLQnl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 12:43:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C527986
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 09:43:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y15so3312982lfa.7
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678639418;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKTinlG5kM8KUglYqEy7kn40PH2Oa+0TdD9V1KN73Hg=;
        b=C58NEghR3C2wXI2nl9d8xr/VW5vDGGDgS4nZaM1dpOUrHbT4kzhUzvKY/qqzWZLrvf
         r4UXH3auark2FvNYbNVLB+/QO23gKZ1SIT/MXlk0BNNiH9MQ+B72jqtPNY9d/Pxxjn68
         sg/3ZfWrnfaiqwomkhyjKW2eBBNkXvCHKRw4GqwrqSZjLZWXpVGpRHu0ATYvVLKXCLap
         uGTtDjaZ8vlj1GeFnD4uh4h9SQ/SkPjZ0ZYOp7Sg28ImUGilazFJSvxpysSrAOd6Zath
         YVCYdvrGpEAvdANpULOL2GKrZj5gTkqmUVu86I9XqmAE+H9D9srcV9kTjHSsWc8gog8I
         rr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678639418;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKTinlG5kM8KUglYqEy7kn40PH2Oa+0TdD9V1KN73Hg=;
        b=BPBzgcvV14skti6fgBYZeIBJR9eiewy6qvhf9kme0YRBfYQKm5xgW2xRyA3nbqjThT
         8YYpP98uNFXnbstTfyuBvTymwcx4VwRixRYzM7BwKnHmJ7IbjGbFcvYXhwm6x5p5Xi4U
         jI4gOaovzwP7tHhavD8c0wG/IgKhatPXMUrxIeKS1KWb9vMMB8fO6TIB9CUVbo6m+UfO
         b0YKR4qbGskPkUBOhnQUZVdDfpwZCgqD2YevaI8aCkv4xknLaErPw651KVwi17U0CLcC
         kIPUtUtYfpN5Mc6nZUykDbfkE/bICUTPFaRklEY97Y/TrMCfdzBt3BHUXSpjbI/RG8Y6
         CFCw==
X-Gm-Message-State: AO0yUKVETwEhQmRrDOak2bHo7s8thbgdLt7JYVM4WMQRcpVrOvDcIPJ1
        SxP1IXxRPLWXM04LWvuD0nGGXiYv/eADYvGF
X-Google-Smtp-Source: AK7set+ifWiodw6uqCRQDWyt0lUSAGwHh72oLA8+otKNlSO1hODxVorsv7xFAqQEG5Tx3iBH/jARqw==
X-Received: by 2002:a05:6512:503:b0:4e8:40ec:a54c with SMTP id o3-20020a056512050300b004e840eca54cmr690160lfb.62.1678639418656;
        Sun, 12 Mar 2023 09:43:38 -0700 (PDT)
Received: from letter6.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id g1-20020ac25381000000b004d858fa34ebsm692433lfh.112.2023.03.12.09.43.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 09:43:38 -0700 (PDT)
Message-ID: <640e013a.c20a0220.7d1c7.19e3@mx.google.com>
Date:   Sun, 12 Mar 2023 09:43:38 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c9f8d89e-7420-a049-907c-60e3fa551548@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Bindings and DTS (and driver) are always separate.

Okay, will split the patch.

> Compatibles must be specific.

No, this way you'd have tons of identical compatibles that only differ in
the exynosXXXX digits, and are functionally equivalent.

> That's non-bisectable change (also breaking other users of DTS), so you
> need to explain in commit msg rationale - devices were never compatible
> and using exynos7 does not work in certain cases.

Valid point.

