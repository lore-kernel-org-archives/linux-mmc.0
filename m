Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FCC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Jan 2022 12:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380424AbiAUMmG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380417AbiAUMmG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2022 07:42:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270ECC061574
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2022 04:42:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br17so33592647lfb.6
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2022 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U19RMzoNXZLY6f3nYg8iXSqz+HMnSv8rn/hJ0unjcD8=;
        b=dUz/zCAM4lO11TOqTfgcd1vMlXzRN2KLO9mm+hddHtx+paZDTuoq+1nk+kuKuuQl+Z
         f76TTo7e3ktlFB2FBOpJ6LMjdYveyF6wrDenkLw4yHWq3BtVizJQxLazZqa3F9TUVVMJ
         bFlTukNqL1fgpb5gKmoEchSIQNvbhP1qBplSgS961IDRX3Bq7u/KMdiwsIN7qT+fVdMI
         A5ZKIFEJvrr/xtczyDTVghpKA9vdZJQeLWX9V3FfvYO4YxEIByRdfqYzjs464IJ+Dt6j
         gh8yPIAG1hmSsknVuerSpLl6uQLmUeQE2C87J89u3ksOvd2TacBn6iKB1NJlOCe9GNQU
         2L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U19RMzoNXZLY6f3nYg8iXSqz+HMnSv8rn/hJ0unjcD8=;
        b=4C7zrGwgE8FNMmaImKFIURZB6n0thFLaSFRN8svFsxzKf1S9oe675w/OUG7EVElTrf
         xzrIcEmNxevtKYs2ZLcM3SI4oavjdhFi8+vCMl4n1B9zrJCZrlsvb6/R72dmTkD0U3TE
         xNprURSFjOla3KcsDtaq6ofWvPleCrJfKi9Rxlkf0G4gVfTK/4TXe2mCSXikY27IZaFX
         Jicqz/rS4sIkZup0kkEQhFqxUUmzjwsFwpmdMhItpVvwAqikDMy6MMVZH1xK/lph+Xii
         0suIgW1u5jhXEku7367sX9M4uoLhDSWRmLVB799XVE3zcmMowmxTx8gRGYXlA0HVMlvK
         TYNg==
X-Gm-Message-State: AOAM530KolBgVK/kGSFK3hvBeFWb8kdRp8845Qm1wqq4ymSw+lp1X7pB
        F5dqHRqVB+VYmEzCEoHVToOooz7R3AincRrfupRIDA==
X-Google-Smtp-Source: ABdhPJz2AOO0gB2ju1tOqj2K+obGJ+0aRFE+IxUpTowkhDOtxQ0U2vMIRiCciYENRWuPyOiwYdnVncZThl8CeKkOc+s=
X-Received: by 2002:a05:6512:4014:: with SMTP id br20mr3756465lfb.233.1642768923473;
 Fri, 21 Jan 2022 04:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20220114075934.302464-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220114075934.302464-1-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jan 2022 13:41:27 +0100
Message-ID: <CAPDyKFpu0mGchoqdzE-qKc6=9ogncnTCwN8AR7g1wcMZLyRFsw@mail.gmail.com>
Subject: Re: [PATCH] moxart: fix potential use-after-free on remove path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, stable <stable@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Jan 2022 at 08:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It was reported that the mmc host structure could be accessed after it
> was freed in moxart_remove(), so fix this by saving the base register of
> the device and using it instead of the pointer dereference.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: Xin Xiong <xiongx18@fudan.edu.cn>
> Cc: Xin Tan <tanxin.ctf@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable <stable@vger.kernel.org>
> Reported-by: whitehat002 <hackyzh002@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mmc/host/moxart-mmc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 16d1c7a43d33..f5d96940a9b8 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -697,6 +697,7 @@ static int moxart_remove(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
>         struct moxart_host *host = mmc_priv(mmc);
> +       void __iomem *base = host->base;
>
>         dev_set_drvdata(&pdev->dev, NULL);
>
> @@ -707,10 +708,10 @@ static int moxart_remove(struct platform_device *pdev)
>         mmc_remove_host(mmc);
>         mmc_free_host(mmc);
>
> -       writel(0, host->base + REG_INTERRUPT_MASK);
> -       writel(0, host->base + REG_POWER_CONTROL);
> -       writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> -              host->base + REG_CLOCK_CONTROL);

Rather than doing it like this, I think it would be easier to move
mmc_free_host() below this part. That's usually what mmc host drivers
do clean up things in ->remove().

> +       writel(0, base + REG_INTERRUPT_MASK);
> +       writel(0, base + REG_POWER_CONTROL);
> +       writel(readl(base + REG_CLOCK_CONTROL) | CLK_OFF,
> +              base + REG_CLOCK_CONTROL);
>
>         return 0;
>  }

Kind regards
Uffe
