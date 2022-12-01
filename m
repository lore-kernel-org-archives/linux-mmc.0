Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1815C47088
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 05:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiLAF12 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 00:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLAF1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 00:27:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A16A1A2B
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 21:27:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b11so854472pjp.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 21:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n7aER4GNnKOPIgQJItOsO6ISBncgE1PlED3mZiocME=;
        b=UhjF8CJkPLD0B1ZdAUGgDxQGaIzeRNKP+Jm0LpM+ZAw+PSiON8aXtMtbod/ArTex9X
         3SdZuGEQBvpj4WUTQjQ0/8TOTR85A/0CH0WrStdjViUzF8ZzOKvDxPmipUrWPK8QNiI+
         ZjeGje7KT1tHQanfPpD2kTRGNog6kD9VwNlpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n7aER4GNnKOPIgQJItOsO6ISBncgE1PlED3mZiocME=;
        b=SoARTWCvFD/O2BzprLpGBK5wvIOM/XIbN4ShPtrxx5vNB9V9qhiEThbCIOnlz7RbkY
         SGqCLiNi591Uu35z5C4ZemhsI8LryuJFVypNw0w96VW2SUHLJeyocrd10hYKTH2iTX1e
         oT4OKvp5xFbi+2e0bFMtIVCo2llT5WhMVN/7YKcuGs4SiwzOf7FvzotEbbooDmjJ8dba
         7W1xMZGrAQ08Rq1aFcMWz04JBS0suyUzht9namzR5muGWWIVhwqh9aWtzC1Fcjso8ino
         YMdF+6Ls6Muz9fbi+j/71nmyx70v+FNjvsiysO1AGXBsPojB3SEvJCPzT0ZdZrPZJsF6
         kXdA==
X-Gm-Message-State: ANoB5pmJIAgyAqOMkUcJ6BLqEMuLMeJ0MIIi37mIINnNpm1d2BtVHz7h
        1C8MwuFqUOJuwcJSRF1/cE64dg==
X-Google-Smtp-Source: AA0mqf5JKlGRtlQkByNGJ3HDuEu8aNXMgTDZcuUIt3cvTINS9x1HpW35GvQx/iuzVpGmyDwU4gVufA==
X-Received: by 2002:a17:902:8ec3:b0:186:e68a:9aa8 with SMTP id x3-20020a1709028ec300b00186e68a9aa8mr59899069plo.104.1669872442865;
        Wed, 30 Nov 2022 21:27:22 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id q1-20020a6557c1000000b004388ba7e5a9sm1778489pgr.49.2022.11.30.21.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 21:27:22 -0800 (PST)
Message-ID: <523748eb-9d80-c06c-7e35-1084943fe2cf@schmorgal.com>
Date:   Wed, 30 Nov 2022 21:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-7-doug@schmorgal.com>
 <1a8c5b33-172d-b72b-f3c9-81a6c15b5d2d@intel.com>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for
 PXA168 V1 controller
In-Reply-To: <1a8c5b33-172d-b72b-f3c9-81a6c15b5d2d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 11/28/2022 11:29 PM, Adrian Hunter wrote:
> On 28/11/22 04:44, Doug Brown wrote:
>> +
>> +		/* Clock is now stopped, so restart it by sending a dummy CMD0. */
>> +		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
>> +
>> +		dummy_cmd.opcode = MMC_GO_IDLE_STATE;
>> +		dummy_cmd.arg = 0;
>> +		dummy_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
>> +
>> +		mmc_wait_for_cmd(host->mmc, &dummy_cmd, 0);
> 
> This is not what post_req() is for.  Instead could you use SDHCI
> host op ->request_done()?  Also, do you really need to wait for
> the dummy CMD0 - perhaps just write SDHCI_ARGUMENT,
> SDHCI_TRANSFER_MODE, and SDHCI_COMMAND ?

Thanks for the feedback! That makes perfect sense. I do need to know
when the dummy CMD0 finishes so I can restore the pinctrl to default in
the next patch, but I think I can handle that with the irq() host op,
which I need to do anyway so that sdhci_cmd_irq() doesn't get confused
when the CMD0 finishes. I'll give that a shot in the next version of the
series and will also address your other feedback.

Doug
