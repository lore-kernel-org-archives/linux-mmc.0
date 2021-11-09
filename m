Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DCC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E079661159
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhKIUE0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 15:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbhKIUEZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 15:04:25 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909EC061764
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 12:01:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h11so770120ljk.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 12:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ9MmBgG6DxG+MYA4zF7fuyzEizobKE/7ttDVS9RbSI=;
        b=YotoFmkvLVN9hGvdjKO6754H+mRouO/8wPYkVGz9XafEoXduK9gT1fq15dDJM37lPu
         ksQ7tEYcTBWb3hDUjRo6c7n8zDMhyZNx9WEO/GXY7n3cJ7GeYd0lsOyqHGLAJfK0O8gt
         qa523oeFiITkccbKIThlj8UwPySSeDlslIiJUdZHm8Y0eyf9QkVpNlZYDsgd+4q6aOYZ
         FKCeAlCesK8dM5sgKG/3nli04AqYjXBRke4/TKJdBqlL/zVxJ2p84XbX2F6d5//xmOmB
         6en+Q7WPyRnvQ03koE+7ANI7Tjq23go5CQu0fDTSlDBIvxmwZIzjoXwIiQNtdTp6Yb0p
         3wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ9MmBgG6DxG+MYA4zF7fuyzEizobKE/7ttDVS9RbSI=;
        b=XBa39LEeIebbehWw7lG3FKaAepMj5YGzNcw92vQjPTRfCpokr23imHXl0/cMLhgk0f
         BJCdG5Boalm0DJC2SQAoAkv/F+LTQI5LzCp+Gxtk8r52LQMzgKZm2TiDjWWKkl92bO8O
         fieA0Zzt6JbuohVjmPKfRIDuwlujtdEyf2d5KWTT50F38YxxIdHDbWEiTMvBtfkHLMyP
         cGD9nP/IpMp3zGwxp+HDffcDuhjyvB3VFI/BdVoEmUAE40sklyneOlnTLGwKYwJFKAl/
         MIPVrFizrEexPEXoY7bKQhrmmSGM3/+xVr/xuArFhC5chaqWi4no/MGvuQuJ3Wguo9Gt
         c1Cg==
X-Gm-Message-State: AOAM533ukEiVgSl0Ar9muWCL3OXm7q4TWaeyYLDM9ciW4wchjpGkvpfv
        gNNVFvS4lUS2UDyqibLMDdndDouRjyEe/s9YzkcWhw==
X-Google-Smtp-Source: ABdhPJwVaBI44PRdZKlS7WK32pjyDHE8ubBG5Y9qIuUBfw5lxhW9wJ8sT6wx9GyLO9Ugcgo+pXkEp/zWBOVTIC6NeqM=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr10580377ljg.4.1636488097447;
 Tue, 09 Nov 2021 12:01:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636103151.git.hns@goldelico.com> <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
 <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com> <C2F065E7-10C5-4701-A6F7-6B5A6198F0DF@goldelico.com>
In-Reply-To: <C2F065E7-10C5-4701-A6F7-6B5A6198F0DF@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Nov 2021 21:01:01 +0100
Message-ID: <CAPDyKFoz6b-+HQYdypYD7EUXxwj7th-=41MAK=ZTnKQWRmLArQ@mail.gmail.com>
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        =?UTF-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Nov 2021 at 11:58, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Ulf,
>
> > Am 08.11.2021 um 16:33 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
> >
> > On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>
> >> +       card->quirks |= MMC_QUIRK_NONSTD_SDIO;
> >> +       card->cccr.wide_bus = 1;
> >> +       card->cis.vendor = 0x104c;
> >> +       card->cis.device = 0x9066;
> >> +       card->cis.blksize = 512;
> >> +       card->cis.max_dtr = 24000000;
> >> +       card->ocr = 0x80;
> >
> > In the past, we discussed a bit around why card->ocr needs to be set here.
> >
> > The reason could very well be that the DTS file is specifying the
> > vmmc-supply with 1.8V fixed regulator, which seems wrong to me.
>
> I have checked with the schematics but the wlan_en regulator-fixed is just a GPIO
> controlling some pin of the wifi chip.
>
> I guess it enables some regulator or power switch inside the wifi module which
> has unknown voltage.
>
> We can interpret this as two sequential power-switches. The first one controlled
> by the gpio-register bit and switches gpio power to the gpio pad of the SoC. The second
> one switches the battery voltage to the internal circuits of the wifi module.
>
> The GPIO itself is on 1.8V VIO level which seems to be the reason for the min/max.
>
> Now it is a little arbitrary what the DTS describes: the gpio voltage or the unknown
> internal voltage of the second switch.
>
> So from hardware perspective the min/max values are irrelevant.

