Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B020C77B62
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 11:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCaLXs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCaLXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 07:23:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E81D91B
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 04:23:44 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b18so26998208ybp.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680261823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TmvPpd2YmgmpZIHsxp1gukcZ6IkVkvn2jIN3kBi1i8=;
        b=sTIfTWSObIn7UMlmphrTSYvN9Y7arYi6CRjrwIvqEAI9HkX9Exwa13txK+uYbpM7v3
         l6J4vkOqq8a0i3booWaeIUu92m/13ZKH2zw0OnWjp2qz2/hGDwkQeo9u2FnZnTxFWsxE
         9P7yyDufLYI6/2Q2hVxULgawDVnW3549Q1R+UtZSFfXLvjtNR6wvhVIjY3uC0C87RLam
         hX+jLrZKivu8A7dWkLaZPlBNwjfq5Cle2ETuJ8QDD5u6ndQPqq2STdtrm9yOoRXgMqZE
         Pd8H77fN3eDjuTD2iMiOpP6dJDo1FgaiTZm+w2XLGm3TDUzPGtd+RFL/46DdUX/uY+il
         RK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680261823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TmvPpd2YmgmpZIHsxp1gukcZ6IkVkvn2jIN3kBi1i8=;
        b=GbIiQk6SW71J/4Z29ptSrrmk+Mf9ZjqQz7U0iDkXFjjHa2oOR2xlouTBWNAMuXBkH0
         6RXZK3s02cG6DlvHWVciy9vIJ/+j/jjE2aD07DxZgl0l6N/zO6b4aMPlD4jGZsp7rSqH
         XNj9KhnUq9WD83VaitD+YuZKktwnF2+lSmZGHfiZXGtvl9HfmOdKVs8qDJH//6wxbMcN
         DyFOguYz8//CjUBjSqEAKlIyMBf1li50WMuZzlUeuIzC2qluNGUodbbppEoruftiDygF
         Y9tqrRoxpj0GlsWNbB8n5oQXPB6Gaa4emU4TElG873lLyzKWK2HG77vmiuYGHrfWkNcx
         LU3A==
X-Gm-Message-State: AAQBX9f9Rr8KslUFasPAifuhKWj2tBQtX70NxTFk8RRCyh3o/qEVG3dj
        OfGFWgfMS+KWXXfZa5Wb4Q2QiHrS0YLjACv3iSFRvA==
X-Google-Smtp-Source: AKy350Y1O6fb4CGhMXuQEcYQBTT1/oazAxitXaSHy0j76q36BAoNePcj7hYGMpWDOiNCG1ARjEL0yjdg1OiNTqnv+G8=
X-Received: by 2002:a05:6902:1181:b0:b6c:2224:8a77 with SMTP id
 m1-20020a056902118100b00b6c22248a77mr17804559ybu.1.1680261823120; Fri, 31 Mar
 2023 04:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-10-0003e80e0095@baylibre.com>
 <7b6be990-9e90-8e44-7c5e-f8b7a2701ce7@collabora.com> <CAFGrd9qMEtHVT+P-mBNxh6g1jOm5ifArSxi1bbGnrKgxCf7zSQ@mail.gmail.com>
In-Reply-To: <CAFGrd9qMEtHVT+P-mBNxh6g1jOm5ifArSxi1bbGnrKgxCf7zSQ@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 13:23:32 +0200
Message-ID: <CAFGrd9oYMXgWVxQHfn6hT0chx6kg+4UhP4Q=v4f+gF_NahhNdA@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] arm64: dts: mediatek: set vmc regulator as
 always on
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le ven. 31 mars 2023 =C3=A0 13:08, Alexandre Mergnat
<amergnat@baylibre.com> a =C3=A9crit :
>
> Le mer. 29 mars 2023 =C3=A0 15:25, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> a =C3=A9crit :
> >
> > Il 29/03/23 10:54, amergnat@baylibre.com ha scritto:
> > > From: Fabien Parent <fparent@baylibre.com>
> > >
> > > MSDC1 IP block is powered by VMC. Make sure it is always on.
> >
> > Why always on?
> > Can't you just set mt6357_vmc_reg as VIN of mt6357_vmch_reg? :-)
>
> I'm not sure to get it. mt6357_vmc_reg & mt6357_vmch_reg come from
> PMIC and are supposed to be independent.
> You suggest to link them in the mt8365-evk dts file using something like:
> &mt6357_vmch_reg {
>     vin-supply =3D <&mt6357_vmc_reg>;
> };

Additionally, vin-supply is supported by fixed-regulator and
gpio-regulator, which is not the case here.
I think it isn't doable.

Regards,
Alex
