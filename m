Return-Path: <SRS0=TbaS=D5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C7C388F7
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 07:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC53223C7
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Oct 2020 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMKNSfRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508948AbgJVHwn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508943AbgJVHwm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2020 03:52:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D580EC0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2020 00:52:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so623229ioh.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2020 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYn9tKEOHWCOI5QlOI1vKYZ0f+sa9erXGuyhcchLPF8=;
        b=pMKNSfRd9oKXN0ERKQKM5OdKp864maGZx2xZ6mVK9eCFUDTStlvluAG/U4oX7vio1h
         kDbA69ZC0qB3zehJ9W63FZ0NFtAb0WYdGBvgbMeTpttC9+iomFqmMCxHFlEhIEEawFjA
         gsdaYHCxYF9pIN5FhoMLRD1zX4qUw1sjeOcvonE/mZdpPUOzclUwzPUP/IYY919ns61P
         xESjAFOxLFLmGWg0FRsOcmC9kvnpa5DimMJdFXREc6nmMLwWgv0+gBtPBsCc/m8ZQKsJ
         yWdq8USm1NeGmLmwwK6FJpNGPsuzv9iHfppC/NITkvAWAJLVYWZHW3ULAqoAMwwFLwJX
         aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYn9tKEOHWCOI5QlOI1vKYZ0f+sa9erXGuyhcchLPF8=;
        b=F2dzVFUFvJc2ypbo665tk/TDReGGwQ0hLqhKYJTd91I4HOnI78LCFaqsC2VIzMmEMp
         MtS7t3pHnioOeplOXrpDioTe1GzJGR9Y7U8xpLaoatOEy/KAot7zS/yTKWjYibUN8Yyr
         Hz9QVl+1WhVx5Xe4qlHdUM2Zn8PPDYsemMZaXYBQ4Q5R9Ss5fm2miogqdx26dnlsfK2a
         msAzVnq1QbYJCcZeDyiIbruQyRmCsxxbGL2P1bULyKxwiHZ0RGiirI7y85r0e610SK8a
         gD7rqFlA1x3sq+yRiEvzTL2cmWbTHaQ1oHTAjqEzqhiCiKsXZ88NqtnibyVRNf5rV+HJ
         gZGA==
X-Gm-Message-State: AOAM530U7NEiC7BMblhnV1VllAB5AwdxxOC0IAaM1XDZgncIOVdDyL5i
        LvxpWXdahR5fIl+4q184fO2FR6XIK+D60rjUYJY=
X-Google-Smtp-Source: ABdhPJw4a7d9TAyu1UTKDC0kFu6hvXZsWN/q2IiKIhU9H2XWhMiaaIf7H9rQFV53LgLxpKUXo9xezIEeRVJPvAS2NLY=
X-Received: by 2002:a02:7b08:: with SMTP id q8mr810164jac.120.1603353161026;
 Thu, 22 Oct 2020 00:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
In-Reply-To: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 22 Oct 2020 09:52:29 +0200
Message-ID: <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
To:     rinni@inventati.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Philipp,

On Thu, 22 Oct 2020 at 00:10, Philip Rinn <rinni@inventati.org> wrote:
>
> Hi,
>
> the Olimex A64-OLinuXino board comes in various variants, three with eMMC.
> While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW) it
> doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
> third variant so I can't check if it works there).

We got similar situations for Allwinner H6 (Beelink GS1 and Tanix TX6).

There is definitely an issue in the MMC sunxi driver with HS-DDR mode
and it's not limited to "olimex,a64-olinuxino-emmc".

Have a look at this this message posted by Jernej:
https://www.spinics.net/lists/arm-kernel/msg846093.html

I think we should disable the HS-DDR mode for A64 / H6 like it's done
for H5 and not disable board per board until the issue is resolved.
If you want to disable only for your board you can set in your device-tree:
mmc-hs200-1_8v;

This will switch to HS200 mode without using the HS-DDR mode.

Regards,
Clement

>
> Disabling MMC HS-DDR mode fixes the problem. This is also what Olimex does
> for their kernel:
>
> https://github.com/OLIMEX/linux-olimex/commit/eef0e814e74f.patch
>
> Mainline kernel doesn't differentiate between the different variants with
> eMMC so I'm disabling HS-DDR mode for all of them as done for the H5 eMMC
> controller.
>
> Disable HS-DDR mode for Olimex A64-OLinuXino variants with eMMC
>
> Signed-off-by: Philip Rinn <rinni@inventati.org>
>
> ---
> drivers/mmc/host/sunxi-mmc.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fc62773602ec..240d3803b8b9 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1397,7 +1397,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>                                   MMC_CAP_SDIO_IRQ;
>
>         /*
> -        * Some H5 devices do not have signal traces precise enough to
> +        * Some devices do not have signal traces precise enough to
>          * use HS DDR mode for their eMMC chips.
>          *
>          * We still enable HS DDR modes for all the other controller
> @@ -1405,7 +1405,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>          */
>         if ((host->cfg->clk_delays || host->use_new_timings) &&
>             !of_device_is_compatible(pdev->dev.of_node,
> -                                    "allwinner,sun50i-h5-emmc"))
> +                                    "allwinner,sun50i-h5-emmc") &&
> +                       !of_machine_is_compatible("olimex,a64-olinuxino-emmc"))
>                 mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
> --
> 2.28.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/0d590f91-5d7a-697a-5644-710d14e3ea75%40inventati.org.
