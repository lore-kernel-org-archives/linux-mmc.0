Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E550C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379636AbiBHPNF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379567AbiBHPNA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 10:13:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6700C06157A
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 07:12:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f18so4746874lfj.12
        for <linux-mmc@vger.kernel.org>; Tue, 08 Feb 2022 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY+ZwWuclulJI/EwOyt3HfpGBKh0j1b2t2Y9v5DNXi8=;
        b=auyWIb560YDBZgxQ+7OPHdI3+Lqo83TPiIjcFYkbblxBRMFFEIe2E8bsh3fAURQSLu
         aRXfghU1TI8d+lNsHTcKsoTwbu58W295bQeMVaVtHL/bH2DFE6Y03kUsO13rs8sBm7ZE
         HVKMGWQ0+NDCLpyu2kuDnku/HWQuS26qepMfArKY675ojGrdyrjMtPqLi1+BNDRBqmR0
         airc6G2Mm3Hcw6Mhk1W/XcwR8Kk1rAcws4h/d/oNfcmNdH5isJXYkpktedY+epgoMkFK
         Oeab11MGDoz+xwdm5CAjQzbFsa6Bv398hWNbUR1Cb3pqEzPXGgDlannnzEtFwuqsjVr5
         P9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY+ZwWuclulJI/EwOyt3HfpGBKh0j1b2t2Y9v5DNXi8=;
        b=THbtCnhQVSjmW8g6cnCe2bcVg6R+9kr6bv49956pp2DdwWLDVuf+n3oJ6y/qFrBTv1
         T6nQsdCsqWpmFVuunY6Wm5z/HBii66X7qXh9fey+hV+1uWgELLSu7KHBykIFDWpCawxa
         EoXscVSe0h+h6ILlOiP6yCl5jZXZDNw0xwP4BT9vYzDnd/anqHtT65z6bov7LuSbyQqA
         99Mxgfb/juuAOf2DakNnb004zfxxvU6mg+zPB4I6jjhrVQecRODlz+J6k27YNr7A/8hg
         3OwNWfsKlPBGqSuyaiswX2AjCxHW5ITMTpGS8WjGo5gz+Tcl0UeWRCnaf+cpggpJsoEe
         NcqA==
X-Gm-Message-State: AOAM532qxUfIRWTbb8qOQgjM3UvcPVBW79AfCJY4s8vKTggSmaKHVh7d
        ToS1ttxwnVS4TxnldhhIU+3y0ZiCiOURtHP3yJlDQw==
X-Google-Smtp-Source: ABdhPJwpIIFNjHK3W8/1s65m+yFXwfDxcycoN/0meGoeCtTH4S7LjjaHRz97NGZxNQWJ4wtJjt3eVrTKsfZPa2uoHkE=
X-Received: by 2002:a05:6512:3ca2:: with SMTP id h34mr1684743lfv.167.1644333178187;
 Tue, 08 Feb 2022 07:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20220202182450.54925-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220202182450.54925-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:21 +0100
Message-ID: <CAPDyKFro1sqxzOYWVbsHud_s6P-zYxOH0WOiosN0kZHsP1OywA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc: Use device_property_string_array_count()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Feb 2022 at 19:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use device_property_string_array_count() to get number of strings
> in a string array property.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 99b201921954..3420a7ad6098 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3057,8 +3057,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>                 dev_info(host->dev, "Using internal DMA controller.\n");
>         } else {
>                 /* TRANS_MODE_EDMAC: check dma bindings again */
> -               if ((device_property_read_string_array(dev, "dma-names",
> -                                                      NULL, 0) < 0) ||
> +               if ((device_property_string_array_count(dev, "dma-names") < 0) ||
>                     !device_property_present(dev, "dmas")) {
>                         goto no_dma;
>                 }
> --
> 2.34.1
>
