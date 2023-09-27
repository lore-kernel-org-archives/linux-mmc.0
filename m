Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D73E810CB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjI0LGN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjI0LGN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 07:06:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49913A
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:06:11 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so7562296276.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812771; x=1696417571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4ub4TijbV5CjeH5USotoPNKtWBSdIziCk37JFpFZX4=;
        b=DkyALiRcIlM2J/i9MAt7Anh0DDSuh9i7QlKrjWe9hoXYcrR1puzY011tOzOZZfFyiH
         uUv4zgxfTv7udWX/3WuCEfZWma90DAXrszyDOBZdcrVTphyPSHjUb09Sagv4A713JygP
         JKzqwJ9+OkcCu22Jz+1zfzt4FApRB0Ji68Zv1yGbIgyRCOQq0JEOcWDg9OCq5AKiKS6a
         33AIiCtCsINlt8Bnb0l7h5eky+L6/MbPgPVCYmyEJV+U4r0LjCC2zf/xl5K0LLFphFfT
         YD9ezI9j7ws8FhQPvhVgPYqo7vmUSfHWl4JFLgMBicDR5WCbZOOTTNEXEAdHvQKUqiMx
         KvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812771; x=1696417571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4ub4TijbV5CjeH5USotoPNKtWBSdIziCk37JFpFZX4=;
        b=pFPX9BJK2CC+nT8RWj4tLP2Z5zeGeBSQODAuGxmonlp6c/J+ClcP0byNOxLpHuUsWn
         EBeAFVPzSaL1TGR953Esume2ZWatf9xj5euOT/DUdPr0ekwL/gTk249Jeywim1Y8STOs
         Ov17Y2vYrnA7PqWrgb1IW7h8/ZSkdqtJ6n5pi4iHztnNBR35Hc74Tk40OUQF5pMhtA8Z
         GEm0MlnDp/di6l/c2jzunYKdbn+bjHoXju4pXOqUywjcuSOqcDm15QmTm6+VvMjCiSnk
         n5oed3X8e75BYzBMwO7Z5C8pBGAqljC7Yf1qlKnjmalD7olmS4vg6RZ43reUdXkNSzGI
         kCrA==
X-Gm-Message-State: AOJu0YyWj0XsdW3TYskH+3BhJJVDKF3NcdBMcCQCaxUst3HBaO4abmun
        hEpOY898ih9uLFzt6EP+IrSwfVlyzaeZJYrC8O+mU8j9ZHdS8kFR
X-Google-Smtp-Source: AGHT+IEtr3gA4iTpK2V5eHgA+qx3H0pV2P/WRG8VFkDZEJy3LBNHVUay5ImzeEbUAjAlU6o6vQnocRUf1i+Tu4gBBFY=
X-Received: by 2002:a25:6c8b:0:b0:d89:4829:6a63 with SMTP id
 h133-20020a256c8b000000b00d8948296a63mr1586833ybc.65.1695812770950; Wed, 27
 Sep 2023 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230926100006.1789276-1-avri.altman@wdc.com> <20230926100006.1789276-2-avri.altman@wdc.com>
In-Reply-To: <20230926100006.1789276-2-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 13:05:35 +0200
Message-ID: <CAPDyKFprWgSvc07fSVTrz7qyP-cuVXVvMerPnNre6Nu1d7J42A@mail.gmail.com>
Subject: Re: [PATCH 1/5] mmc-utils: lsmmc: Reuse do_read_reg
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Sept 2023 at 12:02, Avri Altman <avri.altman@wdc.com> wrote:
>
> All 3 register parsing: CID, CSD, and CSR follow the same structure -
> reuse it instead of duplicating the code 3 times. No functional change.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 59 +++++++++++++++++++--------------------------------------
>  1 file changed, 19 insertions(+), 40 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 54c3167..85779bb 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -2373,7 +2373,6 @@ int lsmmc_main(struct config *config, int argc, char **argv)
>  {
>         int ret;
>
> -       memset(config, 0, sizeof(*config));
>         config->mmc_ids = calloc(IDS_MAX, sizeof(char *));
>         config->sd_ids = calloc(IDS_MAX, sizeof(char *));
>         if (!config->mmc_ids || !config->sd_ids) {
> @@ -2395,71 +2394,51 @@ void lsmmc_free(struct config *config)
>         free(config->dir);
>  }
>
> -int do_read_csd(int argc, char **argv)
> +static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
>  {
> -       struct config config;
> +       struct config cfg = {};
>         int ret;
>
> -       if (argc != 2 && argc != 3) {
> -               fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
> -               exit(1);
> -       }
> -
> -       ret = lsmmc_main(&config, argc, argv);
> +       ret = lsmmc_main(&cfg, argc, argv);
>         if (ret)
>                 goto out;
>
> -       if (config.dir)
> -               ret = process_dir(&config, CSD);
> +       if (cfg.dir)
> +               ret = process_dir(&cfg, reg);
>
>  out:
> -       lsmmc_free(&config);
> +       lsmmc_free(&cfg);
>
>         return ret;
> +
>  }
>
> -int do_read_cid(int argc, char **argv)
> +int do_read_csd(int argc, char **argv)
>  {
> -       struct config config;
> -       int ret;
> -
>         if (argc != 2 && argc != 3) {
> -               fprintf(stderr, "Usage: Print CID data from <device path>.\n");
> +               fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
>                 exit(1);
>         }
>
> -       ret = lsmmc_main(&config, argc, argv);
> -       if (ret)
> -               goto out;
> -
> -       if (config.dir)
> -               ret = process_dir(&config, CID);
> +       return do_read_reg(argc, argv, CSD);
> +}
>
> -out:
> -       lsmmc_free(&config);
> +int do_read_cid(int argc, char **argv)
> +{
> +       if (argc != 2 && argc != 3) {
> +               fprintf(stderr, "Usage: Print CID data from <device path>.\n");
> +               exit(1);
> +       }
>
> -       return ret;
> +       return do_read_reg(argc, argv, CID);
>  }
>
>  int do_read_scr(int argc, char **argv)
>  {
> -       struct config config;
> -       int ret;
> -
>         if (argc != 2 && argc != 3) {
>                 fprintf(stderr, "Usage: Print SCR data from <device path>.\n");
>                 exit(1);
>         }
>
> -       ret = lsmmc_main(&config, argc, argv);
> -       if (ret)
> -               goto out;
> -
> -       if (config.dir)
> -               ret = process_dir(&config, SCR);
> -
> -out:
> -       lsmmc_free(&config);
> -
> -       return ret;
> +       return do_read_reg(argc, argv, SCR);
>  }
> --
> 2.42.0
>