I completely agree with you! That's also why I earlier suggested
moving to use an mmc-pwrseq node
(Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml), that
would allow a better description of the HW.

Nevertheless, the important point is that the mmc core gets a valid
host->ocr_avail to work with during card initialization. And in this
case, it's probably good enough to model this via changing the
regulator-min|max-microvolt to get a proper value from the
"regulator".

>
> >
> > I would be very interested to know if we would change
> > "regulator-min|max-microvolt" of the regulator in the DTS, into
> > somewhere in between 2700000-3600000 (2.7-3.6V)
>
> Ok, if the mmc driver does something with these values it may have indeed an influence.
>
> > - and see if that
> > allows us to drop the assignment of "card->ocr =  0x80;" above. Would
> > you mind doing some tests for this?
>
> Well, with min/max=3.3V and no ocr I get:
>
> [    2.765136] omap_hsmmc 480ad000.mmc: card claims to support voltages below defined range
> [    2.776367] omap_hsmmc 480ad000.mmc: found wl1251
> [    2.782287] mmc2: new SDIO card at address 0001

That's really great information! During the first initialization
attempt, things are working fine and the SDIO card gets properly
detected.

> [   10.874237] omap_hsmmc 480ad000.mmc: could not set regulator OCR (-22)
> [   10.945373] wl1251_sdio: probe of mmc2:0001:1 failed with error -16

It looks like the card is being re-initialized when it's time to probe
with the SDIO func driver. This makes sense, assuming it's been
powered off via runtime PM (the "cap-power-off-card" DT property
should be set in the DTS for this card's slot).

I looked a bit closer to understand the problem above and then I
realized why the card->ocr is being set from omap_hsmmc ->init_card()
callback. It's most likely because the mmc core in
mmc_sdio_init_card() doesn't save the card->ocr when
MMC_QUIRK_NONSTD_SDIO is set. Instead it becomes the responsibility
for the ->init_card() callback to do it, which seems wrong to me.

Note that the card->ocr is being used when re-initializing the SDIO card.

I have just sent a patch [1], would you mind trying it, in combination
with not assigning card->ocr in $subject patch?

>
> Adding back card->ocr = 0x80 (and keeping 3.3V for min/max) shows exactly the same.
>
> Only min/max 1.8V + OCR works:
>
> [    2.824188] mmc2: new SDIO card at address 0001
> [    2.806518] omap_hsmmc 480ad000.mmc: card claims to support voltages below defined range
> [    2.815979] omap_hsmmc 480ad000.mmc: found wl1251
> [   10.981018] omap_hsmmc 480ad000.mmc: found wl1251
> [   11.018280] wl1251: using dedicated interrupt line
> [   11.321136] wl1251: loaded
> [   11.378601] wl1251: initialized
> [   14.521759] omap_hsmmc 480ad000.mmc: found wl1251
> [   38.680725] omap_hsmmc 480ad000.mmc: found wl1251
> [   39.646942] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at 0x3a780
> [   39.654785] wl1251: firmware booted (Rev 4.0.4.3.7)
>
> Therefore I also tried the 4th combination: min/max 1.8V and no ocr quirk and it fails again.
>
> Finally I tried setting min to 2.7V and max to 3.6V. This ends up in
>
> [    0.402648] reg-fixed-voltage fixed-regulator-wg7210_en: Fixed regulator specified with variable voltages
>
> So it seems that we need both: min/max = 1.8V and OCR. A little unexpected since I had expected
> that min/max is completely irrelevant.
>
> > If that works, we should add some comments about it above, I think.
>
> So at the moment no change for [PATCH v1] which I can now send out.
>
> BR and thanks,
> Nikolaus
>

Thanks a lot for doing these tests! If I am right, it looks like we
should be able to skip assigning card->ocr for this quirk, but let's
see.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/20211109192547.28679-1-ulf.hansson@linaro.org/
