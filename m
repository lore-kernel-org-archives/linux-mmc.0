Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615DC433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1542072A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 15:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIBPvg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:51:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46752 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIBPvf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 11:51:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id u126so4780867oif.13;
        Wed, 02 Sep 2020 08:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JeD4q3u5m7TYib0XXdTzqaKmJDZ9r459ZslYXgh8lw=;
        b=R0RP1QqWC6Vl5ns9rFZZPBpOcsrxGubYGd35tp7med77+8iTPnX0Njt0CTmQiDBc95
         XuZDr6jM8PaZ2LrBdNNNG9d2En1Kt01RfUQP7VUKx7TAWoFmZTzzgBiKhF20Qwg7mlUU
         1/TkmMXr1G++itn360HLqRXoNJwGBd1vCogIXoFZ5XZvp1AtkfySwNnrki6YvsEAnQJU
         KXOKimvFqqOe5PkjlTiHfsyv8StnnP6rPvR3aRgIEi5uPhl8z+bRIF7JEzNkWHJqJd9H
         fKNVj/42by9YxO1eV/xFnSckdLkJdhsoTipbZXREOFggzTt7tC3oKZ5g0Lt6TGiB9Ook
         2opw==
X-Gm-Message-State: AOAM531uSrSVMDskfGkG0AlrfGNMD5S1raKkQ/khFFP/FMXOsjC8Ja6y
        TbijvlGJiXWHLX1+oHUqxTY3D23tKR+rjs7gZK3638xx
X-Google-Smtp-Source: ABdhPJxae6UIMdm5zyNbrXO7nReKqvFeikbvh88AnM0v5RcEpiean7ErLZWr+e2Mgvg5T/MqKiUm1LPR+XrJcw1TLSs=
X-Received: by 2002:aca:d509:: with SMTP id m9mr2399947oig.71.1599061888397;
 Wed, 02 Sep 2020 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
 <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
 <20200901154049.GA376@lst.de> <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
 <20200902134418.GR3265@brightrain.aerifal.cx>
In-Reply-To: <20200902134418.GR3265@brightrain.aerifal.cx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Sep 2020 17:51:16 +0200
Message-ID: <CAMuHMdUiPhHtkQfcpMSA6HMvmcFyg__rSGUoHRKQfQf2N5QTYA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
To:     Rich Felker <dalias@libc.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rich,

On Wed, Sep 2, 2020 at 5:43 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, Sep 02, 2020 at 10:31:47AM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 17:40, Christoph Hellwig <hch@lst.de> wrote:
> > > On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > > > > I still don't think this makes sense, as the dma_mask should always
> > > > > be non-NULL here.
> > > >
> > > > If that is the case, I wonder how the driver could even have worked without DMA.
> > > >
> > > > Because in the existing code, host->dma_dev gets assigned to
> > > > spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> > > > usage in the driver.
> > > >
> > > > What am I missing?
> > >
> > > Do you know of other non-DMA users?  For SH nommu it probably worked
> >
> > I don't know of other non-DMA users. As I said, I wish someone could
> > step in and take better care of mmc_spi - as I know it's being used a
> > lot.
> >
> > > because SH nommu used to provide a DMA implementation that worked
> > > fine for streaming maps, but was completely broken for coherent
> > > allocation.  And this driver appears to only use the former.
> >
> > Alright, so you are saying the DMA support may potentially never have
> > been optional to this driver. In any case, I can remove the check in
> > $subject patch, as it shouldn't matter.
>
> DMA support was always optional, because even on systems where DMA is
> present, it doesn't necessarily mean the SPI controller uses DMA. In
> particular, pure bit-banged SPI via GPIOs doesn't have DMA, but has
> always worked. See my previous reply to Christoph about host->dma_dev
> for my current-best understanding of what's going on here.
>
> > Anyway, let's see what Rich thinks of this. I am curious to see if the
> > patch works on his SH boards - as I haven't been able to test it.
>
> I'll rebuild and retest just to confirm, but I already tested a
> functionally equivalent patch that just did the #ifdef inline (rather
> than moving the logic out to separate functions) and it worked fine.

Hence, Tested-by? ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
