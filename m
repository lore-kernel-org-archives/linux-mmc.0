Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9AC38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0083221473
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI+WeYFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGJ35 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgEGJ34 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 05:29:56 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D7C061A41
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 02:29:56 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x6so3036585vso.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viH1iV0igem6dG1osD5lXSFto5UeKQo6I/r6j41w2Kg=;
        b=kI+WeYFEEA9jLoKV2d3E7dwUyyonlIPIl242k9750XKo5ORe4klWfuAV7grrUmx0pe
         81oSbWvf2JRpXrMDhtyaIzsMHzryrCqE0t4iOTWk45BvIr2QwotvhUUNbfqfE0msdui8
         A/+Tx3vLGOvtTPE1kWGs//HDeaZI2xem+qIyqcHHUztTiprouVP8b8AuR5o78AMr89UA
         HQzNycaDph+I3X8/VRavIrGj+mUVMK/JPdIhTI7VAtbK0NComAh/lF/6zjRcrVSpW9xG
         GFPpsYWE/TH2D45e4L0+VhUZX/H6aNF9Tc8iOkF1hmV0MpGcaJAkoIVvTpDm7sSAnW/t
         gQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viH1iV0igem6dG1osD5lXSFto5UeKQo6I/r6j41w2Kg=;
        b=d/GCrNRgpxYZjMFtX72x9BuhnboVYI0TG4sSNb8Sb1WsSdb6Cqa0tBFLOIMzzyxbwq
         iFWw9Xcm3Q0TbmLcKq6NXD3euAW0wpF2b1OieiB4xmzYV6T3xwURtmfdJN2hRgr7Jngq
         CCA4hfomYFjZ3I2K0+Lo0KHrVHCRcUzJ+haZylPfpayLKTsMB7F2uTGaDByMssTEaeB2
         lhXPwqMQlEG7V6OnW6ST5NC8dF+7fDaTVSCW07BeFxE0G0+gj1qUYGHLWlwlD6rWn5g9
         QxIXB1mY3k7BBv71MVsfF0OfwhTyDzxkVFQsWcrUFf5X+1Buv9xyqDp+woKn/53x+HkQ
         b2eQ==
X-Gm-Message-State: AGi0PuZy1dpGCSCJMF4Njovfjsq4ClH295oOlFLCAkQFc8gKUIE1IbTE
        fNztNJ6K6Qsaew4mVZjJAA3wrgo/ksYX2/5afvwmDA==
X-Google-Smtp-Source: APiQypI4am7jPf3se8Tdni9X7LAo6FYulFfGe4r2VYbr/7W89ZmzBdleCOUBkENYjHbYMqRf6aOMQjzkJhq36+9MZOM=
X-Received: by 2002:a67:ee0d:: with SMTP id f13mr11495244vsp.191.1588843795661;
 Thu, 07 May 2020 02:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200503222805.2668941-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200503222805.2668941-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 May 2020 11:29:19 +0200
Message-ID: <CAPDyKFrY0ApUCNL4gVHRc2FRcYaS0PKr_P4a18RUZHxcVceVWg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: trigger a soft reset after a timeout
 or CRC error
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 May 2020 at 00:28, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The vendor driver (from the 3.10 kernel) triggers a soft reset every
> time before starting a new command. While this fixes a problem where
> SDIO cards are not detected at all (because all commands simply
> timed out) this hurts SD card read performance a bit (in my tests
> between 10% to 20%).
>
> Trigger a soft reset after we got a CRC error or if the previous command
> timed out (just like the vendor driver from the same 3.10 kernel for the
> newer SDHC controller IP does). This fixes detection of SDIO cards and
> doesn't hurt SD card read performance at the same time.
>
> With this patch the initialization of an RTL8723BS SDIO card looks like
> this:
>   req done (CMD52): -110: 00000000 00000000 00000000 00000000
>   clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
>   starting CMD0 arg 00000000 flags 000000c0
>   req done (CMD0): 0: 00000000 00000000 00000000 00000000
>   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
>   starting CMD8 arg 000001aa flags 000002f5
>   req done (CMD8): -110: 00000000 00000000 00000000 00000000
>   starting CMD5 arg 00000000 flags 000002e1
>   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
>   starting CMD5 arg 00200000 flags 000002e1
>   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
>   starting CMD3 arg 00000000 flags 00000075
>   req done (CMD3): 0: 00010000 00000000 00000000 00000000
>   starting CMD7 arg 00010000 flags 00000015
>   req done (CMD7): 0: 00001e00 00000000 00000000 00000000
>   starting CMD52 arg 00000000 flags 00000195
>   req done (CMD52): 0: 00001032 00000000 00000000 00000000
>   [... more CMD52 omitted ...]
>   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
>   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
>   starting CMD52 arg 00000e00 flags 00000195
>   req done (CMD52): 0: 00001000 00000000 00000000 00000000
>   starting CMD52 arg 80000e02 flags 00000195
>   req done (CMD52): 0: 00001002 00000000 00000000 00000000
>   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 2
>   starting CMD52 arg 00020000 flags 00000195
>   req done (CMD52): 0: 00001007 00000000 00000000 00000000
>   [... more CMD52 omitted ...]
>   new high speed SDIO card at address 0001
>
> Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Ulf, I consider this non-critical because as long as the meson-mx-sdhc
> driver is not merged we only have one MMC driver for these platforms.
> I don't know anybody to prefer SDIO wifi over SD card access, so this
> can go into -next (in my option at least).
>

Alright, applied for next, thanks!

Kind regards
Uffe


>
>  drivers/mmc/host/meson-mx-sdio.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2e58743d83bb..3813b544f571 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -246,6 +246,9 @@ static void meson_mx_mmc_request_done(struct meson_mx_mmc_host *host)
>
>         mrq = host->mrq;
>
> +       if (host->cmd->error)
> +               meson_mx_mmc_soft_reset(host);
> +
>         host->mrq = NULL;
>         host->cmd = NULL;
>
> --
> 2.26.2
>
