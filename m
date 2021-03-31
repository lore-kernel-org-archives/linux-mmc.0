Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C42C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE60E619BC
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhCaJmA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhCaJl0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:26 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676DBC061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:26 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f19so4762557vsl.10
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7thnfOhrpF9CIgHxhgC8Pn3ZLLp6FVJXN1H55WEU4Sg=;
        b=dkwJmJvYqtDNF0OT8MyIlr3AwemDo35Aa/kVjCumWODJnNCU6pqgwbF0AGyzTmFqwV
         mmNTSnbwTzdnMJIIkb0yTpQvWCYGEtOXQPMot7GtJiaewb+rl+1++qmgA+4GLpsAFphU
         OP29G7NF7R6oUdM5sO7gToab7aQlb1vIpkW8oAbYksdLE/KjEDQw819WBZYge5BXIalh
         2Ggl27VisRbzV+NSwj8shty853O2kAFYlKpmzaTu8DHxnK154dEdJ4U4diwGAhe+rjVw
         9M4sgphHddPBShXr8jSpanGAaztgGW5tR8dZ8R/elOfXncVg8dtz7N3B3BVN+jyZajwI
         /bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7thnfOhrpF9CIgHxhgC8Pn3ZLLp6FVJXN1H55WEU4Sg=;
        b=fiYkDUopZnA/b4GA8Fk0zVqvvuI9kBuygwsFii1goJmw222Ho9+QJDn3dqQMgElSkd
         zVdwitaeyU4HqXHpPKnBljMuKRTS7a4URRI9DQ53w8e5aPlLPLk2lX60HxjNO7Xy2dWj
         n+IcZ4bX6ulzSHjf3XeZSX2fWHL8dif8v6ivz9AkXJ1grjl6slmNl0LdGU8pbn1a8aai
         ehNETrF38Ey+ToZ28rGm52T2P8iPkqc+nti40jQDWghu0M83qedBJUw0W/oUHdayiTsW
         j0Yega/38lwAPhAmyrqpMN72eDb8dFAz0GQwkqwKZPejbzspF0M61E7uA8b6fn6ab2Ai
         B5KA==
X-Gm-Message-State: AOAM533FhpjCu33LYfCUmxU7w8pmWm/ZomZXpo/zGbDJJ3/GXroBk31s
        BqQZodiO+DozBdLSM9k5Wp1x9FpInbNoh4uw8j2dKg==
X-Google-Smtp-Source: ABdhPJxlaXkg7/5TFDOMAFCEWssugW2x48TMbMANaRHoraS+DljFUJ9YK9xcB0KCpPb7ph8upJ0NEw0eZzYrZBBd6XM=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr928170vsc.55.1617183685612;
 Wed, 31 Mar 2021 02:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191111110051.16490-1-lapeddk@gmail.com>
In-Reply-To: <20191111110051.16490-1-lapeddk@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:49 +0200
Message-ID: <CAPDyKFpPUbwPVZOtvLrjzv5GBASbDhHS1fj2FRVqAKczEwYTTw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc-utils: Add AUTO_EN support in the BKOPS_EN
To:     Lars Pedersen <lapeddk@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, michael.heimpold@i2se.com,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Nov 2019 at 12:01, Lars Pedersen <lapeddk@gmail.com> wrote:
>
> This patch adds support to enable auto(AUTO_EN) and
> manual(MANUAL_EN) in BKOPS_EN register. Auto bkops
> can only be used on eMMC 5.0 or newer.
>
> Signed-off-by: Lars Pedersen <lapeddk@gmail.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> v3:
>  - Simplified setting of auto and manual BKOPS into old
>    bkops_en function.
>
> v2:
> - Added signed-off-by for patches
> - Dropped patch for BKOPS start support, since its already
>   controlled in the host controller. (mmc_run_bkops)
>
>  mmc.c      |  9 ++++++---
>  mmc.h      |  5 +++--
>  mmc_cmds.c | 23 ++++++++++++++++-------
>  3 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/mmc.c b/mmc.c
> index 50c9c9e..513fb78 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -120,9 +120,12 @@ static struct Command commands[] = {
>           "<boot_bus_width> must be \"x1|x4|x8\"",
>           NULL
>         },
> -       { do_write_bkops_en, -1,
> -         "bkops enable", "<device>\n"
> -               "Enable the eMMC BKOPS feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
> +       { do_write_bkops_en, -2,
> +         "bkops_en", "<auto|manual> <device>\n"
> +               "Enable the eMMC BKOPS feature on <device>.\n"
> +               "The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.\n"
> +               "Setting auto won't have any effect if manual is set.\n"
> +               "NOTE!  Setting manual (MANUAL_EN) is one-time programmable (unreversible) change.",
>           NULL
>         },
>         { do_hwreset_en, -1,
> diff --git a/mmc.h b/mmc.h
> index 648fb26..027cf57 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -126,9 +126,10 @@
>  #define EN_REL_WR      (1<<2)
>
>  /*
> - * BKOPS_EN field definition
> + * BKOPS_EN field definitions
>   */
> -#define BKOPS_ENABLE   (1<<0)
> +#define BKOPS_MAN_ENABLE       (1<<0)
> +#define BKOPS_AUTO_ENABLE      (1<<1)
>
>  /*
>   * EXT_CSD field definitions
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..f433f6f 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -734,13 +734,15 @@ int do_write_bkops_en(int nargs, char **argv)
>         __u8 ext_csd[512], value = 0;
>         int fd, ret;
>         char *device;
> +       char *en_type;
>
> -       if (nargs != 2) {
> -              fprintf(stderr, "Usage: mmc bkops enable </path/to/mmcblkX>\n");
> -              exit(1);
> +       if (nargs != 3) {
> +               fprintf(stderr, "Usage: mmc bkops_en <auto|manual> </path/to/mmcblkX>\n");
> +               exit(1);
>         }
>
> -       device = argv[1];
> +       en_type = argv[1];
> +       device = argv[2];
>
>         fd = open(device, O_RDWR);
>         if (fd < 0) {
> @@ -754,12 +756,19 @@ int do_write_bkops_en(int nargs, char **argv)
>                 exit(1);
>         }
>
> -       if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
> -               fprintf(stderr, "%s doesn't support BKOPS\n", device);
> +       if (strcmp(en_type, "auto") == 0) {
> +               if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> +                       fprintf(stderr, "%s doesn't support AUTO_EN in the BKOPS_EN register\n", device);
> +                       exit(1);
> +               }
> +               ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE);
> +       } else if (strcmp(en_type, "manual") == 0) {
> +               ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE);
> +       } else {
> +               fprintf(stderr, "%s invalid mode for BKOPS_EN requested: %s. Valid options: auto or manual\n", en_type, device);
>                 exit(1);
>         }
>
> -       ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
>                         value, EXT_CSD_BKOPS_EN, device);
> --
> 2.23.0
>
