Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A35C678D4
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 09:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCGJAu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCGJAs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2023 04:00:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A551CB9
        for <linux-mmc@vger.kernel.org>; Tue,  7 Mar 2023 01:00:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x3so49274430edb.10
        for <linux-mmc@vger.kernel.org>; Tue, 07 Mar 2023 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678179645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0vYkOa0PoBId8dXA1mab0Y6HwS+Gs0X3+n+J6uDR48=;
        b=NV1Nd45GytToNw9aOikhQ9L8GzQvpYRbnNuIYOKVEo7JC+kURcPxlt+GROykAFoDEb
         rIAx6QgPWEtDz6GU31X52VBqcMtUggzwZghOHSgL35MNZMAN3bkgLKgNKtYK6ZK4IWbn
         OqXSO6ccpSvh7OgzhIXHXzLBP+XNPm2VgrzeMYSBFvKrxZPOKgcsK17TO85oYVAx1Hp3
         77jpgIT0laLuTw11bNB25AOLGSDboQx3hpVKR8SoJSb7/uEgEV2R0ITBPo1fmlWKkpzD
         oxRntkUT+4WIpFwmW721KLNCtY3+TPfEqr4MNo96mhC1kbIffLrUD8//jKnLXo9CheGM
         niDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0vYkOa0PoBId8dXA1mab0Y6HwS+Gs0X3+n+J6uDR48=;
        b=Eg1Lovt8MNdHMpunt8J7gd0vF9q3YOn7njMqw16a7gnkTg2zP9z6DZ66sj0By4N0+r
         YtS+y1hw7IkMW37aMAf2zKA85ZOm5Wyn7prEJLrEBlpQjtWZ2NH4BYZwRISj4yCB3BmQ
         QZayBOYcgGqhW9lD1dnBXszgQvjMN4T+IRq6r3OxdxBOeQOzZ0xcX47xzbjVapoWOVc5
         Luk0kzdzMHuStRP2N8v7pejhQFL+MCTrIQ0g55np98jhXCprv7YjWOexXjoN+3GbvWw9
         3DX8Kvuv9BmGnnPFhIc+WVRbtiA+fkI0yjGTXKhaNWtAbQiSdbmv6IMs5wk0bNMvyomn
         +jJg==
X-Gm-Message-State: AO0yUKVDiR29n9fM6CvJrO9tN3D4UIPzfymxIl9t8LtVfw7xnEgm1TSP
        Ambu3dZqMiHmys2O+pXDh7xuXw==
X-Google-Smtp-Source: AK7set92Dtb5JAFq5WWkgalNVpDdJ8rm6dEQZckxT+FZE6VibN618Liy1j3PEiMosIKVpJcCzfe10w==
X-Received: by 2002:a17:906:da82:b0:88f:9f5e:f40 with SMTP id xh2-20020a170906da8200b0088f9f5e0f40mr19949227ejb.68.1678179645007;
        Tue, 07 Mar 2023 01:00:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id v18-20020a17090606d200b008ca37f3eae9sm5730748ejb.131.2023.03.07.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:00:44 -0800 (PST)
Message-ID: <39ba7357-541b-a70e-5793-91bb9e038938@linaro.org>
Date:   Tue, 7 Mar 2023 10:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
References: <20230307024646.10216-1-william.qiu@starfivetech.com>
 <20230307024646.10216-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307024646.10216-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/03/2023 03:46, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). This is not "syscon" subsystem, but rather
starfive.

> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..72c8850602b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml

Filename: starfive,jh7110-syscon.yaml



Best regards,
Krzysztof

