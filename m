Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ADC54EED
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjAXPIh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAXPIg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 10:08:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8B2F798
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 07:08:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g10so11688775wmo.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpD93/8saSG6FVl0mrJA18o+SgZIDhyy6bHZSPa5ZVc=;
        b=ywrKQyy0bnPygWmgskVktLWTsk0nGFr9JL24yTYTjBfxOfOGMM1oqYqwqQNUjhy7hx
         9mOOQLl6uVy45xAg2DZJsnZerovFXi8dr1ECqtVZ8704hvKFzipMrxJHEA2HGgFY0gBE
         a2DHIi6oipZ+37umeiA3xie74yPLiJRaqu+ScVmPMRCyGcao4I8/rcxaCGzU4E0skQfs
         07U/0ppGeh+z07ehD2R40KuFP1C94NkUCm2lXy0JFPKG2CKFt9yUhnF4sU2y6rVzwzdk
         pVkzKUqhYKlzafk1bpx90WuSlksrz2l7yPxVeC/4K1NnvVv494wOyuxmh8X7i/oUr9uM
         RnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpD93/8saSG6FVl0mrJA18o+SgZIDhyy6bHZSPa5ZVc=;
        b=1+jVgx6+3xtcQtsGeZ9hdR2lFDLMcJ/N5OnHa6ytIEyCbfpA7ZipsoOLpqsQCkDZ+H
         jaiQb14WTITU0by9BHGYosc9wx7MQ9aOI6CjOuaauwp5mzZ6/MQi7l30718t0ojP006O
         Nc9RZGpHVHee914MH/iQxT0H6aKygJ7SKGbzKW/7lOXlGMf6sKRZPvLqrY1VQ4EUBk44
         T5DfKFtsNqfW3H6fzWCQKX/2iQDi9qWsqnPoBWr0bYQHv3w8J+eGtP8kkG3sElEfJzsG
         dq8jem0VqEA4lIDj9QYUWISc5Iq/amDo6rGG30Odw+QhwZ4WXq4Bt0m91g+ZjGUqRE6G
         ocCg==
X-Gm-Message-State: AFqh2kq/NBbmoEszbaRnCFM3Yc0I48hg5RSsnVe9ador0Be/rSZRv2Lc
        WiAxIRR1rL/F4FHjSPg2sjBmpA==
X-Google-Smtp-Source: AMrXdXuR9Rz59Cyw6wMqS/D+Ij0Tq/psvx455YdozuOm1SlY4s9AJQfWEJNBvL1Gg5GRPaH+L7RJDQ==
X-Received: by 2002:a7b:c5cb:0:b0:3da:fac4:7da3 with SMTP id n11-20020a7bc5cb000000b003dafac47da3mr28143582wmk.36.1674572912292;
        Tue, 24 Jan 2023 07:08:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003db00747fdesm13625469wme.15.2023.01.24.07.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:08:31 -0800 (PST)
Message-ID: <0b2737b2-ae24-2c2d-f258-5c374d8f04f5@linaro.org>
Date:   Tue, 24 Jan 2023 16:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V1 3/8] dt-bindings: pinctrl: qcom: Document IPQ9574
 pinctrl driver
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <20230124141541.8290-4-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124141541.8290-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/01/2023 15:15, devi priya wrote:
> Document the pinctrl driver for IPQ9574
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>

Did anything changed here?

b4 diff fails on this patch, there is no detailed changelog.

Subject looks not fixed - why "driver" appeared there? Bindings do not
document driver.

Best regards,
Krzysztof

