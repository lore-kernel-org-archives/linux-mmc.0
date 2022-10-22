Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF56FC04A95
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Oct 2022 16:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJVQGs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Oct 2022 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJVQGr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 12:06:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE113CCF
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 09:06:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so3403231qto.10
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzT+VEmkUStYx/oFKUyBVeLL6CJC5Ebv5tGgGJ3EThk=;
        b=Rd1hH2t7awphQ+KCcp28rqZhH0W/+YoolhPWBzFlzaVzem1NtFymXj9IbmcfKrtxOE
         mwluJy+ONLIEOOcEUVz1AsVeeUW81r2nLNrSZo2PTZKuA70eC6DU7ZtWFVCvQaN0n2EJ
         XNawpYjH23MoC/f/ID18S7MILGG2aRc3N+Ln0ZdChio7g1VfWZV3i1493pydGFb7Ut91
         j76UklR5tmvzbORApFcZj2pfhhCWBoSlDrcYkHj8kmJAjm5MuyA/IS0CHVaU15KekWV5
         EM87cLIapgiTHD4InSBhCrine1p64V7/4jWqpAGOwpoj3u7sGi5KiQ+dnnR1DgL4KGVp
         abgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzT+VEmkUStYx/oFKUyBVeLL6CJC5Ebv5tGgGJ3EThk=;
        b=LLv62ZjUwtJTLClQyrzBB4L70n+yW8W7R3C0PiThxwvcttprgZ8DTtvuP31EPIDVb/
         yhTBUngOpPHipyRmI8LbitS8ybm5Dw4QchNOoDrH7MIyuqh5DZCWMNSx36CIRNQ0Buwm
         udASv7LhBapddImVHchRtjyq2INgepVqhZGp4HG1mZtH+ycOcqXZ0or9wStLOzF3Ep4v
         IzBueqXNfnk9KU2jPV9PXhrAQBdQbfcQNK2A8TqZjOPvLDJQ2w1GM3xY/s/SUqLUTbgR
         KyWnY4w/Utk3zV0VIPHoh6NT9icDoncGezDG1aFVM1k0SL8zwn6SeY7SjMipBwjJeLMO
         /FRw==
X-Gm-Message-State: ACrzQf3N3Ip+CerGMf5ASS5HVenA1izUTIiQ926CbCJd8o7qf0ZYLdWs
        IiDwAEAplBem1g7Ffg/GSqR2grt5jouEAA==
X-Google-Smtp-Source: AMsMyM4ZO0osqdPxtj3efWReeGdbuhf5GKNX407YtHct5K3PumdbLfs8ZZUzCHhQOMpPIkHQE1x2jg==
X-Received: by 2002:ac8:5b44:0:b0:39c:d6ad:cce6 with SMTP id n4-20020ac85b44000000b0039cd6adcce6mr20939846qtw.113.1666454803298;
        Sat, 22 Oct 2022 09:06:43 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id bm34-20020a05620a19a200b006ce1bfbd603sm11410372qkb.124.2022.10.22.09.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:06:42 -0700 (PDT)
Message-ID: <df256d16-e0c6-4e9a-9579-f7d9d1436670@linaro.org>
Date:   Sat, 22 Oct 2022 12:06:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset support
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221021171654.87071-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021171654.87071-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/10/2022 13:16, Sebastian Reichel wrote:
> Properly describe reset related properties in the binding.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 71f8e726d641..162c1a4abf3c 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -45,6 +45,18 @@ properties:
>        - const: block
>        - const: timer
>  
> +  resets:
> +    minItems: 5

No need for minItems, drop.

> +    maxItems: 5
> +
> +  reset-names:
> +    items:
> +      - const: core
> +      - const: bus
> +      - const: axi
> +      - const: block
> +      - const: timer
> +

The reset names have exactly the same names as clocks. Are these
responsible for some blocks on the device? Seems so... but I want to be
sure it wasn't copy-paste :)

Best regards,
Krzysztof

