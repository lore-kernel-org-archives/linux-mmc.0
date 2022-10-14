Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0AC43219
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Oct 2022 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJNQBU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJNQBS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2022 12:01:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512714EC4A
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 09:01:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f22so3939647qto.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkC/MGqITsH4ItvGl9rSsBp9Fg2z5jG2MWsc8Iemckw=;
        b=Fr5ayiTWxddqFsx5wxbR4O7/MzrPceGCim5Bu0T3ZNdH+eeFpd+WW9DBm67SYsd7+4
         mmzc+e7wLneSvWfIVHZWqpE05QB9p7mTRtSZuieAIghZgoGUSYx9rCZNwdru2jltw57w
         Nby7nk1gjpE8AysVdtUOEa/qs+RkzVNLiPaSho4yb5EM8nchwkQ1R9G+i6V/hS28CgvG
         OEL5gNgAC4FOp2g5q6KxoYvJdkJt7nVsbdPffTS0ECrbYePn976vDxCQLh6siJXxeNdV
         TkuG9It2RIPs/biTcebqBC2RgsdMmQvfwHMexQ+dssKtDEgA13di+KqS03w95zY+m8wa
         SAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkC/MGqITsH4ItvGl9rSsBp9Fg2z5jG2MWsc8Iemckw=;
        b=kE7XYhM7JONvdnvzEes+FYpuUzqE5UuJXw2C1a1I0qAS+KzvhnC5oKWFkd50Ourmui
         cZdsN3CHFzxSres97hq+K9C/yJrUQvkX5bvXalK5dpwgAahDyPSvQBHGsPgip1Q+Mj5R
         vpoBdKGUr0kgYnmt5bDsySsVFlkhi9hr79OEWmVPXlf0V5QLTP1MS1fzA/v5seON7DuV
         T4lzDdG0QX1BUUSVSF0TiHN8t/zNjLnmhLb2j3gsKhIjboPWrXtLMkIvys2n+113BErj
         6FpCo+pAhQg6rWRGzKt72aYxy645ZjN9cjLOvW6w6+yILT6N/G7tjLQESObubq1jxjgV
         2/Pg==
X-Gm-Message-State: ACrzQf276Ywn/vrqxPgkuqJaIFT1wnx6Rsp5l181VxKG6UUMqoZ0vAEH
        b5Nbd83SyWRQDhJ7rnfSb8MFLw==
X-Google-Smtp-Source: AMsMyM7CLKUeBtX1XegI5DUhv6wTLsUYKd53nK0+892VZERVqDOsE6ABLVGZyQ0DrZ6RmVBxMvoc3Q==
X-Received: by 2002:ac8:5f51:0:b0:35d:1a4c:9eaa with SMTP id y17-20020ac85f51000000b0035d1a4c9eaamr4685049qta.198.1665763272437;
        Fri, 14 Oct 2022 09:01:12 -0700 (PDT)
Received: from [192.168.48.77] ([172.58.235.135])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a441100b006ce813bb306sm3095238qkp.125.2022.10.14.09.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:01:11 -0700 (PDT)
Message-ID: <cc7289ac-b75a-62e3-4b58-fc018715c068@linaro.org>
Date:   Fri, 14 Oct 2022 12:01:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: arm,pl18x: Document
 interrupt-names is ignored
To:     Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221013221242.218808-1-marex@denx.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013221242.218808-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/2022 18:12, Marek Vasut wrote:
> Due to inconsistency of existing DTs regarding the content of this IP
> interrupt-names DT property, document this such that interrupt-names
> is not used by this IP bindings.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: Add deprecated:false to interrupts: description
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1e69a5a42439b..1c96da04f0e53 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -95,7 +95,9 @@ properties:
>        PIO (polled I/O) interrupt and occurs when the FIFO needs to be
>        emptied as part of a bulk read from the card. Some variants have these
>        two interrupts wired into the same line (logic OR) and in that case
> -      only one interrupt may be provided.
> +      only one interrupt may be provided. The interrupt-names property is
> +      not used due to inconsistency of existing DTs regarding its content.
> +    deprecated: false

Why do you add deprecated false? All properties are not deprecated by
default. Did any other referenced schema make it deprecated?


Best regards,
Krzysztof

