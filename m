Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D1CC433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiKGUNr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiKGUNj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:13:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219122AE0A
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so12130565pli.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8EUFEtQtPp5wi61CP1QJz9xHMjgAa1yVc6pY8V0J90=;
        b=BQT4hLiiNPmn6f3BxnJlJ/dUG2Fuu5F5NOayg/wozaqhclutSwVozNcp9IQrJs7BEx
         uEKtHMnDF+Jvvw0aNmbfiOAKip8v4v3Ki/il6DKKJBWWVupNMwMLLj7FTGSXgMID+CQU
         0nNW64Psay5UopdLn9JdB6JuAfYG7nA06iOM8Q0tXxsAWQHZdEmqfBdrXiRlFbZPlncy
         zF4Hj3YsFVaR2yLgvV7+YKbg2fh/XsjMND4/jeYp9PFUpcHRBJ6C2HkqvvGFpNn60vq5
         bysrQsjcInRD0BtnWMJZz8IS9euybhfFdmu58azZTqD5g99mvRZ4I7dke3jyIrxGGpNj
         jfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8EUFEtQtPp5wi61CP1QJz9xHMjgAa1yVc6pY8V0J90=;
        b=duJ3YjxDFuCfpVQjKJZS/qVD+FFurTu6wL6OUoe4NM1W4tgWCuHFd5FVk3KlGYvgbb
         AcybhfWQlzTdAX960xCXR5nEZW+GHSo/ds836TOkbaubtDBJAUKyBEsa4xBiXF48Dnld
         zjCh1YrMIG2ndA0HxOq2wTkkndxsbg8BVr82yvA7wQ0o7gJoNfrOBAeO1JN7rRu7odDP
         rayxMCvCiIPsZe5xN7ru8Fwb6jS5AaIhQ2pWpmzNp09EFDogfxEJZvfK2Bw7B7KPS338
         DAn3pG5qeInBuU9Cfz2FmKYnmkmRNRfOSZchvm5sO3b3Ng0LwVABES1IvcRr5nC/FkMV
         XeJA==
X-Gm-Message-State: ACrzQf0a7lEpr44BMG+7HJWVoukEdgzPvPGpVfTi57CjUySD0NmQSQX2
        z9TAsOi0S3xUgtqM2GbtWjZe11KYwtOSpTTunZYKog==
X-Google-Smtp-Source: AMsMyM4r39aPv3/RDP5gqVTAMK+bW31ALLLoSbUFaPKhUJbyNRGkpcf+/D4oBnSI7HwXYUhn2sQD/+znIf0BB9H11AE=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr71862280pjb.164.1667852017652; Mon, 07
 Nov 2022 12:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221028073740.7259-1-yann.gautier@foss.st.com>
In-Reply-To: <20221028073740.7259-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:00 +0100
Message-ID: <CAPDyKFptJkHGaz9zc2G65tyS=2weH7ueV1d_CAszKfAgsqCkAw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: properly select voltage range without power cycle
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Oct 2022 at 09:38, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> In mmc_select_voltage(), if there is no full power cycle, the voltage
> range selected at the end of the function will be on a single range
> (e.g. 3.3V/3.4V). To keep a range around the selected voltage (3.2V/3.4V),
> the mask shift should be reduced by 1.
>
> This issue was triggered by using a specific SD-card (Verbatim Premium
> 16GB UHS-1) on an STM32MP157C-DK2 board. This board cannot do UHS modes
> and there is no power cycle. And the card was failing to switch to
> high-speed mode. When adding the range 3.2V/3.3V for this card with the
> proposed shift change, the card can switch to high-speed mode.
>
> Fixes: ce69d37b7d8f ("mmc: core: Prevent violation of specs while initializing cards")
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..c5de202f530a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1134,7 +1134,13 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>                 mmc_power_cycle(host, ocr);
>         } else {
>                 bit = fls(ocr) - 1;
> -               ocr &= 3 << bit;
> +               /*
> +                * The bit variable represents the highest voltage bit set in
> +                * the OCR register.
> +                * To keep a range of 2 values (e.g. 3.2V/3.3V and 3.3V/3.4V),
> +                * we must shift the mask '3' with (bit - 1).
> +                */
> +               ocr &= 3 << (bit - 1);
>                 if (bit != host->ios.vdd)
>                         dev_warn(mmc_dev(host), "exceeding card's volts\n");
>         }
> --
> 2.25.1
>
