Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF84CC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 20 May 2022 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbiETRXU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 May 2022 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352147AbiETRXT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2022 13:23:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB11187041;
        Fri, 20 May 2022 10:23:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j2so15382248ybu.0;
        Fri, 20 May 2022 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEVFlFzpMhPKagtCAx7Mp2QhohW11+oAJB8JBPmMmio=;
        b=RilbOgjwVk3qdpZdBXaHinkF+sOe4p1IpWx7P0VZUwxDIyymhVook3pPJc2tM01G5V
         oIVilPi8Dh0yaEZRr+a2+8xhpslWZQ0UvgXr9ZXTJZR7THqSsAdcAFhRW8DEuxT+kz8q
         y199zpvhnSuGFbcMcQ3Ojd/LTX35nVJL50k9Ayij2gZb6iySyWjhkEGqm32uLGajRYhM
         v1Tn8VwPhfD71ngFXoyGGzXffaxIhD8GxxLXWBakqLnpx1Ae0Aa0Uqnp6zIwBWRTQc6l
         ZVyB/k2CDIj7JcWaHqzJoVaW5PrdBg+dK24jhm9/0ins8yRjE6Ofjxi0AGx8VXy9ylVm
         HP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEVFlFzpMhPKagtCAx7Mp2QhohW11+oAJB8JBPmMmio=;
        b=V4PLTijDMKRWqXDqyHW5qN06UblBZ4jugOOdi/h1K4loc7Df5cqrhCTQ2CIm+yXp+p
         Y2niFxeOkTXGpzId0fNkSNI8wXSxgwn1KGRUxHEsvSy1lYlQGgvgupfX8y0UO89SRtyj
         kodAkP/T/dt5WI5ZwLlkmvMiFE931gdh2qen6x1DHo4DkohpS9n4JGahuiCtb7AxLvJR
         fKjhtRXRNHOUEzdM5SqeOSUSoVl1zWyiOEuFYtsAYLl6Zz+okWIbOOJcNlIsrlEzg1q+
         JO6B79G79WU5E4mVpOl6ParEfYATVR4uCtgfRsInPCi7/8ru11FhIwTPU1hfyPyLzaVO
         YDUA==
X-Gm-Message-State: AOAM530qsnT/qzi71PgTNxL4xszJ5mTLersirowDoPJc0gUI3gTGY6ts
        yjtYDOl5+hKqeii5zcmfh1CJ6WQbFaC99Exa/mA=
X-Google-Smtp-Source: ABdhPJwPw5CGdSfMxJ3GUxhEWLIB/0qIUyxWZD4uytMRikLfw1kJBSnyOgJNFluo990grHaPH+H4iHMdzpNYQDOjuhE=
X-Received: by 2002:a25:3452:0:b0:64e:1776:ce90 with SMTP id
 b79-20020a253452000000b0064e1776ce90mr10602677yba.261.1653067397554; Fri, 20
 May 2022 10:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220513201907.36470-1-kdasu.kdev@gmail.com> <20220513201907.36470-3-kdasu.kdev@gmail.com>
 <CAPDyKFpF_Swon5ZBRSq7M5Zq=8wUMa1q=68XfaD+RQqKYgNJVg@mail.gmail.com> <CAOGqxeUrEe8GUBiZzAkDKmpp2mQRK501ua6LOnaqyYHDNfawbg@mail.gmail.com>
In-Reply-To: <CAOGqxeUrEe8GUBiZzAkDKmpp2mQRK501ua6LOnaqyYHDNfawbg@mail.gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 20 May 2022 13:23:06 -0400
Message-ID: <CAC=U0a2s7QMRHAktbBn9N8ujiiD6MRbtsOJBxoVDWc0ET3KGwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock
 rate for 72116b0
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I think I seem to agree now that overloading the meaning of
max-frequency for the sdio_freq clock might not be a good idea. If
Uffe is Ok I think I will revert back to using the 'clock-frequency'
field in the brcmstb,sdhci-brcmstb dt node and implement other
suggestions as well

Kamal

On Thu, May 19, 2022 at 10:16 PM Alan Cooper <alcooperx@gmail.com> wrote:
>
> This seems confusing and seems to overload the meaning of
> "max-frequency" which is typically used to limit the clock rate to
> something slower than what's in the CAPs register as the base clock.
> Instead we're trying to overclock the controller because the hardware
> team has verified that it can be run faster than 100MHz which is how
> the system is configured and is in the CAPs register as the base
> clock.
>
> Al
>
> On Tue, May 17, 2022 at 8:50 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 13 May 2022 at 22:19, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> > >
> > > From: Al Cooper <alcooperx@gmail.com>
> > >
> > > The 72116B0 has improved SDIO controllers that allow the max clock
> > > rate to be increased from a max of 100MHz to a max of 150MHz. The
> > > driver will need to get the clock and increase it's default rate
> > > and override the caps register, that still indicates a max of 100MHz.
> > > The new clock will be named "sdio_freq" in the DT node's "clock-names"
> > > list. The driver will use a DT property, "clock-frequency", to
> >
> > /s/clock-frequency/max-frequency
> >
> >
> > > enable this functionality and will get the actual rate in MHz
> > > from the property to allow various speeds to be requested.
> > >
> > > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > ---
> > >  drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> > > index 8eb57de48e0c..a1ffdd3f1640 100644
> > > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > > @@ -250,6 +250,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> > >         struct sdhci_pltfm_host *pltfm_host;
> > >         const struct of_device_id *match;
> > >         struct sdhci_brcmstb_priv *priv;
> > > +       struct clk *master_clk;
> > > +       u32 base_clock_hz = 0;
> > > +       u32 actual_clock_mhz;
> > >         struct sdhci_host *host;
> > >         struct resource *iomem;
> > >         struct clk *clk;
> > > @@ -330,6 +333,33 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> > >         if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
> > >                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > >
> > > +       /* Change the base clock frequency if the DT property exists */
> > > +       if (device_property_read_u32(&pdev->dev, "max-frequency",
> > > +                                    &base_clock_hz) != 0)
> > > +               goto add_host;
> >
> > The max-frequency DT property is already being parsed by
> > mmc_of_parse() and the value is put in host->mmc->f_max. You could
> > probably use that instead, right?
> >
> > > +
> > > +       master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
> > > +       if (IS_ERR(master_clk)) {
> > > +               dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
> > > +               goto add_host;
> > > +       } else {
> > > +               res = clk_prepare_enable(master_clk);
> > > +               if (res)
> > > +                       goto err;
> > > +       }
> > > +
> > > +       /* set improved clock rate */
> > > +       clk_set_rate(master_clk, base_clock_hz);
> > > +       actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
> > > +
> > > +       host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
> > > +       host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
> > > +       /* Disable presets because they are now incorrect */
> > > +       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> > > +       dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
> > > +               actual_clock_mhz);
> > > +
> > > +add_host:
> > >         res = sdhci_brcmstb_add_host(host, priv);
> > >         if (res)
> > >                 goto err;
> > > --
> > > 2.17.1
> > >
> >
> > Kind regards
> > Uffe
