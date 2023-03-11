Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F54C6FD1C
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 15:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCKPxo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 10:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCKPxP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 10:53:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C14C112A4C
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:51:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ek18so1284583edb.6
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678549860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOPcjhDYKPCO/Zmz2tGgC7qcp0wJ1W217UIkJ4Y9I8g=;
        b=exLH0pXHR2Hk2k1GxkMT8NMsFHRUn8Gh4Hi84g2CApUpajQKPndJt5y+CGjzcwO4DV
         NjVjIYSvcYVSJYBuEH5VwTgcBhO6CTHG9zqBf3Qh/eZpM7k2AmEcbmLed4hsDVHqXKzX
         zhpg09XUjiwP8IbNlQRuoUPUbo1DO685I0vPic9/1QSfnOzrpPtNPjYrnNsNW2nyAaSW
         YM1pbQYnxdtaSiUjt0jH+qrgS6V5+618+VCfDMm/QFx9ldVDG970XSC5e0Vm21WzjDkC
         zvX+tOA9MVp/TiOHI60XMFU5DX17sePwJf2kjUvi0xAy9pKzY9ERSkn6ycS/h0djU9ZC
         zTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678549860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOPcjhDYKPCO/Zmz2tGgC7qcp0wJ1W217UIkJ4Y9I8g=;
        b=hGJ5RxvvaR30npn6mHAUP1J20GfsT+bivhO0bJgBRc/8HtzBBh7QWqbwR68iEMUbnz
         e+GUhOAiRzeNvLchddSSUvlIan4VCFJDscZCgaIRA/0KUlVzRvDl5g8I97Xx8M0nBnxv
         WBxOUzEIpg1NfdIUvMdR44IJ0myIDOrgyJQvzYo6dvv4mHvsIrfZ81WBo4VjbxCeovtH
         ReMNEA9PmHnC3BOH0u/vD24ntTUcEkctMY/2sdQMnSf1GAZdhWeOOB4N+DbsixXCYIRY
         ZPF49AhJ9Y1vNk+GqX39pj1ZE0C3JI6/GimaybXcPaaNPA20EXz2bh/uOJTIOL+T8Rq6
         Hv3A==
X-Gm-Message-State: AO0yUKUPEKW2FZFg4JptjMr0LEVNo8tduwLVFdWgD3w/A2nzwPi6ZLPy
        h9Oy00tnOVgPLpy1tY3+2U6/zlHgJOJOkxWmNdA=
X-Google-Smtp-Source: AK7set/jKFNKU2NfkbcpoS9MGUQVvnrWP9c19CwbXw4TjLsty5YWBFzICJsaDHdJ1KheJ00mIggWjg==
X-Received: by 2002:a17:906:2843:b0:8b1:15ab:f4cd with SMTP id s3-20020a170906284300b008b115abf4cdmr26060805ejc.53.1678549860208;
        Sat, 11 Mar 2023 07:51:00 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id n7-20020a17090695c700b008e493b7bb61sm1214587ejy.153.2023.03.11.07.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 07:50:59 -0800 (PST)
Message-ID: <c13993bc-9d12-f20e-de27-fa0b8a58ed33@linaro.org>
Date:   Sat, 11 Mar 2023 16:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1678548256.0817535-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678548256.0817535-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/2023 16:22, Sergey Lisov wrote:

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Missing commit msg, which should answer why you are doing this and give
more background.

> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> index 8dfad89c7..2bc5ac528 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> @@ -57,6 +57,12 @@ properties:
>        force fifo watermark setting accordingly.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  fifo-access-32bit:

Missing type boolean.

> +    description:
> +      Specifies that this device requires accesses to its 64-bit registers
> +      to be done as pairs of 32-bit accesses, even on architectures where
> +      readq is available.

And why the device would require this? If it has 64-bit registers in the
first place, they can be accessed in 64-bit. Otherwise these are not
64-bit registers, but just lower/upper 32-bit, right?

Also, why this cannot be implied from compatible? Why different boards
with same SoC should have different FIFO access?



Best regards,
Krzysztof

