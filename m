Return-Path: <SRS0=+AiC=5Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA237C43331
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Mar 2020 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3352072E
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Mar 2020 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDCxx/HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCaSx4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:53:56 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34479 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCaSx4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Mar 2020 14:53:56 -0400
Received: by mail-vk1-f193.google.com with SMTP id p123so6020468vkg.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2020 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLn8R7yFW0PIVTjWQSh2J/UN24TkXxBZBuS0EHdyeRc=;
        b=lDCxx/HIRV6TOpKPkZVzHmuAXwgrj7mRBJIxIb+e6C8khnrLL3vvFFdHN9HCXdHA4E
         dQedAigbBqjh+wjkwAcbpaae0rA7/tc+pYBkgBRXc/UxpZpdova5D2vzWjlANz8I21//
         myXgl1y4OTdgkPFKW4jgTZ7BoqJxRU2pxXUKNIJA/5myuhXp1MrFdNWpfLjFXpesi139
         yAkBHE2PBEokgwFBaL6/3KmRJfOzt8h6u92hKk+pCc4VlJVghaod7hk6l2q9gYLJLqPg
         +YN38+xSNgmZj8aPVt2iPpMKbiAMoJUpDvY0f2W4tX9sJ5NrJZ4wPLtiaNK14V6pw017
         LhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLn8R7yFW0PIVTjWQSh2J/UN24TkXxBZBuS0EHdyeRc=;
        b=rjqIVU1SqyyD6dbHGVyNPEkbx7t1nDsg4qNXfxZTmXNWL92Ux0EBoYjOXdGLODWNiP
         SnSg1Kl3rvY5GzaDfQ90KHXBXgHLlWyNZrarVzno0JsulMQ5A3tmuKF0BzJ9SuYyFwhy
         eb/2XSyPZchK8NbGAGmZhaga9EuNtegDK//Rm1CKA+HIon3CHBq5CUQa2xTx9zhBdeDg
         rXTaCALkZyPCeQj3niNrZisfl0GCclMio0pY3Fce4Wrx7+FN8M5EOc4BBZWg4tRb2cg/
         6TBQ6DxxpMRZWMVtuDZ4BQMfMSB2m065C66e0LLUQDNwQVjDFcYqaTl+h8yHm+5AJDOs
         IndQ==
X-Gm-Message-State: AGi0PuZ45rqLHhs1E+Co6SLRNkLxocNaOee71Y+gkueFpz6zMXmAyiBR
        DPgaCz4OgymUNw0c/277eKZkyh7KYJkGas3OMKUBrg==
X-Google-Smtp-Source: APiQypLRBTeeIhQeAknNXJt/1aVHFrpSI9qB4xSQ6cl6yKQ5B5KQN84Thv5rujm9HBaHwmYi/gooxxi4YtYEpV/0+Tg=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr12921560vkb.59.1585680834444;
 Tue, 31 Mar 2020 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200331155254.100952-1-marex@denx.de>
In-Reply-To: <20200331155254.100952-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 Mar 2020 20:53:18 +0200
Message-ID: <CAPDyKFrypbDEuDaGWySjC6j_qKbXpVHoubhh8e9jS24JSzBg3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Only call .post_sig_volt_switch if voltage
 switch happened
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

On Tue, 31 Mar 2020 at 17:53, Marek Vasut <marex@denx.de> wrote:
>
> Call the post voltage switch handler only if the voltage switch actually
> happened. It is well possible that the regulator is already set correctly
> and no voltage switch happened, so there is no need to take any further
> action.
>
> This fixes a real issue on STM32MP1 where, if the eMMC is supplied with
> VccQ=1.8 V, the post voltage switch code will spin indefinitelly waiting
> for the voltage switch to complete, even though no voltage switch really
> happened.

Whether this is a common problem or not, I think in a first step we
should manage this in the common mmc_regulator_set_vqmmc().

Then on top of that, convert mmci into using the mmc_regulator_set_vqmmc() API.

Can please try this approach instead?

Kind regards
Uffe

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
>  drivers/mmc/host/mmci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 647567def612..11c2f417cbe8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1861,10 +1861,12 @@ static int mmci_get_cd(struct mmc_host *mmc)
>  static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
> -       int ret = 0;
> +       int old_voltage, new_voltage, ret = 0;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>
> +               old_voltage = regulator_get_voltage(mmc->supply.vqmmc);
> +
>                 switch (ios->signal_voltage) {
>                 case MMC_SIGNAL_VOLTAGE_330:
>                         ret = regulator_set_voltage(mmc->supply.vqmmc,
> @@ -1880,7 +1882,10 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>                         break;
>                 }
>
> -               if (!ret && host->ops && host->ops->post_sig_volt_switch)
> +               new_voltage = regulator_get_voltage(mmc->supply.vqmmc);
> +
> +               if (!ret && old_voltage != new_voltage &&
> +                   host->ops && host->ops->post_sig_volt_switch)
>                         ret = host->ops->post_sig_volt_switch(host, ios);
>
>                 if (ret)
> --
> 2.25.1
>
