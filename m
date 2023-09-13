Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF975EDEC71
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Sep 2023 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjIMOvr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Sep 2023 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbjIMOvq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Sep 2023 10:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 541ABE3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Sep 2023 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694616653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48dU2hQLagIX9Pt08ex4VtPwEkzu69KnmACTk65vyqM=;
        b=SmPunnbk63JOIeDlEFY4SyMEudQEApGoa9etxptuCXALxxDchcouYiMHLipQe5mXz7rBoh
        oTtbGbz45x0WFDh/4iHsHppG5UiXj3VBS3jfsCltq4lbm5P8vmCIrvPTntsTAtlwM3I8v+
        5mySHhLeq5+E+7eipkYfOxM7DvQQ/yU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-k5utMZGFPx-pP3_V2dP3iA-1; Wed, 13 Sep 2023 10:50:52 -0400
X-MC-Unique: k5utMZGFPx-pP3_V2dP3iA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9f282713fso389647666b.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Sep 2023 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616651; x=1695221451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48dU2hQLagIX9Pt08ex4VtPwEkzu69KnmACTk65vyqM=;
        b=PjaMssvgx1vJWk/urhIdiMGn+yZFlPnycMK09DHKj5bSordBQvOJ+V/n2jsiVbS8Yv
         /tMiINrHlaqD6aG1DZVnoZx9vD9VXJt4LHV48eDFkt/sr4kEJ+yRALTiudNSRT4Mjw6t
         mxu2oO38I30noTZTsjfNMt1f7r98nbUyjxRyDaesvP+kTmkbfFhybUhj294Yd9OD9bcc
         BEhNdZeKJTsS6SsH/8iAnQc7vi2S7nuCtkPqlz0a2yCF80eloYerQt5uRFFN8R+jFBT0
         Zl4qwcPUM3qx1PUlOgmttguNlw0tetWluy/mXehlm3TIHzHwYRscnUckxgafaZwWo6P8
         QNjQ==
X-Gm-Message-State: AOJu0YyL0Ad0FR3Xz+cVvPWUpY6vsGxjiNVCkZrmnvZczOnWnrHFfUC3
        Ym1RZOBWwiandWKOGbDpxXOccryA42dMYPjZSCYtwS1QN9XqDg3h0O3quhS5yoyZbJ6xf/Wqtv0
        QiglhL3S3PQK2gBEbeYEl
X-Received: by 2002:a17:906:74c7:b0:9aa:1020:8c39 with SMTP id z7-20020a17090674c700b009aa10208c39mr2278139ejl.18.1694616650916;
        Wed, 13 Sep 2023 07:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhdz7s3zxkxrAka/iFct75EEOhxMraFKGaGoggnTBpq6sAIlALbnFygNuVs1AGvDyAjsOScA==
X-Received: by 2002:a17:906:74c7:b0:9aa:1020:8c39 with SMTP id z7-20020a17090674c700b009aa10208c39mr2278116ejl.18.1694616650569;
        Wed, 13 Sep 2023 07:50:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0099bc8bd9066sm8613848ejy.150.2023.09.13.07.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:50:50 -0700 (PDT)
Message-ID: <5cff2031-e25f-4222-4d1f-b0b7d87b355b@redhat.com>
Date:   Wed, 13 Sep 2023 16:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] platform/x86: int3472/discrete: use
 gpiod_set_active_low()
Content-Language: en-US, nl
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230913115001.23183-1-brgl@bgdev.pl>
 <20230913115001.23183-5-brgl@bgdev.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230913115001.23183-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 9/13/23 13:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new polarity setter instead of the more cumbersome toggle
> function.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/platform/x86/intel/int3472/clk_and_regulator.c | 2 +-
>  drivers/platform/x86/intel/int3472/led.c               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> index ef4b3141efcd..31e520838b95 100644
> --- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> +++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> @@ -183,7 +183,7 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
>  	}
>  
>  	if (polarity == GPIO_ACTIVE_LOW)
> -		gpiod_toggle_active_low(int3472->clock.ena_gpio);
> +		gpiod_set_active_low(int3472->clock.ena_gpio);
>  
>  	/* Ensure the pin is in output mode and non-active state */
>  	gpiod_direction_output(int3472->clock.ena_gpio, 0);
> diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
> index bca1ce7d0d0c..46c9c569df5e 100644
> --- a/drivers/platform/x86/intel/int3472/led.c
> +++ b/drivers/platform/x86/intel/int3472/led.c
> @@ -32,7 +32,7 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
>  				     "getting privacy LED GPIO\n");
>  
>  	if (polarity == GPIO_ACTIVE_LOW)
> -		gpiod_toggle_active_low(int3472->pled.gpio);
> +		gpiod_set_active_low(int3472->pled.gpio);
>  
>  	/* Ensure the pin is in output mode and non-active state */
>  	gpiod_direction_output(int3472->pled.gpio, 0);


Thanks. I agree that the new API is much better:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Feel free to merge this through the GPIO tree.

Regards,

Hans



