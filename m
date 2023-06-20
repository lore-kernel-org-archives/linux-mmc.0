Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01677EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFTKO7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFTKOm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:14:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9361B0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:39 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3fdec2ed972so20986571cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687256079; x=1689848079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vOsoVhAS5zcveo7bpV9oedUbfz6CmPMgIriAPmX3UMM=;
        b=dqSZd1k0m2oMqHAG5Kzcyhv59o5mUYzUHTdE4QROXsi6T3LMjk/EkEpWxKM7TOuoC9
         0TuLHd8mRSE5jN4Dvq/8N1lm84uzlLdY9u1NpyqZsc1hRInuc/FuAf6Utl9+7KUq3jLz
         /nd3jZOrXQUqyht2rFwePB26kXkCAbaCBx2G5Y/NYc+Izt6yASDdyY/Z1Yp7qwVWjQSo
         RAaeNhYX1E8PVlxLsdCZuc/yX6Ee7f/iY4etJUQXgGHap8929IHDYrv/c/YGBX6uXfOb
         Tc7u5U94N+3TGbTLVxx08kvc8XE3+ZfEHET9796DPQUeNHMJwgRAuOguB9teGjj37QCU
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256079; x=1689848079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOsoVhAS5zcveo7bpV9oedUbfz6CmPMgIriAPmX3UMM=;
        b=VNVZQpMnBmQl+WtfjUlPqEEyTpNShKpyEORKlIrs430d5DMUn6WfmE+FNo7Ultew+N
         3HP++/Xnzv7MtoB9XrFvhrAFm5jtp9YKfVkg4pGP8EAxZCHiPKzOLFon6KEEq4B1KOiI
         yX84bVTvPL/VY0NGVAByhbaJeuGyrSws2mBNz/BT9yLrjSXwMAZ+8HsnYZNdklrGQe58
         jPACSyVrUcVWjuNTPItR0e9jB7C0tmfEY54/LUWPg16To+EZMqLtdCPcWpUJge1yrY1m
         eHQLMnfDGeN9UtlYnKl1iIB6Q2yuWY3IXuU1Zlw9xN1tSfibA3aQ0wwZkm0ml4Ux2n/d
         +lRw==
X-Gm-Message-State: AC+VfDxGCP2tIaECzGE5Xu23c1SK1KAdfk8+RtPhxw5g2vJQMTHObr2B
        oWlSxLVicMmQ47QWHxk3I6N4qTxw7biGII8qumqegQ==
X-Google-Smtp-Source: ACHHUZ5IdkRPnclg6EB+h7WL8/vvt+mm1fTCydySHl7y0/n0aNxeAA7WUuzTsnGWS3VG771j3zA6UJOWsYsr1NA1KC8=
X-Received: by 2002:a05:622a:d5:b0:3f6:af57:e707 with SMTP id
 p21-20020a05622a00d500b003f6af57e707mr15370974qtw.51.1687256079058; Tue, 20
 Jun 2023 03:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230619193621.437358-1-robimarko@gmail.com>
In-Reply-To: <20230619193621.437358-1-robimarko@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 12:14:03 +0200
Message-ID: <CAPDyKFq1ez9NpTGZMLEody4TtWM=hjGbpETdqnw=7aLFTtcvZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: disable TRIM on Kingston EMMC04G-M627
To:     Robert Marko <robimarko@gmail.com>
Cc:     windhl@126.com, avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Jun 2023 at 21:36, Robert Marko <robimarko@gmail.com> wrote:
>
> It seems that Kingston EMMC04G-M627 despite advertising TRIM support does
> not work when the core is trying to use REQ_OP_WRITE_ZEROES.
>
> We are seeing I/O errors in OpenWrt under 6.1 on Zyxel NBG7815 that we did
> not previously have and tracked it down to REQ_OP_WRITE_ZEROES.
>
> Trying to use fstrim seems to also throw errors like:
> [93010.835112] I/O error, dev loop0, sector 16902 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 2
>
> Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
> to disable TRIM.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/quirks.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 77caa0c903f8..8decb788a3db 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -107,6 +107,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> +        * support being used to offload WRITE_ZEROES.
> +        */
> +       MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
> +
>         /*
>          * Some SD cards reports discard support while they don't
>          */
> --
> 2.41.0
>
