Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BABC2BB85
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3CB206F9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJIB27nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894969AbgDOIql (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894967AbgDOIqg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 04:46:36 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC8C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:46:36 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a10so1034168uad.7
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi2eGcMT6rMjNmHfTn+6C3a0PNU3Dbjr1+RHlUDbfdE=;
        b=vJIB27nnx7NInYBYJNGhm545ijOXmPG5PJ+0Vf3NJpyxWQiPFS5/18D0/eVAL57jng
         tlIfro/fzyefa7pzStFQS2+rHWQluG72uKIG4cVLU5AgRMje5I45jxIjNMQeETp8MZH2
         qGQcpw8VturBpfuirdeqr9c124vzXTDw1zlq3NVQ/xx8sHPvrbNZmapL0k4MW7Tg1yrY
         GrFUa4G6pRqtjxufOt86mHF/K7CarQ10IyDcYqRJyR4tfqsDatHAQRNGU/BifK5vfIyW
         8qvfaHXLlcayByo/SR1fJAh9EiBha1jkpc7wZbduXAVsVSoZoj7O8IEMKhUYk/wu6+Pt
         EXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi2eGcMT6rMjNmHfTn+6C3a0PNU3Dbjr1+RHlUDbfdE=;
        b=GmHK4gPagUyZbAq0JSwSHXplOxQ5CkOAjw8zoauf+DhFvLTdKDGqoLt7wbVKvCmc6w
         EYmJag1e4ksRyYiUEhINEkHGKpviLiITHAzGQ14uBbQYyG7+/mQfJ4s6X4izuQq6cTq9
         uWuPwHr1/VwmFbQGGdNeZpPtRIE8kU1LcVFyU8mhDQOPfo+2Z9wgZez7myQd3SZ0/O20
         auVk2Y2hCmQH64uHsobufReGgWF/qRZ0Hu3liAAxSDSHdAc41K1BjbIYOrrbTtTaS1KZ
         0/cn+phwTT3ukDKuI7m4VBAiOhNmm3cFU+o/3W2d/xR1J7W9JU11ZHMyjp9f6LQ3Tj8a
         8mVA==
X-Gm-Message-State: AGi0PuZ3v6Qg5KAffzsb7XgkW8yb+Zq+5vpDeluByVi9DSAaNmBbHl05
        NlX/C6ApV0lVvw52NDaPQ6g27QwihD+mJF+WxQW6dQ==
X-Google-Smtp-Source: APiQypKSnJq3GtI7I8370QcKOEbJus5EhyZKwcJPbeC4yoZidoU3fP1OuuptUIClEnTd5eWt4D57NVWQjScrvdMRcpQ=
X-Received: by 2002:a9f:25af:: with SMTP id 44mr3566481uaf.104.1586940394324;
 Wed, 15 Apr 2020 01:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200401195722.208157-1-marex@denx.de> <20200401195722.208157-3-marex@denx.de>
In-Reply-To: <20200401195722.208157-3-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 10:45:58 +0200
Message-ID: <CAPDyKFpzM5NWR3D5uEmNu3hdhtr-vkucWNsCb2npd1eyR+=T_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: mmci: Switch to mmc_set_signal_voltage()
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
>
> Instead of reimplementing the logic in mmc_set_signal_voltage(),
> use the mmc code function directly.

Again, this isn't about mmc_set_signal_voltage() but about
mmc_regulator_set_vqmmc(). Please update the changelog to reflect
that.

>
> This fixes a real issue on STM32MP1 where, if the eMMC is supplied with
> VccQ=1.8 V, the post voltage switch code will spin indefinitelly waiting
> for the voltage switch to complete, even though no voltage switch really
> happened. But since mmc_set_signal_voltage() would return 0, then the
> condition for calling .post_sig_volt_switch() is not satisfied if the
> switch did not happen.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/mmci.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 647567def612..b8c8f0e623de 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1861,31 +1861,15 @@ static int mmci_get_cd(struct mmc_host *mmc)
>  static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
> -       int ret = 0;
> -
> -       if (!IS_ERR(mmc->supply.vqmmc)) {
> +       int ret;
>
> -               switch (ios->signal_voltage) {
> -               case MMC_SIGNAL_VOLTAGE_330:
> -                       ret = regulator_set_voltage(mmc->supply.vqmmc,
> -                                               2700000, 3600000);
> -                       break;
> -               case MMC_SIGNAL_VOLTAGE_180:
> -                       ret = regulator_set_voltage(mmc->supply.vqmmc,
> -                                               1700000, 1950000);
> -                       break;
> -               case MMC_SIGNAL_VOLTAGE_120:
> -                       ret = regulator_set_voltage(mmc->supply.vqmmc,
> -                                               1100000, 1300000);
> -                       break;
> -               }
> +       ret = mmc_regulator_set_vqmmc(mmc, ios);
>
> -               if (!ret && host->ops && host->ops->post_sig_volt_switch)
> -                       ret = host->ops->post_sig_volt_switch(host, ios);
> +       if (!ret && host->ops && host->ops->post_sig_volt_switch)

I would suggest to add a comment here somewhere, that you explicitly
want to avoid calling the ->post_sig_volt_switch() unless the voltage
really changed. Just to make this clear.

> +               ret = host->ops->post_sig_volt_switch(host, ios);
>
> -               if (ret)
> -                       dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
> -       }
> +       if (ret < 0)
> +               dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
>
>         return ret;
>  }
> --
> 2.25.1
>

Kind regards
Uffe
