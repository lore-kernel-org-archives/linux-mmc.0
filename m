Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E835C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEAF20722
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 10:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YerK+7uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgENKX6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgENKXt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 06:23:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE97C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2020 03:23:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a5so1620501vsm.7
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2020 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxbOGht0ye1sBhbrPpYfKMbU4OenacQ3DVBFGFBOWNg=;
        b=YerK+7uAGjzbxEDFGas94+8RT+RnBHxvH0m0CCnPIH20UBUcG6Q/8RNS+ltZ8pts0+
         Wgaz4bdQjtXQIss/SBLsYEjuP9SSKzxlSdBHxDTuDO4ZB/pfe3rlZtS5pWFrRl2KAd1C
         UeZB7oSdEJD/dWKHLP0NhcRPcGdPmiJKw96P//cLlTtoEDPshJfEXMMKnhQAvPlmRqf6
         v1tGdxJyTrhtsAMFxBxh5q+CQQRWhKm8mi/XZs2HSI0U7cvUOorDXC6VwzpWkXarr9oo
         VgrsaucyRlaRYVJBzQ2/iiEvfwhLw1qPcrqwFAb1VhvHKDZqqvPqyQw/lSyG8M+fTH+E
         SeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxbOGht0ye1sBhbrPpYfKMbU4OenacQ3DVBFGFBOWNg=;
        b=P4HPOLOTMFucvWQL2rOet/ybCGLMMwHO1Zw3BXmt5HVA05tNUdcfdUsA0tYLVegwBf
         s3/IqLUWUaK4M6egetAzmWO2SbypljpBuH4HVuKMjI2fr/8Y+7GN/3NPWRU3R3GvzWER
         j5oSVoMS2Z0mRMO1ul7rrjZdWm1kh9hlJ+lJYaycCfjaUD+6H8P606Rut098vgcwE4yt
         uNEKhw7lzfnvRs9Oz+fbts6/96E4q8lUVXQYgpR4CwsHy2r2/dycWatbKwA5rdi7Q36H
         u3NRD7W6hJz4DBGnEZtrXIE75SEWGca7TcOKgqRxLwLB6dsPTHGYk7cK3E+bzBd2SHOL
         uFBA==
X-Gm-Message-State: AOAM5311VCpK9Xzoqc3puHcMiZ4g8wx5wDJijDlUxwopEK6nlo0kDF5I
        GzLPtFRAZU6esxVXvcv//6q/Z/RmEVdr3IIT9phmUw==
X-Google-Smtp-Source: ABdhPJx9SsaDNYVhRKAhbE4YI3L0urHBK6RzWpOcLD+Bxst8lM9k6Fc8LRYApFv0pPBVyWo8KWsr/QuwaI8ffs8/R5M=
X-Received: by 2002:a67:d71a:: with SMTP id p26mr2823673vsj.34.1589451828803;
 Thu, 14 May 2020 03:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200513171206.6600-1-wsa@kernel.org>
In-Reply-To: <20200513171206.6600-1-wsa@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 May 2020 12:23:12 +0200
Message-ID: <CAPDyKFrgsZ7z=tvfpg6q0ofurneTQMo3Y5CnXRZXX4fmDQ=YOA@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: tmio: properly balance RPM on remove
To:     Wolfram Sang <wsa@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 May 2020 at 19:12, Wolfram Sang <wsa@kernel.org> wrote:
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Because we enabled the device with _noresume, we should disable it with
> _noidle to match the ref counting of the clocks during remove().
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> I think this is the proper fix to the problem Geert reported [1]. I am
> not sure about a proper Fixes-tag, though. The corresponding _noidle
> call in the probe()-error-path was added with:
>
> aa86f1a38875 ("mmc: tmio: Fixup runtime PM management during probe")
>
> However, from my understanding this is more fitting?
>
> 1b32999e205b ("mmc: tmio: Avoid boilerplate code in ->runtime_suspend()")
>
> But maybe my understanding of the situation is still not perfect and
> even the commit message is bogus? Ulf, since both mentioned commits are
> from you, could you have a look? Thanks in advance!

I did start to look at it, but got sidetracked with other things.
Anyway, I will check in the next couple of days.

Kind regards
Uffe

>
>    Wolfram
>
> [1] Message-ID: <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg>
>
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 9520bd94cf43..9a4ae954553b 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1235,7 +1235,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
>         if (host->native_hotplug)
>                 pm_runtime_put_noidle(&pdev->dev);
> -       pm_runtime_put_sync(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
> --
> 2.20.1
>
