Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D1C2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5BB24650
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXc0piMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgBMN4q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:56:46 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43987 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgBMN4q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 08:56:46 -0500
Received: by mail-vs1-f68.google.com with SMTP id 7so3605118vsr.10
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNaO9fCq4OroqsLyyWDGRz4F9uHGAr1iFI1cNpsaze4=;
        b=VXc0piMADDudT2640UQ7xe52fYFhWUEMLYy+jDVn2rbNCyaajFa8ImKPOPMX3vdv+B
         aThfOe7Q6XjxyxTfQtT9C/IKgmcmZVoep4WV0BASsavWPD9pzh4D7aiTyvk+83d7Uk+9
         led7ucEq595FFqn9GXQhp65NBLipKASrshgoZQPB2f9OIb0yPUTrSqMqiLrHszcFT9Ge
         IAEsgcaXlKJJjLVD6bInw0nQTNcDvFrCm6fNBGWtLJR4w7N/wvzljNzo5fhNfAQq5+Kt
         p9Ne2GXymxzxGSa9mUbTR+QxdyhyX+hIFEsE60h/Zd5la9sp5XbZhcK8Ms49cW5Mh97H
         2p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNaO9fCq4OroqsLyyWDGRz4F9uHGAr1iFI1cNpsaze4=;
        b=Rwi4NZmB8em9cXpHaIH9FYkqrY8r4ZmbTGxGJ/Xr/AJNtEcQTRP1TWvkUaXF5PPNY6
         jEpDfv8Y7kFcyNefNe80+3ViA77pMMfX8t45LGba1bqegq2GDkYw2ZUXBICr+gXOWafK
         aXl41Z04j1DyB/FMeNHr35qhpFW+Y7VVFhPVbLMSjx6kfiR355GKPTld6yQfDwdFxNyq
         TKvFCJYYzFHp9zpmkm2U4S50JvqI3TbLDhOuOAcNXphgBYoeVMtl/rXUjcZdNeyUI4z8
         +Eo4D9MkPp2PAkuUX7VtcYB4LmP0NZZcTvQBw8W/LkX7rgqNXQPcEmRcbKwRXpVU85oA
         gW4Q==
X-Gm-Message-State: APjAAAUzc6Cs7hTmSKOsit+CnwS7UzQZ6risVYm8Ugw0gwbq2YcnmAQQ
        dfgvwSu3V/1BNlBnAUzfjHsVRrNRpzjzZrSLtEz/pw==
X-Google-Smtp-Source: APXvYqxqHAmLotIRRQ0ncI82P7E94z6GiQzoCMQmJK6bCTdhOwKfljgkz8QLciGgOc9VSbSss2yfxewHEL5Z+BXjbfY=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr2150149vsb.200.1581602205182;
 Thu, 13 Feb 2020 05:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20200206162124.201195-1-swboyd@chromium.org>
In-Reply-To: <20200206162124.201195-1-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Feb 2020 14:56:09 +0100
Message-ID: <CAPDyKFo9cKVNRuu0EK9CdD9gx3kd+gcW=AtaC3Ewhmy1KpNAHw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Feb 2020 at 17:21, Stephen Boyd <swboyd@chromium.org> wrote:
>
> This function is not exported and only used in this file. Mark it
> static.
>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c18047..3955fa5db43c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1590,7 +1590,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
>         return 0;
>  }
>
> -void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
> +static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>         unsigned long flags;
> --
> Sent by a computer, using git, on the internet
>
