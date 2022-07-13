Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F7C43334
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiGMHqI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiGMHqG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 03:46:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C2E5DD8
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 00:46:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d12so17709575lfq.12
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xdsL4uRj8N2AqYiew2VoS8gd5og/zBLael5s9bKHgiU=;
        b=nlsCHVZBTVrHJcbQrLQPeenxcXMIyfBkycxLEYS3E+LrQH8Vlf+vWGZ4gDDQE0gs82
         IwxPV+F6SsTRRhbK3+gVWIwOXFowBI7gtPpzH40ewW48y9gw6PEILCWsNZQIPUD23Vx7
         r3IIvU5yiuIH1NMcnziiq68cpWgSnf6nxwNd75J1jjcOlzGqyARD+DzNTcPwhYBQ47xJ
         L+0VGjY6BEJaVCYukceBTeJf5mZ5aj6MJlqunUQLAKa1wjPLPbGGEXG3+NFpKxESsjgw
         WIZcpKQH3pJzSskTsMnfF7N8TtVZwbooI9xPxQxze1Qve4JR1FBsTdXMlP2srBWizE3y
         6dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xdsL4uRj8N2AqYiew2VoS8gd5og/zBLael5s9bKHgiU=;
        b=os9yeGkebdWz1WBGZdY3pgGiIZj6JXGGLpyX3q94vWGu3D0AE8XKVyJA/k2I7tcqxU
         quI3AaTt8VHUPmjuvK80euGjPg8DWM8QU4mj0FmPEITyVnR7W4WaC2ReAMIdICHY6d/R
         OgCGhjO2O420S8PIhuCysIyl+Mvqxee5j4G7L1RzGD1bqbZt9nXq1aGoMZXaKXJxdBVw
         hgnG7Jszpejph7Psd/Jmbt6rM1W7dugWUg0HtojQ1WECdecVUOqEoETm8gW+Yr81rYdp
         QiPXG5koLCNnOr2PcR/ehTp4y0UfxxRkxAo1i7OZQxqgvE3EnNZ1Yu0vmKTEACuglYLv
         rTCw==
X-Gm-Message-State: AJIora+29Xn5s1NOfxanOryBf5O6GBK8FiO+Dg9K5UR4BoQNZKxyUE4p
        I4Nud0Ve9YKDt1b7SUkOVs6DRQ==
X-Google-Smtp-Source: AGRyM1t/czwdLZAzX3D/UKHgSfjFx4reEMI+EE3DsJj2uYC4i992h+SkFH62u/yQnGzFHDMcQ/kxDA==
X-Received: by 2002:a19:6449:0:b0:47f:86b3:f87b with SMTP id b9-20020a196449000000b0047f86b3f87bmr1165219lfj.644.1657698360831;
        Wed, 13 Jul 2022 00:46:00 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05651c169a00b002557c48cc4csm2842992ljb.95.2022.07.13.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:46:00 -0700 (PDT)
Message-ID: <0405bea5-eef4-6e4a-b78c-b296304eb522@linaro.org>
Date:   Wed, 13 Jul 2022 09:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Fix potential NULL pointer error in sdhci_calc_sw_timeout
Content-Language: en-US
To:     Chanwoo Lee <cw9316.lee@samsung.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
References: <CGME20220708070739epcas1p1332ce8a480181e094082b20da290f8fc@epcas1p1.samsung.com>
 <20220708070353.32624-1-cw9316.lee@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220708070353.32624-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/07/2022 09:03, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>

Use subsystem prefix in the subject. git log --oneline --

> 
> In sdhci_cqe_enable(), a NULL value is used as an argument.
> 
> * sdhci_set_timeout(host, NULL);
>  -> __sdhci_set_timeout(host, cmd);
>     -> sdhci_calc_sw_timeout(host,cmd)
> 
> The current code doesn't have any problems with the 'too_big' variable.
> -------------------------------------------------------------------------
> void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> {
>         bool too_big = false;
>         u8 count = sdhci_calc_timeout(host, cmd, &too_big);
> 
>         if (too_big &&
>             host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
>                 sdhci_calc_sw_timeout(host, cmd);
> }
> ------------------------------------------------------------------------
> 
> However, if the code related to the 'too_big' variable changes
> a null value may be used in the sdhci_calc_sw_timeout function.

I don't get this part. Did you mean, that if someone changes the source
code, there will be null pointer? Then the subject is not accurate.
"Potential NULL ptr" means that it can happen now, in some conditions.
From what you are saying, it cannot happen, right?

Best regards,
Krzysztof
