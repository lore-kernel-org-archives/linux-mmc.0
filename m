Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2733C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09E46162E
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 09:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhI3Jvo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhI3Jvn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 05:51:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52241C06176A
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 02:50:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y26so22829878lfa.11
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJx8pIQCsPj1X7ycrMuTBNaBLiw8czLCIx9BhQ8QcE4=;
        b=tM0/2w7JSYxfLYxBYVuPa3113sp4Gj38VHlGsPmQxIotTzhJ6AhGr9xI6LbJcSeZ1S
         hdS5anqvpfMUkl6VMVWMc2dFy0Xocgun8saN+1am4IWuv0feS+ZYc+D/BFMzOqiWOuz1
         wZTEMmz37ZNSCv9PA61eLHM1cJo3HMtIErOImJSHVP4S9PGjZZrig0MULhd32R4C9c+q
         Vi608m/B1fmPvnG0x7EdeyAshIGjVzgoVXsUttyYTikXXI2AKU4Y2NOSCfMfeNNT6Bot
         ZvlC410+ZhTTnpOmCitoI4W3t4i5npLvDuR0V+lrJ7ovqQfEjHPevKb8BeCB4q07qJ/j
         d+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJx8pIQCsPj1X7ycrMuTBNaBLiw8czLCIx9BhQ8QcE4=;
        b=c4P/z9fiPMWc6AYuHjzg+y9cVvG4+hy7zWspxo7lT2nsBQ4wP/PAZu8rHDP/9PF2RV
         va+6JTkbWGEG10ygfOLOFPzQiEAzetGNAKUPMb7PE63S4d6+5UDcHiPTVKh/A3thL5sW
         2MQj9+e9AsEMnxqnzEAXiclXd0N7mBisrUc0f/a9DvMtAY6IC2MOxnkc4BCE8ljrq7TJ
         sn/q192+Y3IeUQTdeLGvwqDzoBIgVx2nMYDhC0CZd58e1L7TTv/CiUz7gpSqwHFFimn5
         X9hn6tQRjJmryhpGrbBPccG0h/jw7xmsXehuAkAUtv54LmU+uMHXp5+s+cQoZI6cjrs4
         zo4w==
X-Gm-Message-State: AOAM532nQ9p56jP9pCkhqGv8Rgq57nKzRMd4DHqoYFZJV1mIGnFiT+Vm
        /QUj1OBPD+qOXzvgv5pzKvsfK1ADLxEaae/NBSBBRfRrzVo=
X-Google-Smtp-Source: ABdhPJzdkIRaaydiS+Tqd+POqbjG8Fha7Sm8vM/GvOrYnDB+uccXVH43V1v5Bydo8jUTGcyBl/oOS8aWFLy3Jje7mc4=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr4712439lfi.184.1632995399672;
 Thu, 30 Sep 2021 02:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210920194633.814-1-mhei@heimpold.de>
In-Reply-To: <20210920194633.814-1-mhei@heimpold.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 11:49:23 +0200
Message-ID: <CAPDyKFqARRDCXZTRLxrjtBX5h-KOBkKNq6B55DeXJtDsQJVZcw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc-utils: One further optimization of trimming routine
To:     Michael Heimpold <mhei@heimpold.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Sept 2021 at 22:01, Michael Heimpold <mhei@heimpold.de> wrote:
>
> The last change to the trimming routine made it more efficient,
> however, we can even get rid of the memmove() as we leave the
> function with strdup() anyway.
>
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to the master branch at
https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git, thanks!

Kind regards
Uffe


> ---
>
> While doing some house-keeping, I found this somewhat older
> patch still hanging around (v2 was sent on 2018-12-08).
> I'm just resending to check what's the current opinion
> about it :-)
>
>  lsmmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 06cc0b8..05d59e8 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -393,10 +393,9 @@ char *read_file(char *name)
>                 start++;
>                 len--;
>         }
> -       memmove(line, start, len);
> -       line[len] = '\0';
>
> -       return strdup(line);
> +       start[len] = '\0';
> +       return strdup(start);
>  }
>
>  /* Hexadecimal string parsing functions */
> --
> 2.17.1
>
