Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01521C2D0C0
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93BD21582
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 07:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpboA0WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLSHIQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:08:16 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35726 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfLSHIQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 02:08:16 -0500
Received: by mail-vk1-f196.google.com with SMTP id o187so1367301vka.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 23:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGBlqophzoYGkykGSFS2zrDNaAG67yYqFvYU9Sw2GbI=;
        b=wpboA0WIU5cEpcnCJW90qtqO9U2oTF/aY8DgSOdQzxIQu3j8gMvbWz69ubRHlG+Jov
         z+XtO22xgUzAUoC75+gKUo0wavOhvFyoqOdMmNMk3HAqanmMVY7s4UShBMZsj0sQLupI
         sND6WI8q4ywCN646ldAnKR/NogeoIhljEv5PDtYR7FZ0PUFQuJzR0ZdvjvZDkVSgDerZ
         qHtvF8V+ayWIzj8Ig5YhxN6VE2obmtCiqKKsMOZAnsUtYs8KgCC0yTUcP0BWJmlZPDRO
         sgpOJGPAnietElGS79axL0uXcoItVfdGQF4UTOLYkofY0Uwj9Mwm+o1PshvIBf4FcEME
         drZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGBlqophzoYGkykGSFS2zrDNaAG67yYqFvYU9Sw2GbI=;
        b=ollOUx94YjbmAqZs9/5AOVHX/yRm7wu7ueH4R1xAUouwNUSnL9fp/VlCabYK7g9wYg
         Tf1YZg/ssftO9j8O5MpeSEAo730B1D+FIIvEG+LM9bI+//H5KJjLbpf+MCgU+DPHwl3Y
         V/dwEoaG9DZdDhTy+JMT/STC040EJLr6tR0RXZDljATTlKgk50IjBhtB9Trmi2ywcBdH
         vxvFB5XI01fR4EM5+zacpIJhRgHm1uFPtzn9XxH0YG6t+pN39j1NKNRsQgpekaO1vCVi
         NVVVnh15jAlFYNJg+egiFeBvliBt3+EUoLGVUs2E3YYtqaHYQsgK6uKwEUXqkym3Yl4G
         WxUQ==
X-Gm-Message-State: APjAAAVHInijWJEelz89yr4hD7tnDo6DwJpqlM//ZobAKEZ1tP0uKgx9
        Ut1nbEhsm/aPacF/en1tqh1vMKDyRYMiDcs9BbyK7g==
X-Google-Smtp-Source: APXvYqyHm4R2GejiQBIrAcbUJQjzwIsnECCTodyLsbfwHOPecke/1j0HM2BFwIJvBaC8nAxBmzCpp8dZ7vFpZp1UrpY=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr4873296vka.59.1576739295314;
 Wed, 18 Dec 2019 23:08:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPDyKFr8aVWVydT5U6mpuZr5_waH=bn6F8rjryfDJ15FDaAXUw@mail.gmail.com>
 <1576736889-4430-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576736889-4430-1-git-send-email-zhangpan26@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 08:07:37 +0100
Message-ID: <CAPDyKFpTZNi63XgBgp3z4svxNcEsnZxH5qg6mZ9uTLkUm_AQSg@mail.gmail.com>
Subject: Re: Re: [PATCH] mmc: host: fix a possible null pointer access.
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jaehoon Chung <jh80.chung@samsung.com>, hushiyuan@huawei.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Dec 2019 at 07:28, Pan Zhang <zhangpan26@huawei.com> wrote:
>
> On Wed, 18 Dec 2019 at 7:52 p.m., Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> 3419     if (host->slot &&
> >> 3420         (mmc_can_gpio_cd(host->slot->mmc) ||
> >> 3421          !mmc_card_is_removable(host->slot->mmc))) {
> >> 3422         ret = clk_prepare_enable(host->biu_clk);
> >> 3423         if (ret)
> >> 3424             return ret;
> >> 3425     }
> >>
> >> We previously assumed 'host->slot' could be null (see line 3419).
> >>
> >> The following situation is similar, so add a judgement.
> >>
> >> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> >> ---
> >>  drivers/mmc/host/dw_mmc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index fc9d4d0..8e27c52 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -3454,7 +3454,7 @@ int dw_mci_runtime_resume(struct device *dev)
> >>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> >>
> >>
> >> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >> +       if (host->slot && (host->slot->mmc->pm_flags &
> >> + MMC_PM_KEEP_POWER))
> >>                 dw_mci_set_ios(host->slot->mmc,
> >> &host->slot->mmc->ios);
>
> >This shouldn't be a problem as the ->runtime_resume() callback can't be invoked, unless there is a slot.
>
> >>
> >>         /* Force setup bus to guarantee available clock output */
> >> --
> >> 2.7.4
> >>
>
> If so, there is no need to assume host->slot pointer previously(line 3419)?
>

Yeah, there is probably more cases that has unnecessary "protection".

Kind regards
Uffe
