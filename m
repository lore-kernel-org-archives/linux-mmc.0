Return-Path: <SRS0=X25L=C3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3BC43463
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 17:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C55207D3
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 17:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="afpjKtXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRR5p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRR5o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2020 13:57:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E443C0613CE
        for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2020 10:57:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z22so9247091ejl.7
        for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2020 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0p3wb5ss5WDoQeyeweRprLyH7nkOhBWnapnwOW315M=;
        b=afpjKtXsdoMAMQ8L69PyXmJ5p560IsmcxDkwMbCRBfrBJrJEVmmMNbMndQ026vhwi6
         OjkxHT5Eg39NyrEpj3VUFdrFak18LTmj8mm46lOMWeZ9wCzxkPQ6SCoyRZ3DaBqnDxw6
         eQi3qhpLQeKb6k0a4DVA1IPNE+WYosHKnpZrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0p3wb5ss5WDoQeyeweRprLyH7nkOhBWnapnwOW315M=;
        b=UrG//0/ITdsaHtrvW3reVqC69gGJYYw72qLJsucEOgL9mKy+Nbjt/xxMi7S3zn1sFO
         /z9GdDpNpSCHBDS7Ha8/6Tniwe3VGENC0MPgVajL3jNcQE4Ri/WgRXoixW2Tx0F4ylBq
         Miz79xtg+Rjl0oQyrJcdYu9I5iQc5K44iBB1L/IfDI+TVPKKJItZwJTUK7ynKetwn13Q
         NnJ1zUq6yKogd81kz+qcIJ1KHZHYxwGQ5hYhHoi+OHXPMU4mqt3ztU9yS/4D9eBW3R7d
         nCipOCDF3gOCj6xadDPFGBxgr0q7WsdZfKA2+iw0eCv2FOeUwLOf4kvI7q44h1C8qf1g
         QkAg==
X-Gm-Message-State: AOAM532lp/tmkJsRrxdS+q86p8mbJ6l47NF+w2xUVdID/pLv7zCLWV1N
        mevDBZYxYrg7StaBtwd3tfKmFx+V0MbcoQ==
X-Google-Smtp-Source: ABdhPJw4un9BIF0AQiTEyndtKM/vq4aFHdBXkVGXYmtkcHKbv6b+P+EP5c+RLlMsMc6CJCwPHzlk8Q==
X-Received: by 2002:a17:906:fa8a:: with SMTP id lt10mr36693825ejb.307.1600451862808;
        Fri, 18 Sep 2020 10:57:42 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lo25sm2705936ejb.53.2020.09.18.10.57.41
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 10:57:41 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id g4so6982911edk.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2020 10:57:41 -0700 (PDT)
X-Received: by 2002:a05:6402:22fc:: with SMTP id dn28mr38605078edb.365.1600451860701;
 Fri, 18 Sep 2020 10:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200824122131.v2.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
 <873b0786-a088-54af-80ad-96d2b041945d@intel.com>
In-Reply-To: <873b0786-a088-54af-80ad-96d2b041945d@intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 18 Sep 2020 11:57:29 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DXUuWKo1n50aX3a86QfLCD4Z3W4CVescRDFcvQrEk3Ww@mail.gmail.com>
Message-ID: <CAHQZ30DXUuWKo1n50aX3a86QfLCD4Z3W4CVescRDFcvQrEk3Ww@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Don't enable presets while tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 1, 2020 at 4:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/08/20 9:21 pm, Raul E Rangel wrote:
> > SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
> > used for DDR52. The HS400 retuning sequence is:
> >
> >     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> >
> > This means that when HS400 tuning happens, we transition through DDR52
> > for a very brief period. This causes presets to be enabled
> > unintentionally and stay enabled when transitioning back to HS200 or
> > HS400.
> >
> > This patch prevents enabling presets while tuning is in progress.
>
> Preset value should not generally have to depend on tuning, so this
> seems less than ideal.  Also I am not sure you can say some controllers
> are not accidentally benefiting from the current situation.
>
> What about just letting drivers choose the timing modes that support
> preset values?  e.g. using the change below, a driver could alter
> host->preset_value_support as needed

Sorry for the late reply, I'm just getting back to this. I like the
patch. I have a few other patches I'm
going to push up soon. Do you want me to include this in the chain, or
do you want to push it up?


Thanks,
Raul

>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3ad394b40eb1..3e69c25c90a3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2360,12 +2360,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 host->timing = ios->timing;
>
>                 if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> -                               ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR25) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR50) ||
> -                                (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -                                (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -                                (ios->timing == MMC_TIMING_MMC_DDR52))) {
> +                   sdhci_preset_value_support(host, ios->timing)) {
>                         u16 preset;
>
>                         sdhci_enable_preset_value(host, true);
> @@ -3934,6 +3929,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>          */
>         host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
>
> +       host->preset_value_support = (1 << MMC_TIMING_UHS_SDR12 ) |
> +                                    (1 << MMC_TIMING_UHS_SDR25 ) |
> +                                    (1 << MMC_TIMING_UHS_SDR50 ) |
> +                                    (1 << MMC_TIMING_UHS_SDR104) |
> +                                    (1 << MMC_TIMING_UHS_DDR50 ) |
> +                                    (1 << MMC_TIMING_MMC_DDR52 );
> +
>         return host;
>  }
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..79be471ff934 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -603,6 +603,9 @@ struct sdhci_host {
>         /* Host ADMA table count */
>         u32                     adma_table_cnt;
>
> +       /* Which transfer modes support preset value */
> +       u32                     preset_value_support;
> +
>         u64                     data_timeout;
>
>         unsigned long private[] ____cacheline_aligned;
> @@ -760,6 +763,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>         __sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>
> +static inline bool sdhci_preset_value_support(struct sdhci_host *host,
> +                                             unsigned char timing)
> +{
> +       if (timing < 32)
> +               return host->preset_value_support & (1 << timing);
> +       return false;
> +}
> +
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>                    unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>
>
>
>
>
> >
> > Fixes: 0dafa60eb2506 ("mmc: sdhci: also get preset value and driver type for MMC_DDR52")
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > The indentation changed because I ran clang-format
> >
> > Changes in v2:
> > - Fixed commit message. Patman didn't properly strip off the TEST= line.
> >
> >  drivers/mmc/host/sdhci.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 37b1158c1c0c9..fd702c436c165 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2360,12 +2360,13 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >               host->timing = ios->timing;
> >
> >               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> > -                             ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> > -                              (ios->timing == MMC_TIMING_UHS_SDR25) ||
> > -                              (ios->timing == MMC_TIMING_UHS_SDR50) ||
> > -                              (ios->timing == MMC_TIMING_UHS_SDR104) ||
> > -                              (ios->timing == MMC_TIMING_UHS_DDR50) ||
> > -                              (ios->timing == MMC_TIMING_MMC_DDR52))) {
> > +                 !mmc_doing_retune(mmc) &&
> > +                 ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> > +                  (ios->timing == MMC_TIMING_UHS_SDR25) ||
> > +                  (ios->timing == MMC_TIMING_UHS_SDR50) ||
> > +                  (ios->timing == MMC_TIMING_UHS_SDR104) ||
> > +                  (ios->timing == MMC_TIMING_UHS_DDR50) ||
> > +                  (ios->timing == MMC_TIMING_MMC_DDR52))) {
> >                       u16 preset;
> >
> >                       sdhci_enable_preset_value(host, true);
> >
>
