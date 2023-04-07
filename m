Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BDC77B70
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjDGNMf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjDGNMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:12:32 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A67ED8
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:12:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54184571389so795276457b3.4
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873150; x=1683465150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogQ5usDGrCKMp6sdTMfv6hF4yE9d0BXCPBRsX3VFOJg=;
        b=P9gZnXO27CwpgcUfdKWvFIDMy/W3wouPPvS5NhKMlQ31/HlgFF6HmqZAW4LxrKdDm2
         MCSHoLXRiNShIve9a/IAvQ2YjsHF3NUtLutP+Qmhs+M5YaGP1dJu5AHhWqrp/B/LTnQf
         O5mEL7f7/cbD7pR3igsBtPcLMaSbFHoUAlAOTbIE/4j2CoWpjL7mrRh3Se61Aafz9k9H
         YjLK9sMIFV1yQkY5PsSntO4Y7X13C/RXAFiMnsC+tus+ViauzcfMB4IyaiZoJDqYBiZ1
         GbDdUY1PwLSY0mdkDv1eReYn/2IKX0kdWWPdwQchrLGIGJt2O9iAQ8eKfBIG43X6YCuS
         dz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873150; x=1683465150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogQ5usDGrCKMp6sdTMfv6hF4yE9d0BXCPBRsX3VFOJg=;
        b=duWYQycmn8PsMBp36KxdpVbe6+HL63a69fVssdQQZmUiJ7kdX3NCTRoi6Z2z57+F+M
         ZUSqoMF62OaSZd3VV7MkILD4cTw4lc1xK81EVJEib87uuL/F454cvWGfMg2TTgx1jtEb
         Dy6u3enCNN2U5NyNJEpG99NytRdj1IfdWA14Kbhlc0PGNWtC2O/HUINNKD8OQEYzejqP
         vTRXVS5kkI1VrAOK/3mG50dE/+oc9HIEchCVhZil2h9c3HlYYLsVFEZyeURPMQ9vnWwr
         3D4hO3SRkwAD9bvN2MYCaAKvMwJjynSbVh+9buJRoKBhs/tjCxSUAVZJNhrdurmVYkPp
         Ekbw==
X-Gm-Message-State: AAQBX9f/KmvvsGUf4NFxsTCHZEKJcvFKPhsiUXgFchzwIwrWovIV4sFN
        uk06ozoPH74ni50WwxC3Px+ZL6MgUZGr8sB8I8IwGg==
X-Google-Smtp-Source: AKy350a6iLgXjWlIFd9DThiMyVaE47Ir0ycsgta9477LJp6DoDsN83S7+YnAB9ANVsDi2u6A+bcIz6yJ9JbuVxehUZE=
X-Received: by 2002:a81:af65:0:b0:544:b864:5532 with SMTP id
 x37-20020a81af65000000b00544b8645532mr1033760ywj.3.1680873150121; Fri, 07 Apr
 2023 06:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-5-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-5-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:12:19 +0200
Message-ID: <CAFGrd9oKiyJE_313MEKLf_PeWreg8gs92Mntos1C13_B-m4Ykg@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] arm64: dts: mediatek: add mt6357 PMIC support
 for mt8365-evk
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
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

+ To: Catalin Marinas <catalin.marinas@arm.com>
+ To: Will Deacon <will@kernel.org>

Sorry for the noise.

Regards,
Alexandre

Le ven. 7 avr. 2023 =C3=A0 14:59, Alexandre Mergnat <amergnat@baylibre.com>=
 a =C3=A9crit :
>
> This power management system chip integration helps to manage regulators
> and keys.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index dd7da86420cf..a238bd0092d2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
>  #include "mt8365.dtsi"
> +#include "mt6357.dtsi"
>
>  / {
>         model =3D "MediaTek MT8365 Open Platform EVK";
> @@ -94,6 +95,12 @@ &i2c0 {
>         status =3D "okay";
>  };
>
> +&mt6357_pmic {
> +       interrupts-extended =3D <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
> +       interrupt-controller;
> +       #interrupt-cells =3D <2>;
> +};
> +
>  &pio {
>         gpio_keys: gpio-keys-pins {
>                 pins {
>
> --
> 2.25.1
>
