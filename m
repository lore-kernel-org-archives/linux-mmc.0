Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD1C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379725AbiBHPTG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379711AbiBHPTF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 10:19:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA486C06157B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 07:19:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x23so34080263lfc.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Feb 2022 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+ilIWvnh4C6YWkFvd3/oY62qULJAfkmDPhnJqewbAQ=;
        b=GXfWTFS9484CZ0IrUe1pU3cy4+7Y630K4oVK01gGa5PRDc6dOEsIwFmBsb7yIaMbQf
         lQ4f+p3hkv1Pop9QIUdRjuq4+FWOYvxYql0sBtZrVjxMwyHGFxifOm7yltmpLpWSf7eF
         mjtTjq9R967UIZzSdALiw/jk3gpyVFmGs0CSDF+ApesBZG1t51Kb8742BUJPJ5Pn6rkg
         jer0pPz/hkL7xxWoKkYXEsQJC8r1rAlCSLE4alpPXwCrpnXnOCTtILHtWeqf4cbiBvIC
         xIOYHVdg8bKkoUVclgFDl3AS7pyU2D65O1k6W+9Em47tSdi0V6kG0nvoEfTALOm5oxmE
         MjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+ilIWvnh4C6YWkFvd3/oY62qULJAfkmDPhnJqewbAQ=;
        b=iZKqCP+0WYGCEBeC8grW2MIcumjV+wFewN1LAR15HeywPmPJlcPVR10EHviyN86vAi
         rUbW2i2YcXRzWgQO9CP+SLAWHT1y+c99mVFEr+Wu0ncAxAWmh+eZYsSAMNaMhf6tDJyE
         dR57WU6jbKBIk720jrOF3HhHh/Ew2THoRXJ/mhRFY/ikYqx6jB4a4E2T/qvEKNYwVaWC
         0lQsAt2BGRm3Rz8qEFdZb3a3iokrVucl6feXrK95eSJrPUf8TmTCJKEm92aR2TcukVBT
         Lpc80VCgBvHjTF7TuJlbZ0V/5ga/vdoGKJ3/E2TT/GZcyGAeTAgYiGBDct+ECdT1+5my
         tEWw==
X-Gm-Message-State: AOAM532IxXaQIKC4QiGm2cCFT1qnE015scwHLE7YAA/3UkW6dv/vxwx8
        iJoi+usrSF5UmcW4HQuTnO06I+RMK8nK4ts3annuKg==
X-Google-Smtp-Source: ABdhPJwLWGMwWkh5bTg1IuhRmmrDeqbkRPlEFS3NNkCPLK0EOIKhKL9OZaRP3McUFNXHCM3QWbnJiAVegHh4I/qxRxQ=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr3192888lfv.184.1644333543170;
 Tue, 08 Feb 2022 07:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20220205205647.7677-1-marius@FreeBSD.org>
In-Reply-To: <20220205205647.7677-1-marius@FreeBSD.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:18:27 +0100
Message-ID: <CAPDyKFqE1tRZW0c_xQVUa7m5c2Du0edV7ZhFOEPGEyKE_JOzfQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc-utils: manpage: Document -c option for
 partitioning commands
To:     Marius Strobl <marius@freebsd.org>
Cc:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 5 Feb 2022 at 21:57, Marius Strobl <marius@freebsd.org> wrote:
>
> The 'continue' option was added in commit 752072dafe9c ("Add -c option
> for partitioning commands).
>
> Signed-off-by: Marius Strobl <marius@FreeBSD.org>

The three patches applied to
git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
>  man/mmc.1 | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/man/mmc.1 b/man/mmc.1
> index bdb6f09..bccabf3 100644
> --- a/man/mmc.1
> +++ b/man/mmc.1
> @@ -30,21 +30,24 @@ This sets the eMMC to be write-protected until next boot.
>  Set the eMMC data sector size to 4KB by disabling emulation on
>  <device>.
>  .TP
> -.BR "gp create <-y|-n> <length KiB> <partition> <enh_attr> <ext_attr> <device>"
> +.BR "gp create <-y|-n|-c> <length KiB> <partition> <enh_attr> <ext_attr> <device>"
>  create general purpose partition for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  To set enhanced attribute to general partition being created set <enh_attr> to 1 else set it to 0.
>  To set extended attribute to general partition set <ext_attr> to 1,2 else set it to 0.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
> -.BR "enh_area set <-y|-n> <start KiB> <length KiB> <device>"
> +.BR "enh_area set <-y|-n|-c> <start KiB> <length KiB> <device>"
>  Enable the enhanced user area for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
> -.BR "write_reliability set <-y|-n> <partition> <device>"
> +.BR "write_reliability set <-y|-n|-c> <partition> <device>"
>  Enable write reliability per partition for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
>  .BR "status get <device>"
> --
> 2.31.1
>
