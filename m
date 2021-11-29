Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDBC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Nov 2021 13:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhK2NZO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Nov 2021 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377787AbhK2NXN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Nov 2021 08:23:13 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF23C08EC38
        for <linux-mmc@vger.kernel.org>; Mon, 29 Nov 2021 04:04:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b40so43955954lfv.10
        for <linux-mmc@vger.kernel.org>; Mon, 29 Nov 2021 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spcw4s/t5vXRqX14aFkjLOdh3EnyptdkGvm2wA8iHDo=;
        b=UJmO8T/5ZPY0QkzK/rITkboI5iF7QVEhEKPoaFNA7rpLFRkaE+xiFf42b1gWopw5Wy
         u8W7lg7/2TDhHfgQwU/75LsBOXAEyXKvjl+K3CyGDUJKIcUk1Cr5RUvZfUVQeSslSPTe
         SiwDiyDJwvXoGAYQH7ldAmrd+N48zKGEpuKASkwgWUiU6f8Zxs5j6QKcJp5Ahgc1fORO
         L61YrGeOYJh8Q49Bn4sccvvz9Y8ys32sg//9X09ifPMtAmJTgn2nz2qbdDcb6zZn6AzH
         Dei6eJbWRRewjUCPLeojKi8FXSyrZ98T+uxZepmLlDweC0KsZr2GoXZlKm7Fw0mMhHnc
         Kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spcw4s/t5vXRqX14aFkjLOdh3EnyptdkGvm2wA8iHDo=;
        b=pdlfeYEQMr7ZlR/jYF3zMkcsr6q6p0wDOcmv06inghvyiECAbq//dPhASuKGhd1UPr
         5QUWv13qw+vy+LHV/mtsFixw/2ux0aQmWxGIb1ZgjY/tSzybXwvSlk92e+hj37so4yJo
         nBjQAo5ZkHQR2hB5HqkIWrLFkvdzpEtA4gi4rhIfq46IX/LZXigPh2fIukXFKf+NSgNI
         76hjV11TJX3+mngVoIrLQC9pW8rwDsznV0uyq/YGeE1Mi84jmAsff5fYNWEgL2jvOFDA
         TLBgUcodCrFX7pcXCyKm7D3ZW9vfUKqKBvxMiL5U1a2qPSNzEu6l8NXN+S5W2gaOb5Yk
         kAwQ==
X-Gm-Message-State: AOAM530VfMfN3h1bd2NRjwG1mQ3LzDU4SYwBF3QdMSjIKZQjargVQrDc
        oVUpwvd1x5VdSVYBogwwulv97ukBhDl+nyduEwhYNw==
X-Google-Smtp-Source: ABdhPJzdnnYrIAJAYCgeajj+X+gN4r7hEwLi5rIG3QsxT0jr9149a6dMPeWbvtBS9ezYeIE0+oMZrH3VTjjoCCwoYrE=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr47615431lfq.254.1638187460201;
 Mon, 29 Nov 2021 04:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20211116105109.3830-1-oleg@kaa.org.ua> <20211126144750.11537-1-oleg@kaa.org.ua>
In-Reply-To: <20211126144750.11537-1-oleg@kaa.org.ua>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Nov 2021 13:03:44 +0100
Message-ID: <CAPDyKFpOdj-wrO2Kht-gt3ivLW1CjkJan8e+Pwuwyy9AYOekxQ@mail.gmail.com>
Subject: Re: [PATCH v2] Replace strncpy() usage by printf()
To:     Oleh Kravchenko <oleg@kaa.org.ua>
Cc:     linux-mmc@vger.kernel.org, chrisball@gmail.com,
        patchwork-bot@kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Fri, 26 Nov 2021 at 15:48, Oleh Kravchenko <oleg@kaa.org.ua> wrote:
>
> Manpage of strncpy() says:
> If there is no null byte among the first n bytes of src,
> the string placed in dest will not be null-terminated.
>
> Put \0 to the end of the buffer to ensure that
> the destination string is NULL-terminated.

Please update the commit message to reflect what the patch really
does, as the above is no longer correct.

>
> This patch also fixes a compile error with a newer version of GCC.
>
> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>

At next submission, please also add Avri Altman <avri.altman@wdc.com>,
who co-maintains the mmc-utils.

> ---
>  mmc_cmds.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 73bd32a..753fcd9 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1392,7 +1392,6 @@ int do_read_extcsd(int nargs, char **argv)
>         __u32 regl;
>         int fd, ret;
>         char *device;
> -       char lbuf[10];
>         const char *str;
>
>         if (nargs != 2) {
> @@ -1834,9 +1833,7 @@ int do_read_extcsd(int nargs, char **argv)
>         }
>
>         if (ext_csd_rev >= 7) {
> -                memset(lbuf, 0, sizeof(lbuf));
> -               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> -               printf("eMMC Firmware Version: %s\n", lbuf);
> +               printf("eMMC Firmware Version: %.*s\n", 8, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);

This looks good to me. However, I suggest you skip the dynamic length
format. Just use %.8s.


>                 printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>                 printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> --
> 2.32.0
>

Kind regards
Uffe
