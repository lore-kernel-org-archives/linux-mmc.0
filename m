Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D17CC6FD1D
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjDGNO5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbjDGNOy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:14:54 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E86AF27
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:14:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c0dd7e2f3so89080387b3.8
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873291; x=1683465291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3VDM6BonfxZxR/aIqG+UXRPKt9a+mpQkJxjwsAv4Mk=;
        b=EYgt6v1IEhj/HYAqnKpiJJom8T1Kf9QMdNP16lSbXvXntvHY8b+pHLX0Iz6SOI1jh8
         XwlqiLigAdgoV9bcjZ/R175Yg8h/ftYTu/rDsoTKv0sdp5GuvmW42QjmUUE8eMqrUKfg
         iiNHm6yG80c39Ibb08M3yA35Q3/aX+ePxocUywjebODgGgGViM/qjtGumsp4p+tYnfTP
         B0A6e3FMsikx9qZHkdeBVN66TrTVeRAneg/iBXPXJt4JWaxrD5YlFbnPn463f51XY6WZ
         e+vEj3MSISq2sj1XSh5g/UEacpNwxevRYv+sI7olEYYFcrXyYHkLIScyKrhsmYQGyKDO
         eeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873291; x=1683465291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3VDM6BonfxZxR/aIqG+UXRPKt9a+mpQkJxjwsAv4Mk=;
        b=iyLM/DFrlyErM2j7IzIFvyu7QksiDoFGcwN1brhq+yCNwhgx/SU40Zjz6J4I4c+pAs
         6BCt1y0ofDJtoufoAZKYHl07xsjIjx/MeaxqpR08kjSIoRxNphhJXm9LLU9gL5Lr26SE
         Q5nfj6T+KhlbmusHjIj0y1i/9kIis00sBbzro2cx8NOyF7Era8iH7N3nfUwVcZxgph6T
         ft8so875Yg1nh55ePwztyUGv2hGraVxZZw6mhSEr0m1csYO7JCDpipT+GhOwRMHObL9x
         9qN6t1QvwZnva9hGH1miiGDph+0VEN6ZaBJiwwKmGf/x/wNeee5vkQFLHyUnUSsbfUNK
         OAtw==
X-Gm-Message-State: AAQBX9dFcE8tTxJ108/wRkSfGZ9GKP4WyWbR6MvreWLOdVpIGsyHHuoq
        zhPIoQATlMos8QNIg33p010dHutsvcuPCQbzZgb1+Q==
X-Google-Smtp-Source: AKy350biNDWHsrxERmOnUuBy6jK34jRpZaUPgIp3kZ6WDTUIjrWP9DPztnBTYyClXfME+4ltxbPE84/Yb360qJlUgZg=
X-Received: by 2002:a81:af65:0:b0:544:b864:5532 with SMTP id
 x37-20020a81af65000000b00544b8645532mr1038296ywj.3.1680873291116; Fri, 07 Apr
 2023 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-12-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-12-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:14:40 +0200
Message-ID: <CAFGrd9qew3P2w7G5FxVPGyNNdx=4ZLeGjSXAktQgeQGyD2FcqA@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] arm64: dts: mediatek: Add CPU Idle support
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
> From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>
> MT8365 has 3 CPU Idle states:
> - MCDI_CPU. (Multi-Core-Deep-Idle)
> - MCDI_CLUSTER.
> - DPIDLE. (Deep-Idle)
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi | 35 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8365.dtsi
> index cfe0c67ad61f..413496c92069 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -128,6 +128,7 @@ cpu0: cpu@0 {
>                         reg =3D <0x0>;
>                         #cooling-cells =3D <2>;
>                         enable-method =3D "psci";
> +                       cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLU=
STER_DPIDLE>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -147,6 +148,7 @@ cpu1: cpu@1 {
>                         reg =3D <0x1>;
>                         #cooling-cells =3D <2>;
>                         enable-method =3D "psci";
> +                       cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLU=
STER_DPIDLE>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -166,6 +168,7 @@ cpu2: cpu@2 {
>                         reg =3D <0x2>;
>                         #cooling-cells =3D <2>;
>                         enable-method =3D "psci";
> +                       cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLU=
STER_DPIDLE>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -185,6 +188,7 @@ cpu3: cpu@3 {
>                         reg =3D <0x3>;
>                         #cooling-cells =3D <2>;
>                         enable-method =3D "psci";
> +                       cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLU=
STER_DPIDLE>;
>                         i-cache-size =3D <0x8000>;
>                         i-cache-line-size =3D <64>;
>                         i-cache-sets =3D <256>;
> @@ -198,6 +202,37 @@ cpu3: cpu@3 {
>                         operating-points-v2 =3D <&cluster0_opp>;
>                 };
>
> +               idle-states {
> +                       entry-method =3D "psci";
> +
> +                       CPU_MCDI: cpu-mcdi {
> +                               compatible =3D "arm,idle-state";
> +                               local-timer-stop;
> +                               arm,psci-suspend-param =3D <0x00010001>;
> +                               entry-latency-us =3D <300>;
> +                               exit-latency-us =3D <200>;
> +                               min-residency-us =3D <1000>;
> +                       };
> +
> +                       CLUSTER_MCDI: cluster-mcdi {
> +                               compatible =3D "arm,idle-state";
> +                               local-timer-stop;
> +                               arm,psci-suspend-param =3D <0x01010001>;
> +                               entry-latency-us =3D <350>;
> +                               exit-latency-us =3D <250>;
> +                               min-residency-us =3D <1200>;
> +                       };
> +
> +                       CLUSTER_DPIDLE: cluster-dpidle {
> +                               compatible =3D "arm,idle-state";
> +                               local-timer-stop;
> +                               arm,psci-suspend-param =3D <0x01010004>;
> +                               entry-latency-us =3D <300>;
> +                               exit-latency-us =3D <800>;
> +                               min-residency-us =3D <3300>;
> +                       };
> +               };
> +
>                 l2: l2-cache {
>                         compatible =3D "cache";
>                         cache-level =3D <2>;
>
> --
> 2.25.1
>
