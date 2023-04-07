Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A4FC77B6C
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjDGNME (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjDGNMC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:12:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D87A8F
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:11:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m16so28621135ybk.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873119; x=1683465119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQXVsFW+31LBP6C4FWS3nChTZs4iEHGU72CKydQFqio=;
        b=IRfRKDlu6RaKEu1in26D4G49/Azw2xaFqnTAKn9PDgovyFswerslmpygnixR8s2NSK
         Uo4ZH9MpPCpMTvBCBnYDuwqq0DM+Hd5ZSgVWcVQEUYgJuxamcMrN6bfhpHiB4UM6eQzQ
         WtenHFN8TMr568sj2nbpFPn7mdgbbCJWi2Hvxam4RSWBoUr730OdkkOElF8xst0Owmwp
         403ZT4hTzhqeZl2SdRJYF7GJED/PHb2RklrehALiHYJMbDN6L987/tQIz9nG80rGpbWx
         82Vjh5oByJLoImVntYRD1ruU7L+VS8wO7DLxI6wDxqACTD52/pfN43jPuw17GJMpwOXs
         vBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873119; x=1683465119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQXVsFW+31LBP6C4FWS3nChTZs4iEHGU72CKydQFqio=;
        b=4t49l0eJsWQOwP/NCnBojEznVQBMxShUb1T6pTPBIZfOHpC2LXKsSMu/tb0VWHRlqg
         lr5BmcTf2wv053+pi6UMGOTQzmSNeOAcQY7G2W9Rzg8dcsBAgsVz02/wTEQr6bARhTcn
         W+xNjF0i5DQ1Q8TfBAxJt6U3+3zZhK9M4gdsD3vM4rna68EZxdtRpcHxDIy6JRjiW0YN
         e0H9cPglwXkyMmskq2dAgzyMZjZCsyANxfJxDMD6IDYOQzwPwPbDFSYcayBbZnyWN8Oy
         ccp7xHpnqFEzrM3v6EMSnOzw0+n5mEVKcXhQGvXvSJSYXd3g1RAuXJCQlxFW7SBzRe/0
         biMg==
X-Gm-Message-State: AAQBX9f3TqVPtVDoMs3YaaDxk4WSF1iZxpCkyHNHj4rgQ/hgeVclO5K7
        FVEl6iNW80JhPA/hH1jutvqW15I8jdXJ6L9A9C3FoQ==
X-Google-Smtp-Source: AKy350Zk0g/lHYushSDQgy/obb6GLYwu1nqG93xUzHxpoIdxq4iWwRbMDQOvwLUMYFRiSGqkf+zGcokEKcgpBOK8+e0=
X-Received: by 2002:a25:d958:0:b0:b75:3fd4:1b31 with SMTP id
 q85-20020a25d958000000b00b753fd41b31mr1813905ybg.1.1680873119001; Fri, 07 Apr
 2023 06:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-4-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-4-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:11:48 +0200
Message-ID: <CAFGrd9o0eSj4cowAZnonfYahqUqG7zc_a+wDDLea2CowBN2nsg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] arm64: dts: mediatek: add watchdog support for
 mt8365 SoC
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
> Add watchdog support.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8365.dtsi
> index 1f6b48359115..bb45aab2e6a9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -162,6 +162,12 @@ syscfg_pctl: syscfg-pctl@10005000 {
>                         reg =3D <0 0x10005000 0 0x1000>;
>                 };
>
> +               watchdog: watchdog@10007000 {
> +                       compatible =3D "mediatek,mt8365-wdt", "mediatek,m=
t6589-wdt";
> +                       reg =3D <0 0x10007000 0 0x100>;
> +                       #reset-cells =3D <1>;
> +               };
> +
>                 pio: pinctrl@1000b000 {
>                         compatible =3D "mediatek,mt8365-pinctrl";
>                         reg =3D <0 0x1000b000 0 0x1000>;
>
> --
> 2.25.1
>
