Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B24C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 20 May 2022 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbiETCQL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 May 2022 22:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiETCQK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2022 22:16:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4591926AF7;
        Thu, 19 May 2022 19:16:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b11so4796568ilr.4;
        Thu, 19 May 2022 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9fsuYSv3AFjP2s3tX+rRvTxLfT6NzxRhVMjjVIRu9A=;
        b=Mh2hUJAmXUEOKdWDmaZVYvTz+inntKx6aNXQhQRzWkyWc+/yaUtyZlH7ZXYnp2dh62
         qz8gcxAV6o77gxr9kJzvVXZOZvpNKucXsE7ovU19SqhB4iBnQPsiJLI9orLIz+MhUVN5
         zsstHxb6GVPiKRvkDbC9H4qvk6BCJjQin+EUqAOdhA4wdgDpZKWnOuo/epI2lqtpvMgw
         qcxvqvhoHdt5PxyjfWlcYBimBXwuolA/ohRif4szftLUU30N0A2a3q5Wimb0K9CPGNRC
         3jirpCOkuTSq3NEcHmxf9JRUpekb3+g9vDNS8QeSYFXeBCtrN7y+aoMsxdF8v9oNOM+y
         8uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9fsuYSv3AFjP2s3tX+rRvTxLfT6NzxRhVMjjVIRu9A=;
        b=3uLwajXAUH2bfBMe2KtJd+s58qZbox3Qz+8nh7mioYHG7BVvU3voDqFEl4SRaf7TdP
         Z9y3+OdWowe51nDzqWF1MuZGHLLA7tdjODTi2Iln49Z0KC2il83o+1FdourjmbOwTy8G
         z4naQ5KG9L3PbM3mhtEBGwe6GX0NfEW7VlnYjU+hIMKk5lbcOIasbhY4W3E4fmPAPU31
         hN2cxN4dr3lpcSkP8e1os2mbXUd91glJibC5O7muf7qqhX92kcnOaidBUV9mqc5Grr1z
         3n7TbjivOVY/+mVvntas9iUIgKHjksYI0qvND/NrFC58hnKr/hPGY43A11Qz58EcwtiL
         XtNg==
X-Gm-Message-State: AOAM532ff3lSJFmyuaXpFl/T9H4YuyqJxWsQDgx/e7QBPiT7QAmMvr25
        ioRhyMYHgXNqtXl1vTdQT/yjoDQfRtTt5OXZCLo=
X-Google-Smtp-Source: ABdhPJyII6Ge5nBMnmBqpXczGeVK30TV9HE9iSYEj50NOr/4HlM6ql2umXkRuR1KA27Z+zxAayVXh61fQ/qtU7t8rfM=
X-Received: by 2002:a05:6e02:1d0a:b0:2cd:fdde:a28e with SMTP id
 i10-20020a056e021d0a00b002cdfddea28emr4286910ila.228.1653012967625; Thu, 19
 May 2022 19:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220513201907.36470-1-kdasu.kdev@gmail.com> <20220513201907.36470-3-kdasu.kdev@gmail.com>
 <CAPDyKFpF_Swon5ZBRSq7M5Zq=8wUMa1q=68XfaD+RQqKYgNJVg@mail.gmail.com>
In-Reply-To: <CAPDyKFpF_Swon5ZBRSq7M5Zq=8wUMa1q=68XfaD+RQqKYgNJVg@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 19 May 2022 22:15:56 -0400
Message-ID: <CAOGqxeUrEe8GUBiZzAkDKmpp2mQRK501ua6LOnaqyYHDNfawbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock
 rate for 72116b0
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
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

This seems confusing and seems to overload the meaning of
"max-frequency" which is typically used to limit the clock rate to
something slower than what's in the CAPs register as the base clock.
Instead we're trying to overclock the controller because the hardware
team has verified that it can be run faster than 100MHz which is how
the system is configured and is in the CAPs register as the base
clock.

Al

On Tue, May 17, 2022 at 8:50 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 13 May 2022 at 22:19, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > From: Al Cooper <alcooperx@gmail.com>
> >
> > The 72116B0 has improved SDIO controllers that allow the max clock
> > rate to be increased from a max of 100MHz to a max of 150MHz. The
> > driver will need to get the clock and increase it's default rate
> > and override the caps register, that still indicates a max of 100MHz.
> > The new clock will be named "sdio_freq" in the DT node's "clock-names"
> > list. The driver will use a DT property, "clock-frequency", to
>
> /s/clock-frequency/max-frequency
>
>
> > enable this functionality and will get the actual rate in MHz
> > from the property to allow various speeds to be requested.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> > index 8eb57de48e0c..a1ffdd3f1640 100644
> > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > @@ -250,6 +250,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >         struct sdhci_pltfm_host *pltfm_host;
> >         const struct of_device_id *match;
> >         struct sdhci_brcmstb_priv *priv;
> > +       struct clk *master_clk;
> > +       u32 base_clock_hz = 0;
> > +       u32 actual_clock_mhz;
> >         struct sdhci_host *host;
> >         struct resource *iomem;
> >         struct clk *clk;
> > @@ -330,6 +333,33 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >         if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
> >                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> >
> > +       /* Change the base clock frequency if the DT property exists */
> > +       if (device_property_read_u32(&pdev->dev, "max-frequency",
> > +                                    &base_clock_hz) != 0)
> > +               goto add_host;
>
> The max-frequency DT property is already being parsed by
> mmc_of_parse() and the value is put in host->mmc->f_max. You could
> probably use that instead, right?
>
> > +
> > +       master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
> > +       if (IS_ERR(master_clk)) {
> > +               dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
> > +               goto add_host;
> > +       } else {
> > +               res = clk_prepare_enable(master_clk);
> > +               if (res)
> > +                       goto err;
> > +       }
> > +
> > +       /* set improved clock rate */
> > +       clk_set_rate(master_clk, base_clock_hz);
> > +       actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
> > +
> > +       host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
> > +       host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
> > +       /* Disable presets because they are now incorrect */
> > +       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> > +       dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
> > +               actual_clock_mhz);
> > +
> > +add_host:
> >         res = sdhci_brcmstb_add_host(host, priv);
> >         if (res)
> >                 goto err;
> > --
> > 2.17.1
> >
>
> Kind regards
> Uffe
