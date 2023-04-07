Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74203C77B6F
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjDGNO1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbjDGNOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:14:21 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E8AD0A
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:14:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m16so28627664ybk.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873257; x=1683465257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43UCQJrVzHswziYr5j431+xtEn2T8Kb0mLYkPJWFQYI=;
        b=3+FaYIWDw45RP1NCHb0+lFiokMfMZ7MBQBciFil7FihVwy+v7+XYsM+hGga5McbGdy
         7PEmcVy0pAuCdXb6BR+XssMrHW+d4I5au64UqgEI1ciBV3+QhU7KqkoNhQH3lfKAfInz
         DMh/I63ue5b9t9sm3w6Q8VJB/lNLtLbuCDPiuGPMuqntXafe2OWfmFLzAO9lcpFAPdla
         JioF59KPAiD7nn6N8hBu03bS2GjqUckuTy04+w4lqnxxuu18IoygELCtAsLBhuveYnDO
         ttgZkp7VRcBh/mEvcFwU+51sdh34HLQ+hw6hbebW03EI4Ko+bFqHaI982lEabisn5On4
         L2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873257; x=1683465257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43UCQJrVzHswziYr5j431+xtEn2T8Kb0mLYkPJWFQYI=;
        b=KHmWq7O9+1hPgXebTf5Alv8JQMhjsZPBCYGrO6qEk/znsM32WJuLN20fGRHPBOqtMk
         pdo3yu6nEHdxXRtbgUe8YqdO1uoQy1B8AU2TShTubeH/+3O/uZymqnOAtovYpoyLR5Lv
         07NXOCSP30MiNVbhL4+NvzK3R6IQFWcr5thJx2toUU0JY0zeTOxyFemEfbyT2ZqJr3kD
         HK2WlPo8EiO0TUrDKMig4QOUCTLQE/kgbYaS7cosexuNg5uFnHYeqsVAz4JfRRkRJD1V
         jqgUohPSeXPC3M0Ed6eHhi79kNOW+uRls0Ht4o+ia+0axruJWFpSXKsXK1Q+5yOp4n6G
         X0hQ==
X-Gm-Message-State: AAQBX9dzBxMwvFAyqnWur+pwGiNRkmuzCHsqo4i64Y+VHfVP0yfekZJG
        lmJp5ve4UPRbqU4SqnoLY7tmmN5hKS9tcglsCB9Ljg==
X-Google-Smtp-Source: AKy350bBt2BGk3rQAngcNnk4+eCsUSeEfLrMscG5cjhFuWxjMzW5cxG1UfjeAjNCFrHkIAUzBImsPk28UxKQWlxNGPI=
X-Received: by 2002:a25:d28b:0:b0:b6c:2224:8a77 with SMTP id
 j133-20020a25d28b000000b00b6c22248a77mr1787926ybg.1.1680873256816; Fri, 07
 Apr 2023 06:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-10-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-10-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:14:06 +0200
