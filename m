Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444DEC433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Oct 2022 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGNGh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJGNGg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2022 09:06:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B63C90E1
        for <linux-mmc@vger.kernel.org>; Fri,  7 Oct 2022 06:06:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so4643391pgs.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Oct 2022 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+43/3kVmg+p0ZcrIutD7soToeLt75gKyvKftIXwuQM=;
        b=MMItm/KHcYIuEHKofG7TqERR/uBgZrV+dMXPEImmiUIGfdJUSWE6arVGFUQejv3Juq
         +TmSWp4oLXVYERQWggvLB56hUgLpa10/CNthXnYqbAvL+qUXTXVgUoro3VyXCc8Nuu1G
         udo/4pBxClWMBvxGBx9hRGe44YqgpqCcdSdW7WCP/ARYL6dRfw+x0G2VUi4Zvx/X6+G/
         KT7aJH14eny+pe3SugMtM94voUMP/GnJdhaJGrnlKZyD1nRhl3FA1RxDiHmV0J2Txmg8
         5aTfw/fDpveiyaGFk93kgaHT7+cdwOOudVzGRDXjkjiyaqvvkzbkZmyvxwgkJlbaNLGP
         AH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+43/3kVmg+p0ZcrIutD7soToeLt75gKyvKftIXwuQM=;
        b=0BXf7HYlGb+rgE1nSKytTem9xL2LBIVPoqBq480Tr/4bIDV53nnPXZQQdj9Dbix3Ta
         OZvP9DMDpAYXhRcaBRrpH3DxbRRV8HlzSgCWWzncpJmabeoa0lotNW4Vjhg4GXu0w4QQ
         zGoe9DCjfrFHHtxxIk3/mIb8CkXK0mt/TkdxpHDjityeMO8cvZHGR5xpRbkya6NLeHyY
         g7BAzecwm9cc6FEDP2EB40mlB1i+uuMNT/LDRTWvgYtB6oWj81i+Xqdnb6lpvJHXGJtf
         v3VgS5fao6J+EuyMKPxuCvJLGjrw18sLsju7SMvhxVJs9Bt8KvYf5dSZibDKZc8dd5wK
         OiBw==
X-Gm-Message-State: ACrzQf31fymx6MjI7py8YquhAJRNmPmby6purY1JUk1qIX78yw3gPun1
        Y9mdx+XweInwlWw93XjylWu5JGXb0vh+mfQoZKWHXA==
X-Google-Smtp-Source: AMsMyM5TRUSbtI2WM9EMCH1IPwq1jrFcd6+1f4s/3V5O2kRDaK+r3Yq7Af/vyH1PbUMJd+F2l6YUFvUr8B47svNEwQc=
X-Received: by 2002:a63:90c1:0:b0:450:75b5:29fe with SMTP id
 a184-20020a6390c1000000b0045075b529femr4361488pge.541.1665147994580; Fri, 07
 Oct 2022 06:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <cc0d807fbd2f4001adef8728f957c696@hyperstone.com>
In-Reply-To: <cc0d807fbd2f4001adef8728f957c696@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Oct 2022 15:05:57 +0200
Message-ID: <CAPDyKFpvsDoLherwwyR5f7oJ0Fdwu6HV0MLgX+DrHkXkQrwbLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: block: Remove error check of hw_reset on reset
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Oct 2022 at 15:38, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Before switching back to the right partition in mmc_blk_reset
> there used to be a check if hw_reset was even supported.
> This return value was removed, so there is no reason to check.
>
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|s=
w_reset()")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..8531f92fd0cb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -991,6 +991,8 @@ static int mmc_blk_reset(struct mmc_blk_data *md, str=
uct mmc_host *host,
>                          int type)
>  {
>         int err;
> +       struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
> +       int part_err;
>
>         if (md->reset_done & type)
>                 return -EEXIST;
> @@ -998,20 +1000,14 @@ static int mmc_blk_reset(struct mmc_blk_data *md, =
struct mmc_host *host,
>         md->reset_done |=3D type;
>         err =3D mmc_hw_reset(host->card);
>         /* Ensure we switch back to the correct partition */
> -       if (err) {
> -               struct mmc_blk_data *main_md =3D
> -                       dev_get_drvdata(&host->card->dev);
> -               int part_err;
> -
> -               main_md->part_curr =3D main_md->part_type;
> -               part_err =3D mmc_blk_part_switch(host->card, md->part_typ=
e);
> -               if (part_err) {
> -                       /*
> -                        * We have failed to get back into the correct
> -                        * partition, so we need to abort the whole reque=
st.
> -                        */
> -                       return -ENODEV;
> -               }

Yes, this is certainly restoring the behaviour and fixing a bug. Thanks!

However, I do wonder about what's the point of trying to switch back
to the correct partition if the mmc_hw_reset() failed (returned a
negative error code). It looks like that shouldn't matter, if the
reset failed we are screwed anyway, right?

> +       main_md->part_curr =3D main_md->part_type;
> +       part_err =3D mmc_blk_part_switch(host->card, md->part_type);
> +       if (part_err) {
> +               /*
> +                * We have failed to get back into the correct
> +                * partition, so we need to abort the whole request.
> +                */
> +               return -ENODEV;
>         }
>         return err;
>  }

Kind regards
Uffe
