Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3188C77B75
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 10:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEFK7L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjEFK7L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 06:59:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E459E2
        for <linux-mmc@vger.kernel.org>; Sat,  6 May 2023 03:59:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so4132103a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 06 May 2023 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683370748; x=1685962748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW2+xJRmgdZ27ZcNr9TxMjP3bjf3obnjeQgSvhehL34=;
        b=ZpalZUe+XDuhte7Qv99Tcs5pg/4uvbJYtbOJq2PmRGOEVNt9kwkHXlkGORrKzST9dO
         j1F/MvxjocP4l7/Iz/LkG3BwRVDqeJ8zvnZUih6vYtNFkZI4qcfwEWQd4qy7u5K6oc3h
         prhib9n75xxmRA+7c0wLK03PjYM5esATCosz2grt2Iw0FdtNFY3Mnt3H+Lbb0cDyipNr
         g5WZcMgORpa6LHKatnlrqZO/Q6nTqrDjTUFZDRPZHDxEmvsuyGIZazW4yFQ1jEucoHvD
         HRsUJWV3Lag9vln46tYyfhv1K9lfnUOp5ERFbiPCZ343o2Pe3JqGIc62oZ0LvY8aFz4J
         ZTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683370748; x=1685962748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW2+xJRmgdZ27ZcNr9TxMjP3bjf3obnjeQgSvhehL34=;
        b=Y+9AaJJnyRPtScSnCSIeTfha52nhZHc7uNNENaPUXjsr+dHX63jGjJY4gqImChR4/1
         OY5tqJkwpbheNzcW1jr62YaLyKAd+LnmEakV5nonzuaUhf1RDx7chNNZ62al/t0w2iAV
         WxROc5DD1aG4NN0pF/c3+7PO5ATPBdlbobkNnGD7rrjWwGwmY7oMZpnPaWpT2cSgG5yj
         d2iwZHeVIanqgpVAExt7dML9NL9/Zp06rYtQylmM42YkLu2BHzPpcpXgiqEhS9RCGyOj
         PoiPvPdyjB3Sg+ys2yo+g7CcSI6WMVJhLy83wyo3rm/zYrHy8xlEJvu+N4pMF0dN4nCj
         OMpw==
X-Gm-Message-State: AC+VfDyBgisLPqMy5Gvuf5t00oswyEfbBOYA20XuiEQcANMqayzZD6x+
        k8Y0CuMXL84hZMCehwR4Bi0ZLA==
X-Google-Smtp-Source: ACHHUZ7zxK0jUQk4P0Am2rVH4Uu+S39TYN8L+DrKj+fLMnpvW7dy7eMWBZgIriGBInj1X5k0EWBCqA==
X-Received: by 2002:a17:907:97c8:b0:966:17b2:5b0b with SMTP id js8-20020a17090797c800b0096617b25b0bmr1036600ejc.49.1683370747792;
        Sat, 06 May 2023 03:59:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id z18-20020a170906715200b0094ea3a32694sm2138449ejj.190.2023.05.06.03.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:59:07 -0700 (PDT)
Message-ID: <d0329227-b579-5557-b449-7961ec0a1463@linaro.org>
Date:   Sat, 6 May 2023 12:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Content-Language: en-US
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        cniedermaier@dh-electronics.com, devicetree@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-4-haibo.chen@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506074037.522961-4-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/05/2023 09:40, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Driver do not use this property, so remove it here.

You still need to expand the commit msg and justify why this property is
being removed. "Driver" is vague, as it can be BSD driver which also
might use this binding. Instead describe why this property should be
removed, so we can understand also ABI implications.

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> ---
> v2:
> -fix dt-binding-check issue, also remove "fsl,wp-controller" in examples.
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ------
>  1 file changed, 6 deletions(-)

Best regards,
Krzysztof

