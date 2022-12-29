Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E46DC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 00:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiL2AXd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Dec 2022 19:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL2AXc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2022 19:23:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B69B30
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2022 16:23:31 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n8so9280452oih.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2022 16:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5n19q5k9lrHaHasolTS/ptrEfcV+LGTg7kYhaCHvFHQ=;
        b=Cf4l9JKrdX/Ez2nZNvo9zM5aX/7hd7PNIEIjJ8L9QGCjmUrTdgfPSWmKAe/jUKUMNl
         dniw6e1eDsh6BzutXynzstEtsWOBfSZDoCxlMCzwDZkTRuceeUuwsWB1KFIHO5qqMy+D
         tm72D4OjR8XKDN9oncoyEFIqsb5hyMVWDTpWyAAf/dUzp/ifvY58bhba8zn1ehZQgBs9
         d8AtLNzBPOifVswf0OhJAQu3iNabD1zz/7q2bsq8Nl2Q8Yuu3AG3NkkW7YV4RZYaNTUq
         gOBDsrg3Wg3hHyg7Fi1c+c9QcyuqZYJg22yOHplkFt2Jn1aGXfYosAqoF5Ac7yVGF4dy
         jJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n19q5k9lrHaHasolTS/ptrEfcV+LGTg7kYhaCHvFHQ=;
        b=Kig6lMwkEL8QLIH/y7iUOCIctsIsQRpOGRevl178AihC1g9Yqeh+ZswzNDCwqPbS2A
         0T6pXEmElZXHS6DOECX5ZIaY06qBxJzRF7gCr/BeNK1tQgEurfhb6wZB4O8Mcz0BzL3+
         AwNE983vm0hkIWElNvTzXDSawkQ9VnkOBJM2Dyf7IfpCDaQYbtAI2rF18YZVk49yx24m
         0hSfc6YlcubQHmTRCAqvzIXm54jzx8Rnf8r6qpskf31UHpTSs6I6NR7VYyATrd4fwn5+
         fXW+GtclQEz1PHxfXHLzMU2f3Cia8MOZWOBPfwUcZjRl3Nf0PnFrMbk/v0+Wkc93wXff
         ZbKA==
X-Gm-Message-State: AFqh2kopczmttWvw2Jvzmrd7VlrIz92g2EIOR/KJyqpaV7Rf/ncOYikt
        c+epu65S/VNxmNTs0RpVP4znWkJqkNB8RGtq69eHoA==
X-Google-Smtp-Source: AMrXdXt9HxYfhcMXjKBtBHyCEDmd0OQJn/C8Wfcv/tiY3a9Q9iTDYQ5TkNCQuLDAM2jjWd2akxSupd0TXW52M4s7oQo=
X-Received: by 2002:aca:3dd7:0:b0:35b:8358:aed4 with SMTP id
 k206-20020aca3dd7000000b0035b8358aed4mr1385039oia.291.1672273410711; Wed, 28
 Dec 2022 16:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com> <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 01:23:18 +0100
Message-ID: <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hari.prasathge@microchip.com, dmitry.torokhov@gmail.com,
        ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Balamanikandan,

thanks for your patch!

On Mon, Dec 26, 2022 at 8:39 AM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
>
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Overall this looks really nice! I thought about converting this driver
but was a bit afraid of doing mistakes since it was a bit elaborate.
Nice that you use fwnode accessors!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Improvement to consider (can also be a separate patch):

> +       if (slot->detect_pin) {
> +               present = !(gpiod_get_raw_value(slot->detect_pin) ^
>                             slot->detect_is_active_high);

Normally we contain all this active low/high mess in mmc_of_parse(),
but I guess this doesn't work here because the of node is different
from the device :P

Since the code says *explicitly* "active high" not "inverted" as the
core code parses it, could you try just push this to gpiolib like
we usually do, by deleting the detect_is_active_high stuff and
just apply a patch like this?

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4fff7258ee41..5979c9a75cf9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -199,7 +199,9 @@ static void of_gpio_set_polarity_by_property(const
struct device_node *np,
                { "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" },
                { "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" },
 #endif
-
+#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
+               { "atmel,hsmci", "cd-gpios", "cd-inverted" },
+#endif
                /*
                 * The regulator GPIO handles are specified such that the
                 * presence or absence of "enable-active-high" solely controls

(It's fine to include in your MMC patch if some GPIO maintainer like
me ACK it.)

Yours,
Linus Walleij
