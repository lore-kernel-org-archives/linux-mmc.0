Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25087C77B61
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Apr 2023 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjDGNOs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjDGNOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2023 09:14:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D2B44B
        for <linux-mmc@vger.kernel.org>; Fri,  7 Apr 2023 06:14:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r187so48950925ybr.6
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2023 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873276; x=1683465276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYfJz5DR0sarRMEimOcvYMZLh47D2UkV2Jy+IyrrQOQ=;
        b=afYShcwaWCRKxQfWVC6A3UR9s7WsYh/m45lh7dvhXtRB16e21H+vEI88O/1n9pP8I4
         2biUZIldSXj1UlxNMnKldwyioUX0rXkQ8q9t93u3HTfhmuy9m1zMO9pme+sLax1EPkCJ
         g/1HP/SlmfpmPCsMjbbIYuuW3UZB1iCBAeWDEqrR6I/5QiBmYqlRlH7m2o6blm935sP4
         +rh/mTZ6T2ieURwovpfl6ay3Qc5CDtgNGd/WsZSgg1EL1jWOuNz6qBxeci4IJwFs/KJh
         Z+XRLogC5gdLXNlFuAUkHjWFCucZxRZ8Xpc7swDcbtI3+U0rfFuyCzLFRwtClMgorn2r
         9Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873276; x=1683465276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYfJz5DR0sarRMEimOcvYMZLh47D2UkV2Jy+IyrrQOQ=;
        b=zYC8LEEXGTNH6145DJ4tkqg8g6wkRZ0pLOc8giTg/XGD6eTtYutTb1M7uAr+g8aHMj
         fEA6WRuvx9EoREV1ryT0sDm9rPkBsOi156G7dQWXCp65CLWIAMhD9t6dRWGy13ZMcDiC
         EQImq2vuRhXDs5OTmidL9WZDniMwdzIkVeFu+7OO4ulPMCgs+iKMGlMjkM8CtUhYXGKt
         89fz9edq+2y3CAI6CdhZiRquqmf62qiDoJXvtKAXGl/fsDOxddl9uEwvagDTEB/Jnhlk
         HxDbM015c54qRZRfBV2uDy73ZxGUlVo52psdo6VT/EZH8kBrE/ubYnMsvSc989Bb+SJu
         qmxw==
X-Gm-Message-State: AAQBX9esKo9p2wGbel3n0usYESG47Z/UpYHlYrFkaYhpfZKfxcIReAkm
        ulwIIUuKrrEkmaPRHaxn5yMjGbdKChrjMPQwnnPCjw==
X-Google-Smtp-Source: AKy350bjb0HMJWJBzAnomlx9pGRYUzANSN19TtSNZ11GKBKtXGW/aXrzLpx8tgmRFVv06JMuSLYzMOruSpo5bx91W2o=
X-Received: by 2002:a25:d28b:0:b0:b6c:2224:8a77 with SMTP id
 j133-20020a25d28b000000b00b6c22248a77mr1788606ybg.1.1680873275845; Fri, 07
 Apr 2023 06:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-11-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-11-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:14:25 +0200
Message-ID: <CAFGrd9pu+t1K_4B-oCoRVq_rZfWZN=XWVARpTC5dS7HydZQFKg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] arm64: dts: mediatek: add cpufreq support for mt8365-evk
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
> In order to have cpufreq support, this patch adds proc-supply and
> sram-supply for each CPU.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index 431078f8670e..d723838ed49b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -88,6 +88,26 @@ optee_reserved: optee@43200000 {
>         };
>  };
>
> +&cpu0 {
> +       proc-supply =3D <&mt6357_vproc_reg>;
> +       sram-supply =3D <&mt6357_vsram_proc_reg>;
> +};
> +
> +&cpu1 {
> +       proc-supply =3D <&mt6357_vproc_reg>;
> +       sram-supply =3D <&mt6357_vsram_proc_reg>;
> +};
> +
> +&cpu2 {
> +       proc-supply =3D <&mt6357_vproc_reg>;
> +       sram-supply =3D <&mt6357_vsram_proc_reg>;
> +};
> +
> +&cpu3 {
> +       proc-supply =3D <&mt6357_vproc_reg>;
> +       sram-supply =3D <&mt6357_vsram_proc_reg>;
> +};
> +
>  &ethernet {
>         pinctrl-0 =3D <&ethernet_pins>;
>         pinctrl-names =3D "default";
>
> --
> 2.25.1
>
