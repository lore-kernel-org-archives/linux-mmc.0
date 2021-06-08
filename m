Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB43C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CBC6100A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhFHNUB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:20:01 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:34642 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFHNTy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:19:54 -0400
Received: by mail-ua1-f44.google.com with SMTP id c17so11576566uao.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO3BohwnkUKnYIuONkUA0L73DP8nymMxh+DI7cdhd4w=;
        b=jMly9y0B/5qY0PR8RSddHqssiLIzHRTUAldUlCQQXlTwxHzxbXAEg0kxUaWtHKX+CH
         hUGuCTUIU5E8EXPZJefrrrEmI35XCFPNbkFZmuR8yJwC2hMXFfuq5XOk2bSbu40lRmi1
         TmnLRH9FtGL6QDNz4dVrVOKcgjSu6B/Va4gQrKGuEM+VOeJqmjmL0PwfvCKIR3WOCoL/
         hYn77PUX0xAfXLGrhlUj1DKOAJFUJlQPjuMAwqTj6DrgANK+k8TMWGWmiKCXehiiPDM3
         z+5u9kzzS6pECCG9zAgo/dvij0jNBbOdpJBQE0lb78qDygAee15OUFirubMn/ufI22K+
         Ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO3BohwnkUKnYIuONkUA0L73DP8nymMxh+DI7cdhd4w=;
        b=YEMflBR+0Nu0EDUMNsQuiNOw4JTvxSzB0PxP8XzPXDTAN5Pb96GReUL7Qf5ymzEoGM
         EJQVTpdwKtBweIMVhW79A0616MxITs1jzqXq3fV82K+4KBh0uG+acf+AiUqyHNQnfaOS
         oU0SuiTv2wd9cgJimVhch4oyvbH60xhFP8/Or9oWibDogaqPkU5skd527DJZScKB/mja
         hzDEb1SE2b/S3tgyBzX4sEjlqvXW5MBztJirjb8AMdfo+EQR1Hgvr8F53GaTgtqGK5iq
         hviYJX5kIcBHO9dYw2sMYG592NdpqSBo2/M6vs56iG2KkRfbGK/Amq6VOLhK2rddwYsp
         Xk8w==
X-Gm-Message-State: AOAM533TBr8velZQMTFzrfTqvZI3rjJnranJrTfPUCeqL5sYgzbyzCnt
        2YLOqegltOvafL6lGYI/bOD+5GCSZ7z5zfEn+MSO+A==
X-Google-Smtp-Source: ABdhPJxpMbI86j1ktkn7vwGdS6ghdFwZJ7dwIbr0IxePCkJHK9etSF1AgQY3m9fL2SZjr5Ui6IAsBEGWj3JiPCPA17Q=
X-Received: by 2002:ab0:7c5b:: with SMTP id d27mr12469684uaw.15.1623158221026;
 Tue, 08 Jun 2021 06:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
In-Reply-To: <ee8af5d631f5331139ffea714539030d97352e93.1622811525.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:23 +0200
Message-ID: <CAPDyKFo8U0SAuocTTznASBNMEzxm3HHbjfdG6E3dkHWjOR9kqw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Jun 2021 at 14:59, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> R-Car M3-W ES3.0 is marketed as R-Car M3-W+ (R8A77961), and has its own
> compatible value "renesas,r8a77961".
>
> Hence using soc_device_match() with soc_id = "r8a7796" and revision =
> "ES3.*" does not actually match running on an R-Car M3-W+ SoC.
>
> Fix this by matching with soc_id = "r8a77961" instead.
>
> Fixes: a38c078fea0b1393 ("mmc: renesas_sdhi: Avoid bad TAP in HS400")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Boot-tested on Salvator-XS with R-Car M3-W+ ES3.0.
> No difference seen in eMMC/SHHC detection:
>
>     mmc0: new HS400 MMC card at address 0001
>     mmcblk0: mmc0:0001 BGSD4R 29.1 GiB
>     mmcblk0boot0: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0boot1: mmc0:0001 BGSD4R 31.9 MiB
>     mmcblk0rpmb: mmc0:0001 BGSD4R 4.00 MiB, chardev (247:0)
>      mmcblk0: p1
>     mmc1: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk1: mmc1:aaaa SL16G 14.8 GiB
>      mmcblk1: p1
>     mmc2: new ultra high speed SDR104 SDHC card at address aaaa
>     mmcblk2: mmc2:aaaa SL32G 29.7 GiB
>      mmcblk2: p1
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 635bf31a67359f10..b719eda6b8619453 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -939,7 +939,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
>         { .soc_id = "r8a7795", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps2367 },
>         { .soc_id = "r8a7796", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
>         { .soc_id = "r8a7796", .revision = "ES1.*", .data = &sdhi_quirks_r8a7796_es13 },
> -       { .soc_id = "r8a7796", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps1357 },
> +       { .soc_id = "r8a77961", .data = &sdhi_quirks_bad_taps1357 },
>         { .soc_id = "r8a77965", .data = &sdhi_quirks_r8a77965 },
>         { .soc_id = "r8a77980", .data = &sdhi_quirks_nohs400 },
>         { .soc_id = "r8a77990", .data = &sdhi_quirks_r8a77990 },
> --
> 2.25.1
>
