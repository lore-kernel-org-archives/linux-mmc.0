Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6277EDE9B7
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 12:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjINMRF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 08:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbjINMRC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 08:17:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7071FCA
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 05:16:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d81a4b96a86so308637276.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694693817; x=1695298617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr+llaI5KQeooOMwZpfHvY4lngd1AofNhZErF5ZMjrQ=;
        b=DQr6ovxBcWfbud4kiE4WnHiQxwwZgK7DFaczKXoQGkF45/t6uHFzjvrdANaoATRvCa
         Nokly/4zkydGsZ1EnCi5A/MJxkuvDBt6Gz2RwWydOPWP+GdtE17ceM2EWHtIDQpRSjgk
         jAtmY1hQVFcE9eQJScDoah1maMvzoO3jWadeeotfELOHLZ5FiclD8GP9v0eqmxjdvmLT
         dxUv+P1ILJiTdY4Zrzhqs609My3IQGg5uLWPscyRQEWJzF75ln+w8z2vAL/Oa2eBb8dn
         AAUF3LLHc+EujKbAXpGnMWJOUQZQb11Zagr5TVRPvHnx55/IlvUpK+i4eW7vtjgMgqz4
         plFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693817; x=1695298617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr+llaI5KQeooOMwZpfHvY4lngd1AofNhZErF5ZMjrQ=;
        b=dGUkBE3cnow836J/IBTEoUog5WLjV+5fKxivNg8QGNKgX++7pL+3ntG7w8ZqMtf4LG
         +P/wIEGZPLtK8YQDw2QZonXzsS3b3lEDEFq/JonxE+WpTIxBLCYo3pAOq0Wm0rXjOuqD
         tejdM2FZx6+DP2Xq8+N7PeeVafcvJaqlO+VnyzgSl4nKgRJE9LNsEXbjRiELNN7nO1zP
         cfuhF/HDUHc+zEt9CyI8hnrbuBVOAtMLrMrpXKN7ShTnMGbi6KsWse7LN7XmBjVwYPrx
         OblZmwHlqF65c7fD0pB3or0gIat6jXQ1rpwhQlKul6+kzktlnIIp9RYX1trDoEO0EZN2
         vv2w==
X-Gm-Message-State: AOJu0YxVFP6qDrIyd/MPwAqVfcrLbdMzETzFirRxfJYiBm3wRd6pBmPm
        uvxGqgp8OlrA62Tsyo1qo18XKmrWEPlchk7wA69Dvg==
X-Google-Smtp-Source: AGHT+IGy47RyRdUCvMqANoPaoR6Tn7BvENA0d/H15MygaC3tgtS2zUr1kqNSdPGpbC+cdFyfG/H6N87XJuUgcjYAYUg=
X-Received: by 2002:a25:ac4b:0:b0:d81:754a:7cb8 with SMTP id
 r11-20020a25ac4b000000b00d81754a7cb8mr3274641ybd.65.1694693817406; Thu, 14
 Sep 2023 05:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com> <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
In-Reply-To: <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 14:16:21 +0200
Message-ID: <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Tue, 29 Aug 2023 at 09:18, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com> wrote:
>
> > Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) while
> > checking if the device is compatible with atmel,hsmci. Instead handle i=
t in
> > the if() condition. The compiler optimizes out the entire if() clause i=
f
> > the first expression in the if() clause is constant false.
> >
> > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@mic=
rochip.com>
> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks for tidying this up Balamanikandan!

Linus, we didn't manage to get this into v6.6. So, it's probably
better if you pick up this via your tree for v6.7.

Note that the commit message header may be a bit misleading, as this
is really a gpio patch. Maybe you can amend that when applying?

Kind regards
Uffe
