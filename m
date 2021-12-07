Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268AC4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Dec 2021 09:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhLGJpN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:45:13 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60518
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234157AbhLGJpH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2021 04:45:07 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6C353F1B7
        for <linux-mmc@vger.kernel.org>; Tue,  7 Dec 2021 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638870095;
        bh=qLCDTAsKhjfBLk9Ve3yIdzH9fR1aqVaxiH+88h3GaWI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Irx9o6VQpcEcNGsRfw34l9OMCN2X9fvfJQcMPFaXvndcKQCNFO+qO2Iu4pKpVy52W
         gFA4z+CS+r6kctf9M7Usw4LfCRVFtjb9AljREAfSjWmmaCE3Ja97yTa+0NhwssADrU
         YDAjqBA85ZScBLQ7GivNPZpwNxvRiyISXKYjrlGmOfwI6Bx279Xs5LS5xmd6tsnTTk
         8NO1CyljoWoRe4RO9cEG/fyNVaPCgtZvpQnAh5TwxSM4sZH67l5xs0+7wWIj6CC/7h
         kOzYXZPGs821FtpxGTSMtPIAUCXMmla8oCWU8daE42h/vx0g+5x45QA4xVLG2OyB66
         Qmy4exgGgWMpg==
Received: by mail-lf1-f72.google.com with SMTP id j9-20020a05651231c900b004037efe9fddso5092246lfe.18
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2021 01:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLCDTAsKhjfBLk9Ve3yIdzH9fR1aqVaxiH+88h3GaWI=;
        b=PdAaJpvooDUPFqib3B7Oti3YnRschcfyAVoWplSoftNfH5xup9/TgrqB8Di/tSFOX9
         jnLFdoRuxcy9EI8Sp0CAS2KFhBLNTJoCl7Cnv7BTrSigulzReM9QNmM6jk59X80VzH67
         XR0Dvf7uUi2NS5xPKFi2NA2WkfG86A13o3RllRFfH9Q0+5U+ZMnDoPnzB8YXjUvmrqV3
         Ig/UWZFNnmbIk/HSYn7SEwKRZ3iL4lE2pVU8N0k0PfERCsZoI6gR083qoRiSnX+uY5gc
         kzmD2V37KTdTOZ7+//hPLoh4AzEEJ+aF+ymvUHXy6XoXRBMzh1bep/1JRDbMuxNRUMec
         wzvQ==
X-Gm-Message-State: AOAM532lfxBdTeL/KCtNiyeKj9fNne5/50IzAGIZnbkkiN7sRbRbae9h
        3UR5sIauAJAI34Nvxo9n3IkGmOLL0ge4OvZoKB0BGJIn/19w97IoZtsbs1Luu3XSV3FNkHsxToH
        VfUb9Rk3hEA2EPXnUlj0oaU4m8afQP9xe3XKSyQ==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr41747246ljp.280.1638870095359;
        Tue, 07 Dec 2021 01:41:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTIIHv+OTH72uTn3pxiMOlzQZ3JgtLIY2GTKOhXzdm0Y5VXk7QWDAiHXPLov1dDK7gUn1uEA==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr41747234ljp.280.1638870095183;
        Tue, 07 Dec 2021 01:41:35 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f14sm1790586lfv.180.2021.12.07.01.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:41:34 -0800 (PST)
Message-ID: <59812744-9335-62de-11a3-8d321d66f335@canonical.com>
Date:   Tue, 7 Dec 2021 10:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Add quirk for extended data read
 timeout
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211206142929.26729-1-marten.lindahl@axis.com>
 <20211206142929.26729-4-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206142929.26729-4-marten.lindahl@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/12/2021 15:29, Mårten Lindahl wrote:
> Current dw_mci driver supports a TMOUT register which consists of a 24
> bit field (TMOUT[31:8]) for the DATA_TIMEOUT. The maximum value of this
> field is 0xFFFFFF, which with a 200MHz clock will give a full DRTO of:
> 
> 0xFFFFFF / 200000000 => ~84 ms
> 
> However, the ARTPEC-8 SoC DWMMC IP version has a TMOUT register with an
> extended DATA_TIMEOUT field, which supports longer timers for the DRTO.
> In this version the DATA_TIMEOUT field is split into two, which with the
> same 200MHz clock as above will allow a maximum timeout of:
> 
> ((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms
> 
> Add a quirk to support this. The quirk is enabled for ARTPEC-8 SoCs.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Removed unnecessary comment
>  - Change 1<<0 to BIT(0)
> 
>  drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
>  drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h        |  6 ++++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
