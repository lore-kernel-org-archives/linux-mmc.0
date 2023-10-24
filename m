Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA36C00A8F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Oct 2023 12:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjJXMQh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Oct 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjJXMQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Oct 2023 08:16:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B05E186
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 05:16:33 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85DAD3FA94
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698149787;
        bh=thwvxYYMUVPSY3nzBc7xApM08Kssn5NAFL9o/BCJG0g=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nZSj4IliyasfjvdC4ZPXWVk4QNzAZMC4s2MadTa0AMCKlyPrLhK5znrt/M9U7BPKg
         tt3gZObdEneza01sXSXHsFl8poxyaUo/w3/1gTrrVuhqwvqXvSt1o2XNtq9TIotWGB
         3GojfzMSgSTFbLTmAb8j1jO68hOuNuGdA6XbDwDiATUqzkHTEpq3fDVbbeSOufbWHN
         ggvkIkgmtifj5iYtmbaxWf47IIOtt0mRRMM/TCqfTrV+f6BLrYbqcgR4nPBvtei3DF
         IABJGa3LgNJ/wKyvo/jBIE6qFWswb+OKhGCiBNuGJZXHaH7VJVlIE8NkGLW4oDdHjG
         mG36JgrDIcadw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cca916954so59897031cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 05:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149786; x=1698754586;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thwvxYYMUVPSY3nzBc7xApM08Kssn5NAFL9o/BCJG0g=;
        b=YM7P6eQEWcnfpRWXr9fxI0S+xQ4ckAe4C1u6AJM+BIrs/Lk6oD8GfNFWgKzjwue1mr
         8CgO2j4YJgl7pnA9qKnsCjfRcKwStNi1KFDwnjZEYKbgkElNfPqM5ni6YHxdWJtXBAtH
         kdXMEUaPSf/CZNUTkxVTB769TGU8tipFTHb6Jd0ni8DYmEgrXz8UXVoPGYwYlNxlOX1L
         f27056/w6/VCJdFiaMM1+7sGRVfmJTgpPfk1tsZ3J6DugujMht7c8mV3ku3fkUOxl3Ru
         99PWoJdTW9mNSPMwjWVLkPqep7WagJpcDCDuDr8CKjk8WC+SpAqnjm/O+/OkbT4BjzIr
         qB7A==
X-Gm-Message-State: AOJu0Yw6vNwy25UxxJxfiz88bIzCgU4h5qPjNrEBvZ62KT6Owq91/XNy
        Qae0zq9FyxrL7rYksbAS2jVv3G0EUMR03hyr46VBqWoSiOtFrMTKVpQAieskad4uEM80/K2hKwc
        CamoFjnkxHbbVWKRlrgwtICSiTQwEH4pkeGT39j0YZXmIwWcsg5soEg==
X-Received: by 2002:a05:622a:2d2:b0:418:152d:bf4 with SMTP id a18-20020a05622a02d200b00418152d0bf4mr13460086qtx.51.1698149786498;
        Tue, 24 Oct 2023 05:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOE0qGS2pSUMsJf2A8W5Ex0DMIs+jJV1IcL5+p/qejHg+bJIzitFRzRk24ZJkjngpmMhUlqv5mwknRsepuX1A=
X-Received: by 2002:a05:622a:2d2:b0:418:152d:bf4 with SMTP id
 a18-20020a05622a02d200b00418152d0bf4mr13460067qtx.51.1698149786276; Tue, 24
 Oct 2023 05:16:26 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Oct 2023 05:16:25 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231023-th1520-mmc-v3-6-abc5e7491166@baylibre.com>
References: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com> <20231023-th1520-mmc-v3-6-abc5e7491166@baylibre.com>
Mime-Version: 1.0
Date:   Tue, 24 Oct 2023 05:16:25 -0700
Message-ID: <CAJM55Z-OBUsnybSLTxB8RHwsYuWhsMKVH3x8ana4=LeZ98Yv1Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
To:     Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Drew Fustini wrote:
> Add mmc0 properties for the eMMC device and add mmc1 properties for
> the microSD slot. Set the frequency for the sdhci clock.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 70e8042c8304..c4e748827889 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -52,6 +52,10 @@ &uart_sclk {
>  	clock-frequency = <100000000>;
>  };
>
> +&sdhci_clk {
> +	clock-frequency = <198000000>;
> +};
> +
>  &dmac0 {
>  	status = "okay";
>  };
> @@ -59,3 +63,19 @@ &dmac0 {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&mmc0 {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	max-frequency = <198000000>;
> +	bus-width = <4>;
> +	status = "okay";
> +};

Hi Drew,

For the StarFive device tree files we've agreed on sorting by / node, clock
references, and then other node references alphabetically. I'm not
insisting you should do the same, but it would be nice with some system to make
it clear where new node refences should go. Or maybe I'm just not seeing the
system you're already following.

/Emil

>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
