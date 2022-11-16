Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D16C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 11:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiKPLgv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiKPLgU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 06:36:20 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515391274B
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 03:25:32 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d20so21389851ljc.12
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 03:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZM71frnZZLp19b4NLzS8nBdgegtvmEpImjaHi1sl2s=;
        b=VeUVuPlx1f3KVvtmjKpYFHmUBlUbJvBV3+yApBMuY9/DpNzu1eYzwQqowvp44wACCk
         vQHQt8r+MY1COS0m9WqFodbUkYGSZHTFWOPz/PYKAXo/TctF34fZO6FOVlQmBBJ9TQz5
         cRGzQhIQD79xR8HAXg45MfGVBh36sK1ccgpBMgQrFqs4sXu1Q4a+RZ4Vri1c52X/6ekE
         6gkjG/luSEdiy0UFGYr/wTd1VpxjKJwkT5m59QwPia43e/URELK9RpL2f0rT10Z+/4h+
         7izYTba7IzSpPgMXlY1s3CoxLOPSlz5Ht63XAXWwvdP1KUPvQE70aZFAatnVopnkZ75k
         RJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZM71frnZZLp19b4NLzS8nBdgegtvmEpImjaHi1sl2s=;
        b=cUxgFpdclHBCfQXNLSzfec4Nd//lUv1An8HJlFqZGBobh4bjETQfSaRgI+DJNdDv7b
         t45MROtMTLzoQG+7ztgtOZ8GsQa2eujfF87wNvlvdZX5XRrnSMz5TwWHLJvSVOCW28i2
         2Lrg3xTGmZ7LYF0PGep2+1lNwFwiFLKWE8INe1mKwujadpuBDEsaQJA71ZdlyvBUZ4PX
         8FzBUWbj4DxAP5MQFQ6UCDsHNElgd0Sx+Sz2T15IhpewIaKl3IrK7pb5tJunWIjNETW8
         bWAVBJzQJ69Ic8KtSXYhYCDN4/KhFArPu16igIjTP9+Df5yJW//2Yk24OL8gwNTM+Xl0
         zhQQ==
X-Gm-Message-State: ANoB5pn6xYkgPftGDVWDrxo58kcjeJA0ld5/ujlsKE48qldMSl3+zfzD
        Rc3GSsR8Waua50teyDKsdIIxVQ==
X-Google-Smtp-Source: AA0mqf6kGrnFwP0ILbqgLkEqgAGx1xOiHAjc2NwLHd1DtNWK1zXg29sOVx2QTzB75oBzo1xpQbRFaQ==
X-Received: by 2002:a2e:8e90:0:b0:277:f07:bea with SMTP id z16-20020a2e8e90000000b002770f070beamr7571736ljk.122.1668597930725;
        Wed, 16 Nov 2022 03:25:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b10-20020a2eb90a000000b002770a7e320esm2974296ljb.81.2022.11.16.03.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:25:30 -0800 (PST)
Message-ID: <a0dc2465-ef30-0bc8-5c9a-5b9e54ae13af@linaro.org>
Date:   Wed, 16 Nov 2022 12:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Document the SM8550
 compatible
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/11/2022 11:15, Neil Armstrong wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Document the compatible for SDHCI on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

