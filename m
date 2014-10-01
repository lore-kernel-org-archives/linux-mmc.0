From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: restore detect line inversion semantics
Date: Wed, 1 Oct 2014 09:54:34 +0200
Message-ID: <CACRpkdZPPZfF9cG-sCSG3agdkE8ToPTGi4yQ5jW2Ab60PW_t2Q@mail.gmail.com>
References: <1412085943-16872-1-git-send-email-linus.walleij@linaro.org>
	<CABxcv=n-+H3wrAr_vzEsXK_vOwQc8520wM=LJhzw70ZoSbJ_Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:51059 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaJAHyf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 03:54:35 -0400
Received: by mail-ig0-f178.google.com with SMTP id l13so521532iga.11
        for <linux-mmc@vger.kernel.org>; Wed, 01 Oct 2014 00:54:35 -0700 (PDT)
In-Reply-To: <CABxcv=n-+H3wrAr_vzEsXK_vOwQc8520wM=LJhzw70ZoSbJ_Ew@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux GPIO List <linux-gpio@vger.kernel.org>

On Tue, Sep 30, 2014 at 5:07 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On Tue, Sep 30, 2014 at 4:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> @@ -316,6 +317,8 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>>                         return ret;
>>         }
>>
>> +       *gpio_invert = gpiod_is_active_low(desc);
>> +
>
> The old code set gpio_inv_cd if (!(flags & OF_GPIO_ACTIVE_LOW)) so the
> above should be:
>
> *gpio_invert = !gpiod_is_active_low(desc);

Argh, done it like this in v2, but isn't that variable name a lie then?
If it's active low then it's inverted, but if it's not active low it's not
inverted right...

Sigh, atleast we have restored the semantics, but maybe we need
to comb over this again.

Yours,
Linus Walleij
