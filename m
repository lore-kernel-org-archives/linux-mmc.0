Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3AECD4844
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjIVQgS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIVQgR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2023 12:36:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E96194
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 09:36:10 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 042743F68C
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695400569;
        bh=RKbV4MhZk6b87JTksm1ZK/ObuKYUjj6Uoe+MaWe9BjM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=axOpRfO6PfpGE2I6/iuXN+52W8z6r6OeH/Putaats6zPZaj53Dvhp17aXUAxdRWu5
         ARyhyDJlAy011T75vqdIstcXohjwNuE9NJ9/BpiHYEW6ha3abGBvVcGCHJrWuavJEa
         jVYe0AFjuoVvx7rU67/b4DN27aK83U1cNEBEeDRWRyuYHn+7gH2sRxc2z1I80LH+w4
         viJhXqHe8vZHK1y2X6YfIaMHNjgvb5z4BKvbwJEUxts/BsRziTfGT+cOzHhaN6vJ6f
         woJCMZ/C4mmJlSBFEpZYV+aM8kPzQg2knJFvvu+u4XUy5/WwCXGt8G6f369VYTh8dD
         ri+78Vh6Q3YJQ==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-417f94d6938so10811641cf.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 09:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400568; x=1696005368;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKbV4MhZk6b87JTksm1ZK/ObuKYUjj6Uoe+MaWe9BjM=;
        b=ciaDIWDcvAAkI6Jc9Vsrk0Arn1NM3S9fV4lzpwktmKLvLKvnrOALuenmT16oLRhcy0
         rNcSmTrXil4iryv8rFCSPCgXHBAvdKB5UQggjTqOznu+plvw6AFdSRdnlBmmfNjU2Lbw
         1C+cdRAKRNQLi6ius8PJfIjyGRaiqL6gV2eTD0kqSBelhUjIv+Yg35VVHBX0WnqJLoRV
         WPTnosQNns0JEA3rmdwP8T3Knuo+NBG5OCsF3/bwn1DqnZBWnwSWnbhzSYxabwKwv9ej
         JepFyQrCH2FwadxASTaCI447pHKJ8PoAIop0PsUp3OZePJKsVnDH32X95fKsGI4v2oqv
         rpTA==
X-Gm-Message-State: AOJu0YzhZ3p4qXHj8DKMmq4kC0c5KAroo3ZPEgwSi5wkiqg8oemKpBDU
        FBCZ8+QBF5DYvTbu1mjJqqOYwDKkdGZvLPglnkJ2kR4TJJSL/m/HJuI3IQGLib5RGb22RCqycyd
        3vwhtWV3bKti1XWluAm8nx/tibN8bDRDNKt2TqgjryyZJCWSusbOKJA==
X-Received: by 2002:a05:622a:1a9b:b0:400:9c4e:2abe with SMTP id s27-20020a05622a1a9b00b004009c4e2abemr9153635qtc.13.1695400568114;
        Fri, 22 Sep 2023 09:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtMOJCOBegPGfmaYPe4P541XIPb9WGKoNNQRopHdNvUyr6IlUhMeHDT069xvrKjurwJHkDV/lgU//1vjPUCGw=
X-Received: by 2002:a05:622a:1a9b:b0:400:9c4e:2abe with SMTP id
 s27-20020a05622a1a9b00b004009c4e2abemr9153614qtc.13.1695400567857; Fri, 22
 Sep 2023 09:36:07 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 11:36:07 -0500
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230922062834.39212-4-william.qiu@starfivetech.com>
References: <20230922062834.39212-1-william.qiu@starfivetech.com> <20230922062834.39212-4-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 22 Sep 2023 11:36:07 -0500
Message-ID: <CAJM55Z-huG6KSLywzA0Zih=MtzqvL0w+CxrqN7CKUrzor_A65g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add assigned-clock* to limit frquency
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

William Qiu wrote:
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Thanks!

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index d79f94432b27..d1f2ec308bca 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -205,6 +205,8 @@ &i2c6 {
>
>  &mmc0 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> @@ -221,6 +223,8 @@ &mmc0 {
>
>  &mmc1 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	no-sdio;
>  	no-mmc;
> --
> 2.34.1
>
