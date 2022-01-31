Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D5C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jan 2022 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiAaWni (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiAaWni (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 17:43:38 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E87C06173B
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 14:43:38 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so3575479oos.6
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yX/YWQ2F2e81Xwl7jttAWwJX0hjqq2GEo6RpoBFupaE=;
        b=vfFnO0qBgoNjcKKMsAi/QdbQDYRqVl+e0ovhz1YJEmfDXIJTHFLajFCfy4a/29VKiK
         dCquWo1ULDCUPxTlldxNc+tt8SXRztecqlSswaH+6ta/g8TxE6LAX7cOpYyDMx3Ux8wF
         PDdy0mfS4w2MZfWV94dvZWPDCavyZ8a92IzrMJ2BxgXKKmEcYLtELACElRAkkVagd0AE
         3oWAuqlMHxwy/xFshv34BToc/9x2Aw7b14u2szcGtcqrrxYDbtBHgMTxV7BRFy9iVC70
         +u4Claci5p6RTS3K8Ow4IpkFMs/Ah+9lnAMG30eqGldxYGVp3V6NZiUD+cBE+akEEurO
         c39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yX/YWQ2F2e81Xwl7jttAWwJX0hjqq2GEo6RpoBFupaE=;
        b=mD7qqZiSu2UyIzyLJgirTt7t/vsE493TPe5/gdyx9aCqdjEnJyPjvOoaahFL/QG4dU
         CiWViKQz8kmI2e3mHLS/uSlpak35TzkbkQFT37vFKQGA9m89yP5/d1V64kUmMKA4ES7v
         lzgojNZiTN/XSYGmGLZk1g4LwVLpClu7+tIB248msLje5M7ScUmIEfsKoQcyVyiSQU4f
         4Ot/SmRi82jItNhzAxcfs90jNEdSDwS5x9Ewm14tyuLkaHl7a34CKIQSiwJC3q8PvsMb
         L2fnP2v73vIBt6YplPA/OskoQqCFCLpGKQuKxo8TQ+g1qIJh/4w+hTTBj9zBX2hR5fwr
         trmA==
X-Gm-Message-State: AOAM5309XvbNtWjo9nzs0+tu9hf0bMHPefpYrM7RsENESyM0c6pb05t3
        yx/hR/oGULIEdM3gV/blnWo1xA==
X-Google-Smtp-Source: ABdhPJw0/vA1k6EMzBnpDb3zSUhXhlmDS2Ml8ZV6QIGWT9ZbfXaCadYTGpIHmQ2Vbq0owZnAxdAkEA==
X-Received: by 2002:a4a:e0d8:: with SMTP id e24mr11256827oot.56.1643669017662;
        Mon, 31 Jan 2022 14:43:37 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c26sm7516092otn.34.2022.01.31.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:43:37 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:43:35 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jean Thomas <virgule@jeanthomas.me>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: msm8994-huawei-angler: Add
 sdhc{1,2} definitions
Message-ID: <YfhmF6FKV9/6YfAL@builder.lan>
References: <20220113233358.17972-1-petr.vorel@gmail.com>
 <20220113233358.17972-6-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113233358.17972-6-petr.vorel@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu 13 Jan 17:33 CST 2022, Petr Vorel wrote:

> Although downstream supports HS400, there are overclocking warnings when
> using mmc-hs400-1_8v:
> 
> mmc0: Card appears overclocked; req 200000000 Hz, actual 384000000 Hz
> mmc0: Card appears overclocked; req 200000000 Hz, actual 384000000 Hz
> mmc0: Card appears overclocked; req 200000000 Hz, actual 384000000 Hz
> mmc0: Card appears overclocked; req 400000000 Hz, actual 768000000 Hz
> mmc0: Card appears overclocked; req 400000000 Hz, actual 768000000 Hz
> mmc0: new HS400 MMC card at address 0001
> 
> Using HS200 (i.e. mmc-hs200-1_8v or mmc-ddr-1_8v) would reduce them:
> 
> mmc0: Card appears overclocked; req 200000000 Hz, actual 384000000 Hz
> mmc0: Card appears overclocked; req 200000000 Hz, actual 384000000 Hz
> mmc0: new HS200 MMC card at address 0001
> 
> But as the problem is probably elsewhere (bullhead behaves the same),
> keep mmc-hs400-1_8v.
> 
> Angler does not have SD card, thus explicitly disable sdhc2.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  .../dts/qcom/msm8994-huawei-angler-rev-101.dts   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
> index 0e3dd48f0dbf..5ce3dc169bb4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include "msm8994.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  /* Angler's firmware does not report where the memory is allocated */
>  /delete-node/ &cont_splash_mem;
> @@ -41,3 +42,18 @@ serial@f991e000 {
>  &tlmm {
>  	gpio-reserved-ranges = <85 4>;
>  };
> +
> +/*
> + * Although downstream supports also HS400 there are fewer overclocking
> + * warnings when used DDR, also LK bootloader reports DDR mode.
> + */
> +&sdhc1 {
> +	status = "okay";
> +
> +	mmc-hs400-1_8v;
> +};
> +
> +/* Angler does not have SD card */
> +&sdhc2 {

But isn't &sdhc2 already disabled from msm8992.dtsi and msm8994.dtsi?

Regards,
Bjorn

> +	status = "disabled";
> +};
> -- 
> 2.34.1
> 
