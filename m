Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D8C38A29
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F021D91
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS4HBIu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgDQJbk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbgDQJbj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 05:31:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C3DC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id h30so316103vsr.5
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0aSjy2QOsrn6AAD6OOfgGlIxwNu+4cSpUbiuSms0Dc=;
        b=xS4HBIu71wfGR/iPAXJMPcODEpgrvBKDhe77V0qBmi/BHbHV2AIiMJ6eNKRzg53euC
         ZJNJQNvLRBxwFtFRzf3YI718Ptc2casxzbzqTm3j1Uj/6tvAwLCe15blFv/zVz+bosAU
         6jsKmbWcTL1+9ppYiBP6M3XKBdxDjpFa4KgpqubzDQMML514rt8yx+WjF0rYD2C013Kc
         Ji5T2YVbBM1Rs9Vk/OZKxsxvuSQPEswYCYB+wqyOMuPe/bblcmSAx/Vej6jjBdVHuf7p
         PXANcz1Fz+bHzmz5nglSoxuICOtYDmi/c6UrRMZv9pG7Wv62pS5qGByGrT2CJV7a4+Lq
         masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0aSjy2QOsrn6AAD6OOfgGlIxwNu+4cSpUbiuSms0Dc=;
        b=gF8F6UfSYy7KXBorBcBXDQ9joA9pBTGBd/Hd42JdK6uZHNOq1C31brV5iaK0gN4xja
         xFMR80bvR5Is2TkYL4NiIgAH2DVRvB+VjB4KA0Ll4pP5CBgUERK8rkV9dxSAKnH9d1ic
         aAI82cPRM4561v3GcCn5dW8XaDZVle0yoblc5OgiN1JSOL8LK2ccPgj9PnXxTs/No6gr
         bYrdaWAFpX1WRLy8U7hotbwL2O1+TzXMbxheoG3/u1hxaO9sFVs2pARc8eSVNAglGF5m
         P7fab/RPc7uu3GV2GMeDBCS8sHxCYa0OPnpcaEqCfg2wZJCzIw/krZI+7uG/5iMfDP1U
         651g==
X-Gm-Message-State: AGi0PuZsoVVUOcAYEUSxIQYIkMxUfYYqSsB8H6j5t36WNRwznpTlzDih
        2SfvAKKXlNz2hatvuukI3stPBv3i02EqlHDxKbcWww==
X-Google-Smtp-Source: APiQypIp1ugP42rOqgprumhzqVWrTryT0OlLGRabY/doq9mNiw6w1Qx8z2Pe0Z+flU3goFiuTQLvceVcfXzeb6DeSAQ=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr1471283vso.200.1587115898847;
 Fri, 17 Apr 2020 02:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200416163649.336967-1-marex@denx.de> <20200416163649.336967-3-marex@denx.de>
In-Reply-To: <20200416163649.336967-3-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:31:02 +0200
Message-ID: <CAPDyKFrwqiBFcM71x-89h9HsVMhYGTKkciVZALtPVommc9sEQA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Switch to mmc_regulator_set_vqmmc()
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

On Thu, 16 Apr 2020 at 18:37, Marek Vasut <marex@denx.de> wrote:
>
> Instead of reimplementing the logic in mmc_regulator_set_vqmmc(),
> use the mmc code function directly.
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

Applied for next, thanks!

I did some additional amendments  to the commit message, just tell me
if you want some additional changes on top.

Kind regards
Uffe


> ---
> V2: Reword commit message
> ---
>  drivers/mmc/host/mmci.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 647567def612..a69d6a0c2e15 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1861,31 +1861,17 @@ static int mmci_get_cd(struct mmc_host *mmc)
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
> +               ret = host->ops->post_sig_volt_switch(host, ios);
> +       else if (ret)
> +               ret = 0;
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
