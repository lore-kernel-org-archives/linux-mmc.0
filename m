Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5DC04A95
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 08:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiI1IMU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiI1IMR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 04:12:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86747FFA8
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 01:12:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w10so11153108pll.11
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gPL+sDNRWPDOVqDV7eYVovApSlIMvj73WWnHgoRmIyM=;
        b=Zb3uk5IXYG4EiRgO/ssRDfN4IW4e7ucYOn56uUxrggZSlAzAeVBJFz6qac0m3Q8m5v
         F52L9rn3S/B2uK1n1AZ2bstRik3JV5doaTbwkGfskaY38+Z0JX/gWL0LMt9Cit5q9XA/
         NzmCm1OEpreADNW8nv3xAWS895dAANLH5+nJHvdmGZBulLSbwM+c3zqPg6Jz+iSGpF5J
         VMcu1YHvQGNa4aQZp7OyXZVLF/H0mO3wrTfUlrYiQh8eRbYQLUutlhVb+b1WKqqfYOBk
         BSg+7rN/w/dXT2VDm4B2te6skOuJkluv2O/UVsdbxTZd75RwhCv5Ni0qVZqUKgVEtPEQ
         GAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gPL+sDNRWPDOVqDV7eYVovApSlIMvj73WWnHgoRmIyM=;
        b=OWjTLG7J49lzWyTqSM5av/wgAjf5JPTwxx/CVqNqamH0+/kWHTK1MISmPWQI8G6/ly
         udkRgZjvNHliw8YOWstUkJrNwoJvGFtty8hvHS8JDCpjZH0qfFW53KkO914OkAuFSqiB
         IUdsntauAhwPSWYfTNteZEPcimF907RsGGAWPdxJTLQFL5dErS8HKsAetFEJ34xvQqS+
         RGgCInzPNWEVoTUDMaawpOoY1qx3Azf6F0owV18mK75sD5uOlyYABsEppW1HpLo9K94I
         7r2veUdbhthqTm1+zTbHTE4UEDO12ij/twK18LxfYB9aKH+/kHGPRvUukA98LBo6O8Ce
         3LmA==
X-Gm-Message-State: ACrzQf3qHQ9JeEaaX0VJpZ1Z/QphtvPdgegCCB7gRhhOTeByAQKlgIA4
        IIfUO7gbBfPMBKvN6Pzz3WSjUzQkYcyoNoFVOf7nmA==
X-Google-Smtp-Source: AMsMyM5QH27T71AWUGxWh2gqOZ09ud9ESJvZi5kqmN0DWXrc1VXUQvDX71Ds52OzjTqZQM05yEexJPRmDs6RPzxpEKc=
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id
 nu6-20020a17090b1b0600b00202cce02148mr9278323pjb.84.1664352734971; Wed, 28
 Sep 2022 01:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220926192022.85660-1-adrian.hunter@intel.com>
 <20220926192022.85660-4-adrian.hunter@intel.com> <YzMVJQVWVX0Htweb@orome>
In-Reply-To: <YzMVJQVWVX0Htweb@orome>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Sep 2022 10:11:38 +0200
Message-ID: <CAPDyKFpM8hSj82OPdScbMhUEEybp_SG0AvTbdLykhiJ=97BGpw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmc: sdhci: Get rid of SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, pshete@nvidia.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, anrao@nvidia.com, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Sept 2022 at 17:22, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Sep 26, 2022 at 10:20:21PM +0300, Adrian Hunter wrote:
> > SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS is used by only ENE controllers but can
> > be replaced by driver code.
> >
> > Amend the ENE code to hook the ->set_ios() mmc host operation and do the
> > reset there.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 23 ++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci.c          |  8 --------
> >  drivers/mmc/host/sdhci.h          |  2 --
> >  3 files changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index ed53276f6ad9..63613b3d648f 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -297,6 +297,27 @@ static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
> >                         SDHCI_QUIRK_MISSING_CAPS
> >  };
> >
> > +static void ene_714_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +     sdhci_set_ios(mmc, ios);
> > +
> > +     /*
> > +      * Some (ENE) controllers misbehave on some ios operations,
>
> Nice rewording that you snuck in there. =)

:-)

>
> I just realized, after going through the patches that Ulf has already
> applied this, but FWIW, the series:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

No problem, I will add your tag to the series. Thanks for reviewing!

Kind regards
Uffe
