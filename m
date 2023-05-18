Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6440AC7EE22
	for <linux-mmc@archiver.kernel.org>; Thu, 18 May 2023 09:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjERJtB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 May 2023 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjERJtA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2023 05:49:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2C10E9
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 02:48:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso2249444e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2023 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684403337; x=1686995337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GnXEaoNLwvt/m9XpCMVWbr8cKI+gCa0zAel8TKE3gk=;
        b=zHVieKgJXSOVBnyFh9W/eerTNjThyX64e1V7drkdNjoyMATIznYS26qilMUR+55LCu
         sY74p+3d5lorxyJ2NJvT1fGC64nlXxzdR4zIwMj+1wbFGqueg+A5eVlChMWd2K23Lq29
         NxF6IolN7lU2s6YT7JnVXFoIuXU901m2ah1S1nL5T6va5QKxrWnQGrEDUq060L6Iod12
         tU9YYBV+cur5WpIE2DFlvZdcd8W9HnTwHA056AgoVuOTpwgAU36H9NgreRsabEqLTU4P
         xIPXlW6qlOpX8s+JutTZSqxWC4LEUD0SxNg1clHhZKuOT7ZFnZnoLmJsvcFymyHkj/Mk
         5MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403337; x=1686995337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GnXEaoNLwvt/m9XpCMVWbr8cKI+gCa0zAel8TKE3gk=;
        b=RIYj6lh6W9jHBGcEfBtAYziV8AsP/U58nvsJIZk7ljoJi2/1TYIE54K3LYzLICTtfH
         K+4AetXu7n/Vgzbisl7LYsNKLWf1uj6RTmIFEWQJOwM8NDfkyYTE+zrKdHRkq6IHaA2Q
         kUcw1DTkxRyhfveaf+FgHIERvxKPunvej+mNOn6auHapS4znvCgYXzY0tA0QNO/tp2RQ
         mNSj01qwgi6/UKAk+JJYB9nWHkEhzEb7tlShHNBDzWbdLUYq0JQuYO5LvFkyVO3SjWI3
         RkEfTMEn1xI9+aEiH2HBe//imN5OQc/AgaBO9eFLt2yXpWOwYUNBPOZEgd7Kcds6408R
         mrJg==
X-Gm-Message-State: AC+VfDwQl8IKuEO+QJ9Mrtq4/9Jq1YkaqFl1ECHqOXvr7bsdT+FRALpz
        wsjtQLVw+pLAOG/Mb7/NxBPFjjA9yOHbwxD5Izg=
X-Google-Smtp-Source: ACHHUZ5YnvtT2zZVHIWpogOnglFbkJr/gASlvlkb6WiG6tTP6XhEF7LQQz/4XpZ4BBnsC7mdCqwieQ==
X-Received: by 2002:ac2:550f:0:b0:4f3:8244:95e2 with SMTP id j15-20020ac2550f000000b004f3824495e2mr1159314lfk.50.1684403337377;
        Thu, 18 May 2023 02:48:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512020f00b004ecad67a925sm196303lfo.66.2023.05.18.02.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:48:56 -0700 (PDT)
Message-ID: <2875f7ef-c43e-74f6-12b9-342bb2cfbaf8@linaro.org>
Date:   Thu, 18 May 2023 11:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 18.05.2023 11:39, Stephan Gerhold wrote:
> While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
> be properly functional. It is not immediately obvious because SDHCI is
> usually used with IOMMU bypassed on this SoC, and all physical memory
> has 32-bit addresses. But when trying to enable the IOMMU it quickly
> fails with an error such as the following:
> 
>   arm-smmu 1e00000.iommu: Unhandled context fault:
>     fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
>   mmc1: ADMA error: 0x02000000
>   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
>   mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
>   mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>   mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
>   mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>   mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
>   mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
>   mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
>   mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
>   mmc1: sdhci: Host ctl2: 0x00000008
>   mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
>   mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
>   mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
>   mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
>   mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
>   mmc1: sdhci: ============================================
>   mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
>   mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03
> 
> Looking closely it's obvious that only the 32-bit part of the address
> (0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
> lost somewhere. This might not be a limitation of the SDHCI itself but
> perhaps the bus/interconnect it is connected to, or even the connection
> to the SMMU.
> 
> Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
> using 64-bit addresses.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Would using 64bit address translation not require you to use (dma-)ranges
with a greater-than-default size, like we do on newer platforms? Did you
test that by chance?

Konrad
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..1877d583fe8c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2479,6 +2479,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
>  
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
> +
> +	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
> +		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
>  }
>  
>  static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> 
> ---
> base-commit: d4ebc9419afbac330e9ec0d2936108742aa4d97a
> change-id: 20230518-msm8916-64bit-f5bcf6af7679
> 
> Best regards,
