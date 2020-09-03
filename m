Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB95CC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50F4205F4
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coqQy0l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgICIfA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICIfA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:35:00 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0796C061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:34:59 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id h23so609215vkn.4
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2SY4JIMIztbHKnlsFQ0j762zWLRku68PyTB52ByMCE=;
        b=coqQy0l5FUVQQ/4YPZt4lpmIUxFsaoWjioYzIObTi0e1L+po4ZVREeV3BoQyJWAf+3
         CK8EE9Gg1TcnSMUc9W/wzcUzgiwZcAHsK0lxwYvX33eRk+TV36ZHajToCXGT80VJiTEQ
         19jlkDEhiZtLksuFw0mA+CHFl8NNhf81Wya1FdbVgAKGKXnyAjRAjxalc3sGdFGM3m11
         xGVi1t4TLLvwzXY5EZ+TpZSdA8Mubhfm5Cx9gRjHa41YgV10LVDI/Z3Hng7E/qWXmPhw
         9bWuX5WQ3uEjM3INF79mItR7HV6Zrj7xN1O/osvqVtl2YLrRfLzlEZ1hiPMMAz1xSUV5
         rIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2SY4JIMIztbHKnlsFQ0j762zWLRku68PyTB52ByMCE=;
        b=IVdyD2GlOYUa2CxdJScKJIPqcCTKzfZFP6Di3CHFneOG6IvuwHu6fnP+fhYiOTrHxd
         sIFiOksWT4w4KCQyhhOdCk/sBR3CRz7ielngmxmgEhEwQUspyoGeZBcUOm4JnfGeZjyf
         Nn2kJTlOUGaOc0n6qRCYSn2WePfhk9kjmAbJtE9knv9JtDgypr4/UudALE+OeHLv5DmQ
         D5JZfI0DidkXcvDTQbQVLAaPqvBmR1b9S/K0QLnEjoc/u56rTkwlecZhcNcepmyKP3PA
         6YeImydVIKr2v88A7HAIHdRtbqRLKZSVYp0K+Bk51hhgbzOW81ySf8RNIj3bVTWjWk78
         hn2w==
X-Gm-Message-State: AOAM531b9HP/G9oLkK8PHVFOETBr10H6+2Ui2+lLRYioTOunN7EIKEEU
        c74kpa3rVUHlf5n8x0bzllCrKEictLFd9cHRol0slg==
X-Google-Smtp-Source: ABdhPJzrg+G/Wr4xv5bbiefLyr5XeFZ2WW6Myfce1nAq0bnwZF9EI5Gf1OSLMisEhAOHjEfdPeHFmksaUxZTqbX3Tao=
X-Received: by 2002:a1f:e443:: with SMTP id b64mr880312vkh.17.1599122098716;
 Thu, 03 Sep 2020 01:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200903082007.18715-1-adrian.hunter@intel.com>
In-Reply-To: <20200903082007.18715-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:34:22 +0200
Message-ID: <CAPDyKFrmpdOXmKOrfezed8nQVbkO5tG8QK=qoSOo5FM1Pa5yTA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Use mmc_pre_req() / mmc_post_req()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Yue Hu <huyue2@yulong.com>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 10:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> SDHCI changed from using a tasklet to finish requests, to using an IRQ
> thread i.e. commit c07a48c2651965 ("mmc: sdhci: Remove finish_tasklet").
> Because this increased the latency to complete requests, a preparatory
> change was made to complete the request from the IRQ handler if
> possible i.e. commit 19d2f695f4e827 ("mmc: sdhci: Call mmc_request_done()
> from IRQ handler if possible").  That alleviated the situation for MMC
> block devices because the MMC block driver makes use of mmc_pre_req()
> and mmc_post_req() so that successful requests are completed in the IRQ
> handler and any DMA unmapping is handled separately in mmc_post_req().
> However SDIO was still affected, and an example has been reported with
> up to 20% degradation in performance.
>
> Looking at SDIO I/O helper functions, sdio_io_rw_ext_helper() appeared
> to be a possible candidate for making use of asynchronous requests
> within its I/O loops, but analysis revealed that these loops almost
> never iterate more than once, so the complexity of the change would not
> be warrented.
>
> Instead, mmc_pre_req() and mmc_post_req() are added before and after I/O
> submission (mmc_wait_for_req) in mmc_io_rw_extended().  This still has
> the potential benefit of reducing the duration of interrupt handlers, as
> well as addressing the latency issue for SDHCI.  It also seems a more
> reasonable solution than forcing drivers to do everything in the IRQ
> handler.

Briljant!

So, this should mean that other host drivers that use threaded IRQ
handlers could benefit as well. It would certainly be interesting to
hear from other tests about this.

>
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: c07a48c2651965 ("mmc: sdhci: Remove finish_tasklet")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_ops.c | 39 +++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 93d346c01110..4c229dd2b6e5 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -121,6 +121,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         struct sg_table sgtable;
>         unsigned int nents, left_size, i;
>         unsigned int seg_size = card->host->max_seg_size;
> +       int err;
>
>         WARN_ON(blksz == 0);
>
> @@ -170,28 +171,32 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>
>         mmc_set_data_timeout(&data, card);
>
> -       mmc_wait_for_req(card->host, &mrq);
> +       mmc_pre_req(card->host, &mrq);
>
> -       if (nents > 1)
> -               sg_free_table(&sgtable);
> +       mmc_wait_for_req(card->host, &mrq);
>
>         if (cmd.error)
> -               return cmd.error;
> -       if (data.error)
> -               return data.error;
> -
> -       if (mmc_host_is_spi(card->host)) {
> +               err = cmd.error;
> +       else if (data.error)
> +               err = data.error;
> +       else if (mmc_host_is_spi(card->host))
>                 /* host driver already reported errors */
> -       } else {
> -               if (cmd.resp[0] & R5_ERROR)
> -                       return -EIO;
> -               if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> -                       return -EINVAL;
> -               if (cmd.resp[0] & R5_OUT_OF_RANGE)
> -                       return -ERANGE;
> -       }
> +               err = 0;
> +       else if (cmd.resp[0] & R5_ERROR)
> +               err = -EIO;
> +       else if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> +               err = -EINVAL;
> +       else if (cmd.resp[0] & R5_OUT_OF_RANGE)
> +               err = -ERANGE;
> +       else
> +               err = 0;
>
> -       return 0;
> +       mmc_post_req(card->host, &mrq, err);
> +
> +       if (nents > 1)
> +               sg_free_table(&sgtable);
> +
> +       return err;
>  }
>
>  int sdio_reset(struct mmc_host *host)
> --
> 2.17.1
>
