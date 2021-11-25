Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C89DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 13:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355603AbhKYNnz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353909AbhKYNly (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 08:41:54 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20120C061763
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 05:31:03 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k2so12565658lji.4
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W99VDr/uXXoqmoSqUiOQmZpQjn4jb8DokYK8Ns8t9TQ=;
        b=ROaixL6GG/skenOqGk8XXStB+8ZS59DslkTuAs/FiK9h0rXwR1XxXFoNMk13FVo1zp
         k2lNH0n0dUz2PXx21IqWNd+rfqbfICAevga7zLZGJrvZ9CICJSK4jEsqgBbtnXIUoict
         UlW/zn6+WsCYTQ7aM/9+MK01R3rfFFzkzm+8quS+n6dhcWksejpaDb6bF//SguyRRaW3
         5/mB5s2mujNVY1l/u3BEtb2VefJcgFGU2QKDd8fw4NRRfW78gQWAHxxCs5d7wx4daBfu
         PR6TJJgaM1EGFR6kVpc6aEXbbyHRcshG1tQKu71w8aIPNRljssHw4wqSn7RU61Nz+z0S
         Eo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W99VDr/uXXoqmoSqUiOQmZpQjn4jb8DokYK8Ns8t9TQ=;
        b=LP4RzIsbOEwfaxwZQRiM+ZHEdYopRFBona/Msfx6wAfToHTa1LefPip6hFzXNtTPYh
         cffDJwd3Ca+tmKJSOR48cAl6eBin0q3iq9umTdWzYS1ckWpomnq8+CoMJtuP33zf1RkD
         wQuWElEVm2LmBzvixqoo6UFyJAa5YNKjKjmHvOeYXn1jav/65DDyPO1fmIDjEzUsBFfK
         7fqQSg4k+x5TFVm+D6ikVeSJw81ncnz7rnA5h9IRcdlsJBfdu45TR8rrXCc3J08PITKt
         4vdga32QpDv+D9LEDMgMRCvtPcFzRDZ4eb2q477XAGF8BXHleuP8GGXZlzZQRm48hT1d
         /ngQ==
X-Gm-Message-State: AOAM531QqmPIS69xH5SLFKNloLISVDex8cvTX0XBMH5zCZbdv0mshk3S
        3afabsAgeHhMPFfhE+zyDdXHbfTVZ8l6Xe60pHOODQ==
X-Google-Smtp-Source: ABdhPJyYqrNXA9Jp/auzbHG8nUKhEpqjD6vu9em0QwNP1xMh7lwdO2R4cKTkHqtKm/HtAu4g8W5fxt6stHu/Hb3pVTc=
X-Received: by 2002:a2e:93c4:: with SMTP id p4mr9910424ljh.367.1637847061364;
 Thu, 25 Nov 2021 05:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20211116105109.3830-1-oleg@kaa.org.ua>
In-Reply-To: <20211116105109.3830-1-oleg@kaa.org.ua>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Nov 2021 14:30:24 +0100
Message-ID: <CAPDyKFpD4rfYn9B23+bS7WU_V6vrBdwa2RMnhOKuiSdT35fLUg@mail.gmail.com>
Subject: Re: [PATCH] Fix strncpy() usage
To:     Oleh Kravchenko <oleg@kaa.org.ua>,
        Avri Altman <avri.altman@wdc.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri, Bean


On Tue, 16 Nov 2021 at 11:51, Oleh Kravchenko <oleg@kaa.org.ua> wrote:
>
> Manpage of strncpy() says:
> If there is no null byte among the first n bytes of src,
> the string placed in dest will not be null-terminated.
>
> Put \0 to the end of the buffer to ensure that
> the destination string is NULL-terminated.
>
> This patch also fixes a compile error with a newer version of GCC.
>
> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
> ---
>  mmc_cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 73bd32a..016fe70 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1834,8 +1834,8 @@ int do_read_extcsd(int nargs, char **argv)
>         }
>
>         if (ext_csd_rev >= 7) {
> -                memset(lbuf, 0, sizeof(lbuf));
> -               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> +               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], sizeof(lbuf) - 1);

This may look better, but is actually making it worse. lbuf is 10
bytes long, while the ext_csd is 8 bytes.

> +               lbuf[sizeof(lbuf) - 1] = 0;
>                 printf("eMMC Firmware Version: %s\n", lbuf);
>                 printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
> --
> 2.32.0
>

Kind regards
Uffe
