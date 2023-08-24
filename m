Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C838BC3DA6F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 08:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjHXIeZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjHXIeK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 04:34:10 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3E172D
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 01:34:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d72cf9156easo5857523276.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866048; x=1693470848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx1JCcPjCZYdIsabGARYPpE09xWgY39/BIHBUOtvlRM=;
        b=yVZ0C6CryfeJ4SCnXKGUOcALhdyv1slpp7Ji0mGhkwM/usN3pjhkbw5Qcn5OCR0/Zc
         lGxRql8lTAOUaN3ONlHHbhf9IIWbdAd+nvegIwda0c7P6jkG0y3OOaZ6T12Gta+n1BS2
         XC1oTUwsZF9Idw+EcxIiRk902F4Ix4t8aTWIuNNTmliRVf/louFFkAP7o3RawwEtJYB0
         uGF64e1sIK9/Gtl7RdI+6Sq4J+35kqOvfRerfLjcOdN2oGg5vZX7h8pcV0BzggJQOkT7
         j86kPWrB5+x8UgcTBVozyU9CgIicOMtg10Uh6EhSSxek/EwfSRt6iseGWJ57i960GeiD
         B9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866048; x=1693470848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx1JCcPjCZYdIsabGARYPpE09xWgY39/BIHBUOtvlRM=;
        b=ZZA1YYMFda5kDS3iWt6V0XbdhQ1hYfc5VplOgn3jMWyK7JL6mJ+NYvqjce/ZRPPNt2
         IQl1Hc7vKd8JMe5OkqaUuWC0KSqJuc5btFPrLTde0hp/rxh0bHX5JKyrg3RAWul212Qg
         chDU0jqs2zOlqHqLOjZIgGCncSuV4dsbO8BgbBE69sN2A8RA0nCkYZh5CqQNDnCrdo8S
         PfuffIodXj9W8K8sab3JD4vsPwa1wXccpz85ezJ/IxSHWxNZGhuqKUnD98k/8pO/lZJ+
         ti1z0xz9177dFi0CZhns8xnDhOgV7nBJOhfqJa1Tpi5Fulojf9o4Jj3sXT7SfMVqRyW7
         tPug==
X-Gm-Message-State: AOJu0YwvINlTL5YIl7er1pV5oQLyUTQYW+Av55p3etRe46NjXpxbRO30
        9A9FcTEAKe9FpCC9fvA27023wPvVxPE3GSscfgVGWjE9rLw0YZTdXBg=
X-Google-Smtp-Source: AGHT+IEcJo7laVcyul2RySXcC4CyDoAj9lDi1bP6HOIeX0rCNYWlI+yADeeg7TSYUDFTmKqvliuX3LiW9/B3JDL/M5U=
X-Received: by 2002:a25:8689:0:b0:d0e:2e5c:2f80 with SMTP id
 z9-20020a258689000000b00d0e2e5c2f80mr15306360ybk.64.1692866047844; Thu, 24
 Aug 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
 <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
 <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com> <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
In-Reply-To: <63156971-6f3d-4023-90d9-98adc000a32e@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Aug 2023 10:33:56 +0200
Message-ID: <CACRpkdY83_nQx8tWRV9SJyD=-SvY+30FiSXkrb5vKkd+QfuPaA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Balamanikandan.Gunasundar@microchip.com
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Hari.PrasathGE@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 24, 2023 at 8:39=E2=80=AFAM <Balamanikandan.Gunasundar@microchi=
p.com> wrote:

> >> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> >> +       if (of_device_is_compatible(np->parent, "atmel,hsmci") &&
>
> The only difference above is "np->parent" while the existing code uses
> "np". This is because the compatible string is defined in the parent
> node here while the others have it in the same node.

Aha. What about this right before the for-loop
then:

/* The Atmel MSMCI has the property in a child node of the device */
if (IS_ENABLED(CONFIG_MMC_ATMELMCI) &&
of_device_is_compatible(np->parent, "atmel,hsmci"))
  np =3D parent->np;

Yours,
Linus Walleij
