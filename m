Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B53DC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Nov 2022 09:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiKNJAs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiKNJAd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2022 04:00:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1441CB11
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 01:00:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so1046877lfc.8
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSB6TW51XM2yvmI8chRE/GRF+Jj8yKiNsELalSRirxc=;
        b=sfsu+KoYe6/zZLJaWJ7gyMm2qpwZjyJUWiGTBNqyez7nf3ybJZ2AD/8kXVC4DAy2bs
         EDeIqXfzEb65abG7P+/KkPfndbrgrDh48zIMqShZu242Z3IOW+ySq2/dxxn53cs9/0y8
         W19FHMtfA5OgIeOICx6RsS9Pkq9GatkyFC3n8WvsDdw8CtVoCiZG1cNa9hgTx0yJGK/J
         jNpFhqpFtQAh2fOdUtBZ26VM13zFbBCtOB88g6wMxKPCaK/FyifjSSAHWmR9be9KTfRP
         i0voL+wqb+z1SDjp33lba3aLleeZPmXJoy48LMaLt9wXxI3RGDQMFGr6olRAIF+NZTWx
         aEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSB6TW51XM2yvmI8chRE/GRF+Jj8yKiNsELalSRirxc=;
        b=J7O1gesERPWEh/WdZhwfJT2VFeTvMzNiJ9uSWC1HY6wuJyhg5gfpG7YQB2BP10tvzf
         TXQog/16l3+yTpRBeZBpmdL/BBdpvsQkvTb5ruuo2XuSokZ7aqDzyoMUD/v9tONNRAYn
         vxK+ZA1o0cu25VUJSYygDXTYcj0A5zr1u3M1A7LWa07lWHiioOnLv4FRxWvhCBVCGRYr
         jqUj16I6QBBPKXi09a85P/MH/zdkHdK86fjUfgmQBbjiNMaHZmH6eh3/4pkhoHCu42lG
         qR/nUOHM6u0hEOQE/y0oU1EvYf4Rbe8rHpvNO2elIhY3aE1O4CFqvw/sjubDGyQztVx+
         co3Q==
X-Gm-Message-State: ANoB5plDja77VEDORx++/7Jpb7LvCXw/IFPFTrOzFh+Wg2L6AUO2RubN
        lJbqfn2kMMmw+KxjQs5Q3gy1eg==
X-Google-Smtp-Source: AA0mqf4amsE2iSGKFTVIso6JQHxz9emYnEPwgoWzceVcXofHyqdeIEb56vf8UZ90yTT2opK6yaAxmw==
X-Received: by 2002:ac2:4db6:0:b0:4a2:2c4b:8138 with SMTP id h22-20020ac24db6000000b004a22c4b8138mr3683454lfe.14.1668416429100;
        Mon, 14 Nov 2022 01:00:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 24-20020ac24838000000b004a2550db9ddsm1729475lft.245.2022.11.14.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:00:28 -0800 (PST)
Message-ID: <cf9e261b-dbf8-bce0-ecc8-c2aec659aa18@linaro.org>
Date:   Mon, 14 Nov 2022 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/6] dt-bindings: sdhci-fujitsu: Add compatible string
 for F_SDH30_E51
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
 <20221111081033.3813-4-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111081033.3813-4-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/11/2022 09:10, Kunihiko Hayashi wrote:
> Add a compatible string for F_SDH30_E51 IP to the documentation.
> Since this IP is transferred to Socionext, so append it as vendor name.
> 
> Cc: devicetree@vger.kernel.org

No need to keep list-cc in commit log. If you really need such, keep
them under '---'.

> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

