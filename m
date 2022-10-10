Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Oct 2022 14:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJJOSL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJOSK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2022 10:18:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632872EEC
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 07:18:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso10495605pjk.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYF5XS2JRFV9RPZlZQCkeQ7ajMqkoP9Kb8xnQ89udwg=;
        b=fAa2MreMKKkd1H1c0EFMeRSx66lm2KgySkNtomiIctPKLFYqhflzFtRQAtBSFdzAUm
         TekKZCVMsTgzyqdlfzljUDWlnOuvumJLkC4mZTYcPYCjk2y0PrPuCK7smn9Vbl+mIATD
         61+Rnkeg5yyh2iLOW8llDxwkC/SAdmiKhv93C68NsmBNraNYBDWPCrEVZAks2JZLlyg5
         i0XFcf60Tc/k5GNHwVNHLIKDB6P7XLcFh7ISPipmV8ocKSBUPXICn/0gFpyN6T13yXzM
         g9OWanMfxhDad/haH6p3bn/3EVj8mgiuV4P537sz6zcLMS3CuhG4oCs1cFYUc5SNZ1HT
         3wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYF5XS2JRFV9RPZlZQCkeQ7ajMqkoP9Kb8xnQ89udwg=;
        b=S1ieoKv8ilnKUi/r6s0T7mXj6RIzXv5NpavVCMQxbw6CSISoXnOc+PxQ7yNKz8ECQz
         AlVQ4yRjsZdCJnVv+c1LZWgWAV+J241d6O/OeghZd6wJZ6rRBbYN1Cme/6ALlM18whp0
         BBASZQqFkGzuUTXO3ZFDX0JAjoCadZ8oMaH5DGHun2TrUI8bOdpj963ZMYMR7JQpo9SS
         ZictsASkpcjoaW7QblFpNxVzwgoqGkuprfLN/Vg17EXghBaOjsZ28DkY8hcmVpr2YfrB
         fxCgWzTBruYAYZisSXhayjc1cbBl4Wm9/E5W1yFOtz6QLJk7o8l8+r66CeZx/dJMGPae
         RIkg==
X-Gm-Message-State: ACrzQf3KyN8KmIubHBXfenUimR1QNq+5WEu8JB+IhdKvBOxNnGMVz67k
        wQrLslegzCO1JnkOp6MoDUd9mLMaYbwCZ2qzU4fMwsQ9+JY=
X-Google-Smtp-Source: AMsMyM4cUhV2VK+DCH3t4qIVuINv2HYwLfI0bQXnnILy2R1uC12MfGL19P8PiNkYgdiH3TS7uOCOjOJ8aStP8SpR6GU=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr20026551ply.148.1665411488088; Mon, 10
 Oct 2022 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
In-Reply-To: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Oct 2022 16:17:30 +0200
Message-ID: <CAPDyKFrxDBnOZXD_e086ODRFthKVrsTTU9jgsWayXXkHby2RLQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on reset
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Oct 2022 at 16:03, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Before switching back to the right partition in mmc_blk_reset
> there used to be a check if hw_reset was even supported.
> This return value was removed, so there is no reason to check.
> Furthermore ensure part_curr is not falsely set to a valid value
> on reset or partition switch error.
>
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|s=
w_reset()")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

This looks good to me, however I am awaiting and ack from Adrian
before applying, to make sure we are all aligned with the approach.

Kind regards
Uffe

> ---
> -v3: Ensure invalid part_curr on error
> -v2: Do not attempt to switch partitions if reset failed
>
>  drivers/mmc/core/block.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..45a44edcc31a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -134,6 +134,7 @@ struct mmc_blk_data {
>          * track of the current selected device partition.
>          */
>         unsigned int    part_curr;
> +#define MMC_BLK_PART_INVALID   UINT_MAX        /* Unknown partition acti=
ve */
>         int     area_type;
>
>         /* debugfs files (only in main mmc_blk_data) */
> @@ -991,29 +992,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md, s=
truct mmc_host *host,
>                          int type)
>  {
>         int err;
> +       struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
> +       int part_err;
>
>         if (md->reset_done & type)
>                 return -EEXIST;
>
>         md->reset_done |=3D type;
> +       main_md->part_curr =3D MMC_BLK_PART_INVALID;
>         err =3D mmc_hw_reset(host->card);
> +       if (err)
> +               return err;
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
> +       part_err =3D mmc_blk_part_switch(host->card, md->part_type);
> +       if (part_err) {
> +               /*
> +                * We have failed to get back into the correct
> +                * partition, so we need to abort the whole request.
> +                */
> +               return -ENODEV;
>         }
> -       return err;
> +       return 0;
>  }
>
>  static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int ty=
pe)
> --
> 2.37.3
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
