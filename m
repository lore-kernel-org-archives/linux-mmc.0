Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF5C54EED
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 11:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjAYLTA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Jan 2023 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjAYLS0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2023 06:18:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3958999
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 03:17:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h12so12691426wrv.10
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 03:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3c02ZBU/h+VaIjVTCIp0P42TtNnqSC3O7QS/lDp4nw=;
        b=FhZ+VBTOrfqHJrMFjNCmxHuAEEsyY7W/iCoSZN6RCzq6pOVzwh6DzLPNjzFHc7NCfn
         5/b1zSXn4p3pzxCcmfDJ6BjUXKCl0TdNNK4hU9JiJHhi4AZYcpgdJENuHbAG3Pq5X6Ml
         YbeMHH/4X2P0WSCjUSd1JZmBILwkol1xiq9cNbp1wVGsrU9WCmP0wE/86w097Y43/GAD
         6nt+5nZWXCLWBvjrcvkDzukmVH/HLSYwKe3k81YUIZLDyEMcY94s+15IQ7MEszn0+u2X
         9ORE6wjmxjP7CwhhTcJW3M+edG+ZCdi/5AVpENvTPbgxKdnXI3GH7oREMZlDKWq5CQD5
         RR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3c02ZBU/h+VaIjVTCIp0P42TtNnqSC3O7QS/lDp4nw=;
        b=BFMLSUSorF+VKeT4dssgSz1fjXbQrY7Zwbr5C+/ciPqmGVGuYSwHPxjln4V8ZHIjwi
         wHzxwqAXtphrh28xwyl3QIyqaItBBS+rB+UX6Tns0x+DYg+KXtngzotsWKTFLhLu1pAx
         uF214TrJZtG7i11rhIv33J/pOvM+FBJ4uqa3I4lCtFNZCoSFTncEop/LD0iDc9eJhDfo
         PtK8DiFr6n6JUhh0uHAqmNroS/bjSFxwN3JLbLKYi4pOoXLgs0mXxpA1aH47XQQmDRrs
         rjkIsGzJIPgq6uw62vdUoLt8zZUkoHtBlhJVEteMfVOw6zpx7hJDkJW2Hcv+NS8U9Yi8
         AQzg==
X-Gm-Message-State: AFqh2kr53YCsvpCKm7VuJIVgAywKvjzUnMB4EsszoIAYvuCnfg8sJNne
        PFB9hN7Gxg90nNv69Ll1i3s06g==
X-Google-Smtp-Source: AMrXdXsmfqnIoPGyLHFJFQV2BDh2/vFfd/d9dybfdByvyno2aAG0tGglLwkNmp9AsMlvxFUasIabnQ==
X-Received: by 2002:a5d:6681:0:b0:298:4baf:ac8a with SMTP id l1-20020a5d6681000000b002984bafac8amr27915259wru.44.1674645434310;
        Wed, 25 Jan 2023 03:17:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020adfa4c1000000b002bfbf4c3f9fsm226488wrb.17.2023.01.25.03.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:17:13 -0800 (PST)
Message-ID: <248d6bfb-404f-e2d0-33d1-502c064116e5@linaro.org>
Date:   Wed, 25 Jan 2023 12:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 08/10] dt-bindings: mmc: sdhci-msm: add IPQ5332 compatible
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-9-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125104520.89684-9-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> The IPQ5332 supports eMMC with an SDHCI controller. Add the appropriate
> compatible to the documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

