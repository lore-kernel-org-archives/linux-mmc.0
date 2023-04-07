Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636E2C77B71
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbjDGNNX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjDGNNQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:13:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5D1B5
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:13:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i6so48987700ybu.8
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873191; x=1683465191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvL4FM6K7sFiatPoW9lB13zR0/OGaSTbkxaFtIhuADo=;
        b=ukJ76x9GiFfA5bEM7OvmkeAGsaMYAsJaXFxWNRyp2t0bW6KfuLZcxoXAUsp7FVyKZZ
         D4iBeU0jqNAV+EnZ+7LnoS+/TSlWoUVEFwZQf/l0y60k1/fvTf77U+ZHgFdefKIEvK3M
         89onXFwEIffZ63yNNQcLSILEcYbnBRZIQYv5uJS686o9uCL/za2Tl0itkXWt8Z/F8FLc
         23ke2JENVLlGxQ2Q538u2enguzOmet1kXFEp9FBMHKhnqjagebk/V39dBGFCl/4J/D23
         q8ydzwvox3k3IdgUTuaiFJfj+QAX5hnvF/DeyqeJn4Ts6Eb2fICWY1EPQXrVwDEZPc0X
         +etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873191; x=1683465191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvL4FM6K7sFiatPoW9lB13zR0/OGaSTbkxaFtIhuADo=;
        b=aoGScqw093QFOrLJLlJHfVxYhkDwIBdltC1qB7vVOfS9q3Rbw1nAd0cvd9zdIEqdu3
         WbFRVFH3ZCxiI82gjbTng1Vd082XAQpa75Y7f9BpG0zesGA69NoaN9vyPJNq0JYXxFa2
         Y374UeJHvYwYhRoonknXaYtw5HhSpVF9p076Lv4uIDtsaeT4G3Qain7cOoYXrIAHrGKE
         CXKb0QZcsp0F/5T8CRAGw0shHEckN2MqcKg/IELZppkXZcbm1987S/ZN3xfCQE8yc7w7
         p2hlsSunzpLqivjbIF3It1adsi6JJPnVmv6u3MIBcmI/cBCEREVz8uDdwPLW3cZdOdF0
         zPpQ==
X-Gm-Message-State: AAQBX9fDx2j2ISPEZIb/MeMsMLN1I5BF7yvUQUhAE1Hdx/spFYAI48/s
        ENS/UMfS4aGZwe0ao4jCvc5dgTKupl2aHKDz3diY0A==
X-Google-Smtp-Source: AKy350aCRZnuELD2k32jpyfqMWnAcFkkXBqQEV+LvaQFGGo1MZu+6ebnj20/GbABh6hYrIQtMyIogGEdSSEzQbd8Nf4=
X-Received: by 2002:a25:d994:0:b0:b33:531b:3dd4 with SMTP id
 q142-20020a25d994000000b00b33531b3dd4mr1373350ybg.1.1680873191647; Fri, 07
 Apr 2023 06:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-7-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-7-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:13:00 +0200
Message-ID: <CAFGrd9oRoqsE=eNDbT4o+j5s_3zwOLi_RsFnVPEW=0MXCMZjFg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] arm64: dts: mediatek: set vmc regulator as
 always on
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

Le ven. 7 avr. 2023 =C3=A0 14:59, <amergnat@baylibre.com> a =C3=A9crit :
>
> From: Fabien Parent <fparent@baylibre.com>
>
> MSDC1 IP block is powered by VMC. Make sure it is always on.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index cd920d09c3fe..1c36d8f19525 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -137,6 +137,11 @@ &mt6357_pmic {
>         #interrupt-cells =3D <2>;
>  };
>
> +/* Needed by MSDC1 */
> +&mt6357_vmc_reg {
> +       regulator-always-on;
> +};
> +
>  &pio {
>         gpio_keys: gpio-keys-pins {
>                 pins {
>
> --
> 2.25.1
>
