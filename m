Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A35FC636D4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 10:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjBOKbf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBOKbf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 05:31:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5980367DD
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 02:31:33 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D9763F4BA
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 10:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676457092;
        bh=J/qDZkmn3KorSy6ubx2WDUhB6Kbdc/XauTgIuTzEF0w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=opnWgQXcBM8nmJoaHvCchIjyolFlrBkKPKoei6AzwdRKmU7KHSu26UqiSBULMd2du
         usLH/OGtTXbuHHXkIJit4r8aj5QgHXKEao91zbWHP8NJQvsYF/IRJAN5RNJbO/O8Px
         xpwt+puIAwHxggdmlo0GOs8pYUuXxqbfTn7yLytbk2nSgoDZVRDv9ZnYcua4DDdHEN
         A3ARSDPSB3VTrWZFRle4EVUJRx2uiuZ1Mm0dlwx8qgppRlFWjwb6hm4L6IQtcIf2pS
         8S4Y0MW+J0F9hnGtmXMk1gmDIMymZTj5zzQyRk3o6KQZJg3naMyMg3zzPJxPSIWS4b
         t1KuS6awTIhhg==
Received: by mail-qt1-f197.google.com with SMTP id v3-20020a05622a188300b003ba183e8272so10857871qtc.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 02:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/qDZkmn3KorSy6ubx2WDUhB6Kbdc/XauTgIuTzEF0w=;
        b=GEpLlWdVkQeOD2AsdqgHsfepRTyumAE4ZksWCnlKVJKEBhHBtuRvBIKBg+nZsE7Ek2
         gIoqyFy1F0u+YfPft4Qtc0rp1epun+3g5OurgggOXQ7h8JXNEr8aCESGBJkJsY1oQQX0
         sKsD0zhbq4tc1T3qwkrBkClktCgCvfkwEuCQtTI+VYzIpDpav+1ghTqBhKe7PxkGrKO2
         rtjUYjFv1H4lCVp7Vw5I/snFMbc7fyCKTEZe5FTTmYriYZqDvx7gDWvsTg1INcYhRqBm
         qTSWk6BAtcv1omw84g8U3sbeVL0g+rxv/Lym+vnUSIbi1JkbFGjlwXl8+nl+4exY8gHb
         YiVw==
X-Gm-Message-State: AO0yUKWtqWmJL8AV8FR9BzBOxy9VPU0DcARLx63vh3u0bQ5k+xNXG/oC
        J6pK8ik7NJ5UW/1cXgq/gYH0H930QZ58yikjOEWGSaE+HeAv6LtuaR6qZSEj8/SZEpwSWW1c835
        6X5oryolDbmX5dJMRVi6GLKpe3fIwSn9+WrXbsS1eNBE067F2nczwi2WT2xs=
X-Received: by 2002:a05:622a:164f:b0:3bc:e3a8:d1d6 with SMTP id y15-20020a05622a164f00b003bce3a8d1d6mr181344qtj.229.1676457091044;
        Wed, 15 Feb 2023 02:31:31 -0800 (PST)
X-Google-Smtp-Source: AK7set93hU2+oyuJ0C/LkbPAo2V6UGo4U5RSMbjNWw6Z8F8v4OAUsS6GhrWp/1jIOKMsaNCVvqP0POp7oTjMZpkPQ+g=
X-Received: by 2002:a05:622a:164f:b0:3bc:e3a8:d1d6 with SMTP id
 y15-20020a05622a164f00b003bce3a8d1d6mr181338qtj.229.1676457090719; Wed, 15
 Feb 2023 02:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20230203081913.81968-1-william.qiu@starfivetech.com> <20230203081913.81968-4-william.qiu@starfivetech.com>
In-Reply-To: <20230203081913.81968-4-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 11:31:14 +0100
Message-ID: <CAJM55Z8CRT_H-by=Nj0Nu1iWug1wdPMZceiE+RMJvE+q4RzQ7w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Feb 2023 at 09:21, William Qiu <william.qiu@starfivetech.com> wrote:
>
> This adds the mmc node for the StarFive JH7110 SoC.
> Set mmco node to emmc and set mmc1 node to sd.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 23 ++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 37 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index c60280b89c73..e1a0248e907f 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -42,6 +42,29 @@ &rtc_osc {
>         clock-frequency = <32768>;
>  };
>
> +&mmc0 {
> +       max-frequency = <100000000>;
> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       non-removable;
> +       cap-mmc-hw-reset;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};
> +
> +&mmc1 {
> +       max-frequency = <100000000>;
> +       bus-width = <4>;
> +       no-sdio;ru
> +       no-mmc;
> +       broken-cd;
> +       cap-sd-highspeed;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};

Please add these so they're sorted alphabetically (but keep the clocks
at the top), so there's at least some sort of system.

>  &gmac0_rmii_refin {
>         clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 64d260ea1f29..ae1a664e7af5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>                         #reset-cells = <1>;
>                 };
>
> +               sysreg: syscon@13030000 {
> +                       compatible = "starfive,sysreg", "syscon";
> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> +               };
> +
>                 gpio: gpio@13040000 {
>                         compatible = "starfive,jh7110-sys-pinctrl";
>                         reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -407,5 +412,37 @@ gpioa: gpio@17020000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                 };
> +
> +               mmc0: mmc@16010000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16010000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <74>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,sysreg = <&sysreg 0x14 0x1a 0x7c000000>;

This may need updating depending on whether you fix the driver or bindings.

> +                       status = "disabled";
> +               };
> +
> +               mmc1: mmc@16020000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16020000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <75>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,sysreg = <&sysreg 0x9c 0x1 0x3e>;
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
