From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 12/45] drivers: mmc: remove duplicate includes
Date: Fri, 15 Dec 2017 10:18:27 +0100
Message-ID: <CAPDyKFoQCJdNVCWth7yQ5FExwmR5FoNROCo9bhOiKh9QaHLv5A@mail.gmail.com>
References: <1512579423-5405-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33329 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755220AbdLOJS2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 04:18:28 -0500
Received: by mail-it0-f65.google.com with SMTP id o130so28772301itg.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 01:18:28 -0800 (PST)
In-Reply-To: <1512579423-5405-1-git-send-email-pravin.shedge4linux@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 6 December 2017 at 17:57, Pravin Shedge
<pravin.shedge4linux@gmail.com> wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>

Thanks, applied for next with an updated prefix of the commit msg header!

Kind regards
Uffe

> ---
>  drivers/mmc/host/android-goldfish.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index 63fe509..63d2758 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -42,13 +42,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/clk.h>
> -#include <linux/scatterlist.h>
>
>  #include <asm/io.h>
>  #include <asm/irq.h>
>
>  #include <asm/types.h>
> -#include <asm/io.h>
>  #include <linux/uaccess.h>
>
>  #define DRIVER_NAME "goldfish_mmc"
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
