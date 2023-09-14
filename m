Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15387EEAA40
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjINNti (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjINNth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:49:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718651BE
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:49:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d776e1f181bso999004276.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694699372; x=1695304172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkZqjZNgB3Y1SyzOUIg94VhrWAWI+a6+Hf5lJqrRRNg=;
        b=Y6ZYo/SwMSCo+eD47c61jpkcM+x8sL+EdM7HOZiS33hyuLXZZWWsArQNkjV0U10iMR
         u8hTFCuAiLzFMIY3HKBsWCQ5e9rr/RjFe/i+aUBltZEqfoa0g6HWY65b1qQvuBheFMEw
         JJVXaEL19o1+j5FYrAfLPBIf2tuyL7PRzv93o8mpANGSExBouhUz8Da31Zd8ejPxzFlE
         izVyiac0O5yAGEgOkBg/39/CkhSYD4yxtgqBv/lLJ11OgT/Q19hw4k4XILbgAk53WMLQ
         wdOcp7uvGgkW3ZBNwBTN3udmly3B43aDsuYhz0EZm/ZKBe6/7Ck6fj+TMfqH5RYLmNr1
         bD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699372; x=1695304172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkZqjZNgB3Y1SyzOUIg94VhrWAWI+a6+Hf5lJqrRRNg=;
        b=JbUQ8NMHhaeg+Ykn6MdswIWTkS6d1YaAzAq5lMusqJj4Ose6xi42xKV4PgpuFCEUGy
         X8JqXAZg0G6T54KBL+PH10ZEsWyobFSj8wrUgRKFaQfE/GgB5xWWE5gQ9MwsFyfxTqmj
         KZihNf7ViwURyEILd+9oSWZAGXDNf4U3mJuvOIr83ZSK+4ldsxh3SyRWXg6WfE2vJ7FT
         rSqRtyq4dnGvxV2+DIgKqEWIYB4HyjSr8TwjlnRt6BiIErUCB1JIv7Q1WipqfgSB3hGu
         XjZd2Up0zM/LaD4AeZdgYGDSdH3GkCj+JKl5YBHRkPGJQbnl6UuSukGbrBevOUFPNrTe
         kV7A==
X-Gm-Message-State: AOJu0YwForB5TNeK7cGnmT6VwHrs/UbEh96chKeUHO9y3kRvdiIep/f3
        AIpJCNeBn1UaMeYWzUlENEwtkjxnL5e2coVyTTaiYA==
X-Google-Smtp-Source: AGHT+IEPbpu+f+x7Mxg2JcryCNwUiv/H2T0EP2OKWQkM+1Az2v0erf8Suz+I1yRTsUHgS+cLuGC8uIDdKyjo9397fDA=
X-Received: by 2002:a5b:1c3:0:b0:d78:ae6:e75a with SMTP id f3-20020a5b01c3000000b00d780ae6e75amr4738510ybp.60.1694699372664;
 Thu, 14 Sep 2023 06:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
 <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com> <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
In-Reply-To: <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 15:49:21 +0200
Message-ID: <CACRpkdaAqG86XwO0FcKdgNggthW7=v2L=GfhUbr-dhc99tXxyw@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 14, 2023 at 2:16=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Tue, 29 Aug 2023 at 09:18, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
> > <balamanikandan.gunasundar@microchip.com> wrote:
> >
> > > Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) whi=
le
> > > checking if the device is compatible with atmel,hsmci. Instead handle=
 it in
> > > the if() condition. The compiler optimizes out the entire if() clause=
 if
> > > the first expression in the if() clause is constant false.
> > >
> > > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@m=
icrochip.com>
> > > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks for tidying this up Balamanikandan!
>
> Linus, we didn't manage to get this into v6.6. So, it's probably
> better if you pick up this via your tree for v6.7.

Oh it's actually Bartosz managing the GPIO tree these days.
(Which I am very happy about!)

The best is to resend the patch to the GPIO maintainers and
linux-gpio@vger.

Yours,
Linus Walleij
