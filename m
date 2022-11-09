Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2884DC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 14:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKIOsu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKIOsq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 09:48:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E4186D6
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 06:48:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so27606217edc.8
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7USN0G8Nj6bFP0DAG8wpDATUtQ4+Fo+i57WTNeIkt9o=;
        b=NRt78M2Sb88BheBzAT20bUfEl8jig4axjLGE9cA4Lt1JAoMq4Kp2dRwmyJftLj+Aiz
         JHHlO0YI2UjwVjPsI8Nep5TgZzvmeP1uvD0R9Zch0I38Q1dCIN54ZaXZRi5Bwm4n326w
         owPJoFtjtzvynKQh3U1yx3zMtALznwO78lMrgqzHwN9SeFU4BE9+Yp4Y0wQWfHWdgwGJ
         GUT9qMXOqexjc2b21CP5h0SDiefsKQuvsslSMYP9yRh1dWyR1gWDkShbMekAFnP4cKV+
         /OcTddzVbBhYvuGTeG6Q+sgMfEeRmBl0hHWHJ1WrbEtP9RUyvtc5MsB8UmpPIZ+Uo4k5
         0LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7USN0G8Nj6bFP0DAG8wpDATUtQ4+Fo+i57WTNeIkt9o=;
        b=YAMEGPPxJtZ4zpSs2korIWg0w5llE5hI4mY5rKDZMW8Sp/wrIOQewsRcxGgZBpwGEs
         6HtYndAs69XV7+mGjWRpPcBA27qWhA43WkR8gKzymFV8XKlnB8xL0zE6IPIKxbgMrQWk
         ZH0IFlI+uGyQ3/pUoNVsyo41IqSItSxzRexeuIQDDKt9Izy7iXlxMlAhKnaRUAOVsbFF
         p/PFZEgDQFCt4bBtZ/5aMGhOMImgQ743G/fzfV5LemPzVywivh75MsMHeFSlGQpJ6Lcq
         +xCGhSW/7+hR7Bp7sck4V4YSIJz8zrVrXUBKjnEzxbKEwY/0ErFREfIbqzQX/5vQq4qH
         edsQ==
X-Gm-Message-State: ACrzQf0DCKqFzwS2V2d+qnOk/M7TaaSjAbmtM0X8FEaGSaPX4Fk0koC/
        rBpVgN3xffwlzeI2V8MUsolmfBVJoegvgGXcjIEA1w==
X-Google-Smtp-Source: AMsMyM7561mKq4Buhe3zDStvs0P4R0k11DgxiwW71lUIvN+scEkFvD5qN931ug979+El3bYeMCLFhuO0FxQfFbUIUN8=
X-Received: by 2002:aa7:d6d1:0:b0:463:ba50:e574 with SMTP id
 x17-20020aa7d6d1000000b00463ba50e574mr42357603edr.158.1668005323470; Wed, 09
 Nov 2022 06:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20221109043845.16617-1-balamanikandan.gunasundar@microchip.com> <CAPDyKFo+FUAZ=1Vu4+503ch5_Wrw47BanTjdB=7J8XhRwczyqg@mail.gmail.com>
In-Reply-To: <CAPDyKFo+FUAZ=1Vu4+503ch5_Wrw47BanTjdB=7J8XhRwczyqg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 15:48:32 +0100
Message-ID: <CACRpkdYeJ0NuJr_RF10oMAEuhYTBfaLfHoZ=b3A2f4BqXkvzOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Convert to gpio descriptors
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, 3chas3@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 9, 2022 at 1:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 9 Nov 2022 at 05:39, Balamanikandan Gunasundar
(...)
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -19,7 +19,8 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/irq.h>
> > +#include <linux/gpio/consumer.h>

This is nice, but higher up the driver also #include <linux/gpio.h>
so delete that line too, <linux/gpio/consumer.h> should be enough.

> > -                       of_get_named_gpio(cnp, "cd-gpios", 0);
> > +                       devm_gpiod_get_from_of_node(&pdev->dev, cnp,
> > +                                                   "cd-gpios",
> > +                                                   0, GPIOD_IN, "cd-gpios");
(...)
> >                 pdata->slot[slot_id].wp_pin =
> > -                       of_get_named_gpio(cnp, "wp-gpios", 0);
> > +                       devm_gpiod_get_from_of_node(&pdev->dev, cnp,
> > +                                                   "wp-gpios",
> > +                                                   0, GPIOD_IN, "wp-gpios");

Hm. Dmitry is trying to get rid of of_get_named_gpio() I think.

But I suppose we can migrate to fwnode later.

This is at least better than before so go with this for now.

Yours,
Linus Walleij
