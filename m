Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F85C05027
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 20:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBQUJj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQUJi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 15:09:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02DD5F255
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 12:09:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w13so2025803wrl.13
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knqzr+Iwk1EvvCLnjdCBkl7DP8eCynrrFxDniRkr/OE=;
        b=fYv6F45ngnNrqVyVhLFtQio5yq+2u8/+ID8NolX2lT+9CO5ZkknKeylfzaRvKzFC4d
         mkXxI7oZ9cURKJBtBbEMTCNeMfS+MPap/ZAFWPrlNy8EYzCeH0aFCyatOVI6Hib/zct0
         0SqV3emfKT5CZ7plHuCSxkMyqUFTNOLu+bPV4O9M59PkGEx86lNL6udSGdVaLIYd92Ux
         F4aPi6zJrPjhj2ozPT+ZVDM3snCS4txx7Vw0Ez/5ACMNU3InLnNrKg5B3pxjLD0Ncbla
         8jLtuQ+1xRlqUznxgLK0+p7QM4TeA/8fqD66KSvYWwENXVXGJCu3X9XTm5nj2/N7y+p4
         WWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knqzr+Iwk1EvvCLnjdCBkl7DP8eCynrrFxDniRkr/OE=;
        b=4OpvDQ4iNOF9yxhxN7z8yIvqP5rdQNJisz9Fr/vXsmx8p5teEArT+ruVL+syrUcNz5
         XFsOJfE8GfV6GJDMgnzIyazC+4SFT+JXabYopMD/SMMqu3JHZLBQCUroAeUbIhukv4uu
         HlrIwfCVT1Yyz3BLZmPJbfCDrd8qMn6Au5Doibd2dwdumB6N/EAeR16SOZxCCMEsUSbe
         j4jtG8C1+eaSbjCKrDzngRQ2Apm2m/BcIQv/trGfD8ryQzlYkgstU+nyDdrbLphhv9/E
         y0PW2psOj7w3X4SpIXKqSaMD12hRAx65CoTRKSt4oDWwTLSnMVeMHZT3iPKNz0SzNL2C
         yfGg==
X-Gm-Message-State: AO0yUKWgGR3Govyxo45bC5HFJ44Y+2iqMHONbVSAGD7SXN4hao7MIT7+
        PA5G3AqfDHQYAg3FgWNJy9IGN12SjRU=
X-Google-Smtp-Source: AK7set/EvP4FUIjGx4wCeLZwhv1zarnr483B75rH7dVubhMR7d04o6YNoGlJZ+C7VNCnKHpyI3ktsw==
X-Received: by 2002:a5d:4dc7:0:b0:2c5:5882:1e6f with SMTP id f7-20020a5d4dc7000000b002c558821e6fmr889399wru.64.1676664574962;
        Fri, 17 Feb 2023 12:09:34 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0ef:9000:8c00:bd1b:3cbc:dd6? ([2a01:c23:c0ef:9000:8c00:bd1b:3cbc:dd6])
        by smtp.googlemail.com with ESMTPSA id g6-20020adfe406000000b002c5a07e940csm3732604wrm.33.2023.02.17.12.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:09:34 -0800 (PST)
Message-ID: <0725e5eb-43fd-65a7-27e8-84bbfe31c798@gmail.com>
Date:   Fri, 17 Feb 2023 21:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
 <2553f3bc-b1e6-4af2-fb6c-def486dd99a3@gmail.com>
 <CAPDyKFpCEzubkJ=roniomXHaWrY5AOqfPZmNLbMbBnubHzZrEg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: add helpers
 mmc_regulator_set_ocr_vmmc_up/off
In-Reply-To: <CAPDyKFpCEzubkJ=roniomXHaWrY5AOqfPZmNLbMbBnubHzZrEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17.02.2023 11:47, Ulf Hansson wrote:
> On Wed, 15 Feb 2023 at 21:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> A lot of drivers use this code, therefore let's factor it out to
>> helpers.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/linux/mmc/host.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 812e6b583..f93fb8c7d 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -597,6 +597,23 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
>>  }
>>  #endif
>>
>> +static inline int mmc_regulator_set_ocr_vmmc_up(struct mmc_host *mmc,
>> +                                               struct mmc_ios *ios)
>> +{
>> +       if (IS_ERR(mmc->supply.vmmc))
>> +               return 0;
> 
> Rather than adding these two new helper functions, how about adding
> the similar check in mmc_regulator_set_ocr() instead?
> 
There's a number of drivers having 3 paths here:
1. IS_ERR() is true -> do nothing and go one
2. mmc_regulator_set_ocr() returns 0 -> some action and go on
3. mmc_regulator_set_ocr() returns an error -> bail out

So the question is: what should mmc_regulator_set_ocr_vmmc_up return
if IS_ERR() is true:
1. An errno? Then this errno would have to be different from the
   error codes the function can normally return. 
2. A positive value? Seems to be the best option

Then we could write:

ret = mmc_regulator_set_ocr()
if (ret < 0)
	return ret;
if (!ret) {
	some_action();
}
...

Works but I'm not sure whether it's very intuitive.

The other benefit of the proposed helpers is that they hide the
complexity of using mmc->supply.vmmc and ios->vdd.

Mileage may vary here. Do you have any preference?

> That should allow us to simplify some code in the host drivers too, right?
> 
>> +
>> +       return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>> +}
>> +
>> +static inline int mmc_regulator_set_ocr_vmmc_off(struct mmc_host *mmc)
>> +{
>> +       if (IS_ERR(mmc->supply.vmmc))
>> +               return 0;
>> +
>> +       return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> +}
>> +
>>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>>
>>  static inline int mmc_card_is_removable(struct mmc_host *host)
>> --
>> 2.39.1
>>
>>
> 
> Kind regards
> Uffe

