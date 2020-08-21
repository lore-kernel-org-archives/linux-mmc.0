Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974CC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DA520738
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qohpj3U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUIAG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgHUIAE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 04:00:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2DC061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 01:00:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b26so390900vsa.13
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0+bi81wkptWP0DO2AvkxY3NniCHjbDnJdfX2f/Ge7s=;
        b=Qohpj3U2ZS6+AN7yCQih1b48C23DhCaAced7AkCHl4gzQlf1aYQfiIdL6NeBsErFmp
         w+8e8ZVknIW4tlXaffg9rJDqm9Q8/iUuAihnulqlecqJ0F6r11d1ZdcuUoMl3PDruwkt
         3CXu/kERQDcAumqVE3H/3HCnrjoq76621TD9JPjPeaIJgUetGZCsMPdIJ2LFdoHaok6I
         CABclh0Nys2+t0O8x6Ta7K4Jukjlaa/co517KW8ZkG65KZBLvibXAkkoUlNcGc+1aOCi
         u73jiVZUVAwCC3X/LPH1rimSNRYBP0vhVSxxMVAzyDQEoMFy24dgCa/Gg55HsJlG0Sui
         lWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0+bi81wkptWP0DO2AvkxY3NniCHjbDnJdfX2f/Ge7s=;
        b=OMNRHeV1npp5NisDz1/hPrhdXMWuG+U15otcbpOpUsFbFevrwXIvv8pMwwshk3r28R
         4S5M0JRwECLbGsc31Me9u3DOIN50Qvma6XrXNwVBCP38ciJEPY/JNY2FSWZMBdQtZ4/O
         OiOGLPAAUAGCL3VrkNpaNCla8QB3k9nTdmqNDOAMT8Qsn9M6EvvkTHxDlNhlQyEekOp6
         YqK6dNdDKcaWv6bfyCxY02fX8A8AC8RGjNiyrC/n0U5KrSCHzSxSAbHXoCZnxIL7KR0g
         5tYyJaftSKTa3lseiHNJl8DW991YpBExTS+fAjLJpwxuxqK9HWkyBzr1Q6JO1YRE9zbZ
         oxJQ==
X-Gm-Message-State: AOAM530uYU/PETjaUAkb+wyM92bYOGeHvgyfSfjov9FvdcHkqlpi2gsv
        XRjssB6hzH/7F3DxNZ/2xo0/wUj/EQ9M/vI2KdLJGg==
X-Google-Smtp-Source: ABdhPJwJXgAXeA0PjJQPvLhIshTVzMNF4T4hLMkoMCjQ/4dm6r2RIpUJ8GGJhbdvLtWnGPUp/59eCj59ZMpZr7OR+UE=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr922777vsq.34.1597996803498;
 Fri, 21 Aug 2020 01:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <1597835959-22402-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1597835959-22402-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 09:59:27 +0200
Message-ID: <CAPDyKFqd_0VV2cO_weC6QJ-aNAG0witOwWfsWqeoaryDNQS1hA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdio: add a delay to call sdio_irq_work when sdio
 bus resume
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>, huyue2@yulong.com,
        Doug Anderson <dianders@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Aug 2020 at 13:24, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Find this issue on i.MX7D-sdb board with broadcom sdio wifi.
> When system resume, sometimes this wifi meet the tuning fail issue.
> All tuning command get command timeout error. This is because
> sdio_irq_work on system_wq was executed before the broadcom
> wifi driver resume. Due to broadcom wifi driver set the wifi in
> Sleep sate in system suspend, need to set the wifi to Wake state
> first. So need to make sure wifi driver resume first, then do the
> sdio_irq_work.
>
> Fixes: 51133850bce2 ("mmc: core: Fixup processing of SDIO IRQs during system suspend/resume")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 7b40553d3934..101632617f69 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1047,7 +1047,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
>                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> -                       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> +                       queue_delayed_work(system_wq, &host->sdio_irq_work, 1);

This looks fragile, as there is really no guarantee that the WiFi
driver is resumed prior to the SDIO irq work being executed.

Instead, it looks like you shouldn't keep the SDIO irqs enabled during
system suspend, because those aren't system wakeup capable. Correct?

In other words, I think the WiFi driver should call sdio_release_irq()
in the ->suspend() callback and sdio_claim_irq() in the ->resume()
callback.

>         }
>
>  out:
> --
> 2.17.1
>

Kind regards
Uffe
