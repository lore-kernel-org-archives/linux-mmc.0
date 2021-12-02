Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD07FC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Dec 2021 14:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347284AbhLBOap (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355313AbhLBOam (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2021 09:30:42 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A0C061757
        for <linux-mmc@vger.kernel.org>; Thu,  2 Dec 2021 06:27:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e11so55086087ljo.13
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2021 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ymglO5l9JyIBt1Snbk0a6uPzBLLPRNh7R4IHXvi8OY=;
        b=Bcs4h6Pq/ZeItGKpLBXkYolSv7duGnWayXVp9f33vP2bFMjExfllvyxotw2ZXaXOR+
         WEeQQhiAYViqC301nsa715oQoxf7/sPDJ/j1+FJpp9tqQtxUoEosfTeetKrjtiCNasUK
         gCBIL/LMv+tjUjn4Hh+rv2kHTPmSDLzAJz9Jk3f1nlr83cgcueEThy46vCSDK4SsJDzt
         qfXscRRZr1tDHfd/rngxmzOCXP3+tkYLTrPX144UWBVyrdn63d6HmuEGmrIgJxPVcxxZ
         r1dqdVe2L7uQZbtkEnBi8bPzfnA+zHMtSCc4uMDVJTslNqkrNmT4k8DPisQVuT9zd+7+
         8wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ymglO5l9JyIBt1Snbk0a6uPzBLLPRNh7R4IHXvi8OY=;
        b=mziX60TLXENKD9wMHkWnIzPCPgY0oteTGVE6i12ey9NUhv6VpCn+NOgsOPgogkGroi
         pDvsyZn1ppIqoqj/jypMvJQHOQcPWywoNcBQaOlSAryeptxj2tXFlOSnKkJlkq7eWCIG
         EUcdGevYQHr2imBz6XuHZLN5wP/Znahi4D1TBJ6OpUvtmAnfj+F2QZF91zI3Nsb8396v
         Nnn+pI0pcFqp5G+w+0+vZ1TZon2k3Ydkia+9Tfnv9Pa1uLXipImhqeuuB/g2MVLzDATI
         PfYg561AtO/tZPMSYHIyqP2STkqpJChQjPVb1PxICBL2Vucsl+/e2clf6eheAgxKSPfj
         sAmg==
X-Gm-Message-State: AOAM533j7M8NvsDeVu8V7MkEZNfMm2H4W614jvfqJClnt7GmfEbO2XAb
        ziuOETbbzUd788ODI+/MSsw+GiWRTizF6QEsjv0HNg==
X-Google-Smtp-Source: ABdhPJyqu+f7w8Q/J7gjflGNoG6ZxTaG7F6YOjxF95frlgGGCQL6O8FtCJRM5TYOVFi7EdkUcoTrofXRbckUmfEeHx8=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr12553898ljg.4.1638455238013;
 Thu, 02 Dec 2021 06:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20211116105109.3830-1-oleg@kaa.org.ua> <20211130142715.11014-1-oleg@kaa.org.ua>
In-Reply-To: <20211130142715.11014-1-oleg@kaa.org.ua>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Dec 2021 15:26:41 +0100
Message-ID: <CAPDyKFqdK6PnJQKHPk80DXKzXGzz51SEAv3fhbhP6TkjEVgdBg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc-utils: Use printf() to extract and print fw version
To:     Oleh Kravchenko <oleg@kaa.org.ua>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Chris Ball <chrisball@gmail.com>, linux-mmc@vger.kernel.org,
        patchwork-bot@kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Nov 2021 at 15:27, Oleh Kravchenko <oleg@kaa.org.ua> wrote:
>
> This patch also fixes a compile error with a newer version of GCC:
> error: '__builtin_strncpy' output may be truncated copying 8 bytes from
> a string of length 511 [-Werror=stringop-truncation]
>
> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Fixes: 0eea71e4f22a (mmc-utils: Fix for Firmware Version string printing)

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
>  mmc_cmds.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> PATCH v5
> Updating commit message.
> Adding Fixes: 0eea71e4f22a
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 73bd32a..e07ec94 100644
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
> +               printf("eMMC Firmware Version: %.8s\n", (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
>                 printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>                 printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> --
> 2.32.0
>