Message-ID: <CAFGrd9qz5Xxp2xpeA0OeBPVnjCe1wX+2_QHG6_=6ipMnCzBDPw@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] arm64: dts: mediatek: add OPP support for mt8365 SoC
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
> In order to have cpufreq support, this patch adds generic Operating
> Performance Points support.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi | 101 +++++++++++++++++++++++++=
++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8365.dtsi
> index bb45aab2e6a9..cfe0c67ad61f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -20,6 +20,91 @@ cpus {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
> +       cluster0_opp: opp-table-0 {
> +               compatible =3D "operating-points-v2";
> +               opp-shared;
> +
> +               opp-850000000 {
> +                       opp-hz =3D /bits/ 64 <850000000>;
> +                       opp-microvolt =3D <650000>;
> +               };
> +
> +               opp-918000000 {
> +                       opp-hz =3D /bits/ 64 <918000000>;
> +                       opp-microvolt =3D <668750>;
> +               };
> +
> +               opp-987000000 {
> +                       opp-hz =3D /bits/ 64 <987000000>;
> +                       opp-microvolt =3D <687500>;
> +               };
> +
> +               opp-1056000000 {
> +                       opp-hz =3D /bits/ 64 <1056000000>;
> +                       opp-microvolt =3D <706250>;
> +               };
> +
> +               opp-1125000000 {
> +                       opp-hz =3D /bits/ 64 <1125000000>;
> +                       opp-microvolt =3D <725000>;
> +               };
> +
> +               opp-1216000000 {
> +                       opp-hz =3D /bits/ 64 <1216000000>;
> +                       opp-microvolt =3D <750000>;
> +               };
> +
> +               opp-1308000000 {
> +                       opp-hz =3D /bits/ 64 <1308000000>;
> +                       opp-microvolt =3D <775000>;
> +               };
> +
> +               opp-1400000000 {
> +                       opp-hz =3D /bits/ 64 <1400000000>;
> +                       opp-microvolt =3D <800000>;
> +               };
> +
> +               opp-1466000000 {
> +                       opp-hz =3D /bits/ 64 <1466000000>;
> +                       opp-microvolt =3D <825000>;
> +               };
> +
> +               opp-1533000000 {
> +                       opp-hz =3D /bits/ 64 <1533000000>;
> +                       opp-microvolt =3D <850000>;
> +               };
> +
> +               opp-1633000000 {
> +                       opp-hz =3D /bits/ 64 <1633000000>;
> +                       opp-microvolt =3D <887500>;
> +               };
> +
> +               opp-1700000000 {
> +                       opp-hz =3D /bits/ 64 <1700000000>;
> +                       opp-microvolt =3D <912500>;
> +               };
> +
> +               opp-1767000000 {
> +                       opp-hz =3D /bits/ 64 <1767000000>;
> +                       opp-microvolt =3D <937500>;
> +               };
> +
> +               opp-1834000000 {
> +                       opp-hz =3D /bits/ 64 <1834000000>;
> +                       opp-microvolt =3D <962500>;
> +               };
> +
> +               opp-1917000000 {
> +                       opp-hz =3D /bits/ 64 <1917000000>;
> +                       opp-microvolt =3D <993750>;
> +               };
> +
> +               opp-2001000000 {
> +                       opp-hz =3D /bits/ 64 <2001000000>;
> +                       opp-microvolt =3D <1025000>;
> +               };
> +       };
> +
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
> @@ -50,6 +135,10 @@ cpu0: cpu@0 {
>                         d-cache-line-size =3D <64>;
>                         d-cache-sets =3D <256>;
>                         next-level-cache =3D <&l2>;
> +                       clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
> +                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> +                       clock-names =3D "cpu", "intermediate";
> +                       operating-points-v2 =3D <&cluster0_opp>;
>                 };
>
>                 cpu1: cpu@1 {
> @@ -65,6 +154,10 @@ cpu1: cpu@1 {
>                         d-cache-line-size =3D <64>;
>                         d-cache-sets =3D <256>;
>                         next-level-cache =3D <&l2>;
> +                       clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
> +                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> +                       clock-names =3D "cpu", "intermediate", "armpll";
> +                       operating-points-v2 =3D <&cluster0_opp>;
>                 };
>
>                 cpu2: cpu@2 {
> @@ -80,6 +173,10 @@ cpu2: cpu@2 {
>                         d-cache-line-size =3D <64>;
>                         d-cache-sets =3D <256>;
>                         next-level-cache =3D <&l2>;
> +                       clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
> +                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> +                       clock-names =3D "cpu", "intermediate", "armpll";
> +                       operating-points-v2 =3D <&cluster0_opp>;
>                 };
>
>                 cpu3: cpu@3 {
> @@ -95,6 +192,10 @@ cpu3: cpu@3 {
>                         d-cache-line-size =3D <64>;
>                         d-cache-sets =3D <256>;
>                         next-level-cache =3D <&l2>;
> +                       clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
> +                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> +                       clock-names =3D "cpu", "intermediate", "armpll";
> +                       operating-points-v2 =3D <&cluster0_opp>;
>                 };
>
>                 l2: l2-cache {
>
> --
> 2.25.1
>
