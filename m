Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC7C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbiARStG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiARStG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 13:49:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F2C06161C
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 10:49:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so48814080lfa.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7gSIAjEMMHVPzUY9IiyGaokpzvzLkdxvFC2XtksEpw=;
        b=jv5BMnRBMuhUA/XUaApRCcjspumfl+fNK6m4jaI3SAy+kGzSt4Mx1GJULcYoOFrFh8
         AEvrIeNsMWBb7bHjLblMkgrER6sznueruOay8Xn0g56/ahOESSMJFj2Nb6xi9PPHKk3p
         dXPxn/IQNoj7ygHl+pxX2dDVBqwPhsvf9IocFrb6M6FipWRzOVULy32vUT+cPtYJgOqa
         1Fh15DblTMV56QmkelIsdvvb1rbG07mVoSqLmyQ6iy82tgXUCXXqNjFZndqvaQTFqLrq
         Ny6DQZbyCUGzpgJR7iMBeWR5uTtedzEDSifwFGn3lS+X6rsLkedZM3ydxSfz0xBbU7z8
         /7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7gSIAjEMMHVPzUY9IiyGaokpzvzLkdxvFC2XtksEpw=;
        b=05i9MhRRz61XPkSGmQrjChDiXRu5T2MN1ecNIZlsGXFn/zoxq5fpjJ9Yn0ZBgDQI9y
         wBtgOqzA/RQqaoH1pcQWZP6yKbLBG2s/U//Pql7zQRJLYjKJGUpRcbXWOxMYi5pUP16f
         4wjDMCoBEzK+pRF2wuIOpy6TJIz42MBxjFa4qV8jfpDflAEOeWhsGqi2oNSyIvwAf6pU
         PTCa/YTV7bij6imdWMUTs9ElUwqhloSJ0xAMvnKjEHj58v7c0sJQwjeNWmFuLZrP+tlK
         yjdUFLLyh77qlwECt1OmNboaFkPBYrRXXalt7COCe1v1LqjKkWF21Ljv4HdJMg2ZPdt2
         ES6A==
X-Gm-Message-State: AOAM531f+qmhuOsKbBBL94KxXYCVk7jsX/6jUBbGPGTIg7lTKzIRMZ29
        a3U2dWQH/BCfpJUiX1+SpPDm8m5/sho/DZFB0pzXDA==
X-Google-Smtp-Source: ABdhPJywArf49Dw2UNrWxqMejJ7TLW9Hh1LFYNUhrgeX9EXHvoP0U5m2M1Yqidzc0d71+5BkmvBWTHMOVV1QUXgXhi8=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr22309044lfr.71.1642531744269;
 Tue, 18 Jan 2022 10:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jan 2022 19:48:28 +0100
Message-ID: <CAPDyKFr_9kfAns2p6fsUck93s3peyrHvCtv5M9E3fnxLmHbRqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Wait for command setting 'Power Off
 Notification' bit to complete
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 15 Jan 2022 at 13:15, Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> SD card is allowed to signal busy on DAT0 up to 1s after the
> CMD49. According to SD spec (version 6.0 section 5.8.1.3) first host
> waits until busy of CMD49 is released and only then polls Power
> Management Status register up to 1s until the card indicates ready to
> power off.
>
> Without waiting for busy before polling status register sometimes card
> becomes unresponsive and system fails to suspend:
>
>   [  205.907459] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>   [  206.421274] sunxi-mmc 1c0f000.mmc: data error, sending stop command
>   [  206.421321] sunxi-mmc 1c0f000.mmc: send stop command failed
>   [  206.421347] mmc0: error -110 reading status reg of PM func
>   [  206.421366] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x74 returns -110
>   [  206.421402] mmcblk mmc0:aaaa: PM: failed to suspend async: error -110
>   [  206.437064] PM: Some devices failed to suspend, or early wake event detected

Thanks for your patch!

I recall I was hesitating on adding another busy completion check for
this, but thought polling the status register for the power management
function should be sufficient.

>
> Tested with Sandisk Extreme PRO A2 64GB on Allwinner A64 system.

I will give this patch a try too, to make sure it still works on my
side. Assuming that works fine, I will queue this up for fixes and by
adding a fixes/stable tag.

>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index e223275bbad1..842b886bdd4e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -66,7 +66,7 @@ static const unsigned int sd_au_size[] = {
>                 __res & __mask;                                         \
>         })
>
> -#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
> +#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 1000
>  #define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
>
>  struct sd_busy_data {
> @@ -1663,6 +1663,13 @@ static int sd_poweroff_notify(struct mmc_card *card)
>                 goto out;
>         }
>
> +       /* Find out when the command is completed. */
> +       err = mmc_poll_for_busy(card, SD_POWEROFF_NOTIFY_TIMEOUT_MS, false,
> +                               MMC_BUSY_EXTR_SINGLE);
> +
> +       if (err)
> +               goto out;
> +
>         cb_data.card = card;
>         cb_data.reg_buf = reg_buf;
>         err = __mmc_poll_for_busy(card->host, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
> --
> 2.34.1
>
