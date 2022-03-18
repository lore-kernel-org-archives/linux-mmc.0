Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE4EC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Mar 2022 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiCRNkk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiCRNkj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2022 09:40:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233CC1C7EA5
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 06:39:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p6so6952905lfh.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VD6iA//rl+G0UvkOMm0n4elOqulyLO/Rgg1ugKzl5M8=;
        b=Mtl+So5/Jxp9GNKNlJjBsh+Bil+WakboMMsGp4hKJFPuYHwP4D2q1jZlMV06P6ocZB
         jZrveQqftZmscyyD0wShKftQyIxD20+9ffsUuQ5/o2cpIB0kXaXvSrDDtBDGzErGq8I6
         POmphZeOAxRsBbKs4qawH+BLivYvyau2uQ+IWKv/48DgHCB7p/VXYyp4X9q3zzmQ/Ryj
         d/J0WIwN0ZB1ihb2VFDHcgaWQj2hbE1aP8dCt5D6XKNGVGCaweNi7lgCuZxAgSMbgeEB
         tIpJ9D2XX9Il65VJAmVRhof7+/OhQ5aHnFRoiA1cyKLXZ3YnBoM49q1GsPZgsrdxORto
         rqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VD6iA//rl+G0UvkOMm0n4elOqulyLO/Rgg1ugKzl5M8=;
        b=VSslGUwHRM8pwsLN3yCkSq5mECD1Z2E78e1YpfpnnDfAuBMwqXYoTxHvkh8zBG7Q5F
         72Jvc69mLdw9vBA8DpP4Gixpotofd0jg+PX+Qtc9N2TDgR//aaRg2rwDdFprGhQyJXIo
         Z6gTBIwfDvqX2pdYk0lAivyhoBG0IK970JUhBaJTx3mupT5pn2deaaTrjmHw0x1ic4dm
         hEDf+OkBl4TslirhyNmLCX8M2877JOn5/POCBWPl4Cb5VC+WcK1piv8mabf/SJWpsUTo
         W8OorIXPnPbvqSmVQCCzRuVdYWGy6MoM1Bhf6F0VZf3MFXb4mp2vkkM0v/RzDABg4VkV
         UfGw==
X-Gm-Message-State: AOAM530QuszWG4qOGA9+SyUFLm96/8CdyuOmu/a3z1f9qFdb+iftiLrb
        oDjB5au88ULx6IronwMnVU6p9+KXBOVJpVhegueTug==
X-Google-Smtp-Source: ABdhPJyRyNhnCTgNlv5CqHoQl4al/grplnra/gw9rcQSwMrSnJYHrkRYV2pjITN+iYPZ+sjmEUMY2McF1cx6dtsQqSE=
X-Received: by 2002:a05:6512:3f99:b0:447:7fc0:8d3 with SMTP id
 x25-20020a0565123f9900b004477fc008d3mr6100043lfa.671.1647610757400; Fri, 18
 Mar 2022 06:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201211141656.24915-1-mw@semihalf.com> <CAPDyKFqsSO+f9iG8vccwXZXDDNHgLEg7bfUe-KfHn2C-ZnOU4A@mail.gmail.com>
 <20220314154033.4x74zscayee32rrj@pali> <CAPv3WKc4MFeLgnJMWx=YNT5Ta5yi6fVhb4f-Rf211FTEmkvyog@mail.gmail.com>
 <20220315230333.eyznbu5tuxneizbs@pali> <CAPv3WKc96vDsW_duXYMYbr3X05=-p28N5_cf2PHo-tiwDLjaWg@mail.gmail.com>
 <20220318130100.zkdaoviwzwhnixuh@pali> <20220318130615.hwa5fhzf2cyquwzr@pali>
In-Reply-To: <20220318130615.hwa5fhzf2cyquwzr@pali>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 18 Mar 2022 14:39:05 +0100
Message-ID: <CAPv3WKcAgYS8=CWt-JmTT+Jx9LUU588kkrG1Xo6=W=NUkZ9K4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix 1.8v regulator stabilization
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Alex Leibovich <alexl@marvell.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pali,

Thanks for testing!

pt., 18 mar 2022 o 14:06 Pali Roh=C3=A1r <pali@kernel.org> napisa=C5=82(a):
>
> On Friday 18 March 2022 14:01:00 Pali Roh=C3=A1r wrote:
> > On Wednesday 16 March 2022 02:03:35 Marcin Wojtas wrote:
> > > Hi Pali,
> > >
> > > =C5=9Br., 16 mar 2022 o 00:03 Pali Roh=C3=A1r <pali@kernel.org> napis=
a=C5=82(a):
> > > >
> > > > Hello!
> > > >
> > > > On Monday 14 March 2022 16:51:25 Marcin Wojtas wrote:
> > > > > Hi Pali,
> > > > >
> > > > >
> > > > > pon., 14 mar 2022 o 16:40 Pali Roh=C3=A1r <pali@kernel.org> napis=
a=C5=82(a):
> > > > > >
> > > > > > On Monday 11 January 2021 19:06:24 Ulf Hansson wrote:
> > > > > > > On Fri, 11 Dec 2020 at 15:17, Marcin Wojtas <mw@semihalf.com>=
 wrote:
> > > > > > > >
> > > > > > > > From: Alex Leibovich <alexl@marvell.com>
> > > > > > > >
> > > > > > > > Automatic Clock Gating is a feature used for the power
> > > > > > > > consumption optimisation. It turned out that
> > > > > > > > during early init phase it may prevent the stable voltage
> > > > > > > > switch to 1.8V - due to that on some platfroms an endless
> > > > > > > > printout in dmesg can be observed:
> > > > > > > > "mmc1: 1.8V regulator output did not became stable"
> > > > > > > > Fix the problem by disabling the ACG at very beginning
> > > > > > > > of the sdhci_init and let that be enabled later.
> > > > > > > >
> > > > > > > > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon S=
DHC core functionality")
> > > > > > > > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > > > > > > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > >
> > > > > > > Applied for fixes (by fixing the typos), thanks!
> > > > > >
> > > > > > Hello!
> > > > > >
> > > > > > Is not this patch address same issue which was fixed by patch w=
hich was
> > > > > > merged earlier?
> > > > > >
> > > > > > bb32e1987bc5 ("mmc: sdhci-xenon: fix annoying 1.8V regulator wa=
rning")
> > > > > > https://lore.kernel.org/linux-mmc/CAPDyKFqAsvgAjfL-c9ukFNWeGJmu=
fQosR2Eg9SKjXMVpNitdkA@mail.gmail.com/
> > > > > >
> > > > >
> > > > > This indeed look similar. This fix was originally developed for C=
N913x
> > > > > platform without the mentioned patch (I'm wondering if it would a=
lso
> > > > > suffice to fix A3k board's problem). Anyway, I don't think we hav=
e an
> > > > > issue here, as everything seems to work fine on top of mainline L=
inux
> > > > > with both changes.
> > > >
> > > > Yea, there should be no issue. Just question is if we need _both_ f=
ixes.
> > > >
> > > > I could probably try to revert bb32e1987bc5 and check what happens =
on
> > > > A3k board.
> > > >
> > >
> > > Yes, that would be interesting. Please let me know whenever you find
> > > time to check.
> >
> > Hello! Now I tested kernel with reverted commit bb32e1987bc5 ("mmc:
> > sdhci-xenon: fix annoying 1.8V regulator warning") and issue is still
> > fixed. I reverted also bb32e1987bc5 ("mmc: sdhci-xenon: fix annoying
> > 1.8V regulator warning") commit and then issue appeared again.
>
> I mean that I reverted also 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v
> regulator stabilization") commit and then issue appeared again.
>
> > So any of this commit is fixing that issue on Armada 3720.
> >

I think both can stay, but if I had to choose, I'd keep 1a3ed0dc3594
("mmc: sdhci-xenon: fix 1.8v regulator stabilization"):
* Now we know for sure it fixes both Armada 3720 and CN913x/Armada 7k8k
* Afaik this patch was checked with HW team (and IMO it looks a bit
less hacky than the extra read :) ).

Best regards,
Marcin


> > Should we revert one of them?
> >
> > > Best regards,
> > > Marcin
> > >
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
> > > > > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/h=
ost/sdhci-xenon.c
> > > > > > > > index c67611fdaa8a..4b05f6fdefb4 100644
> > > > > > > > --- a/drivers/mmc/host/sdhci-xenon.c
> > > > > > > > +++ b/drivers/mmc/host/sdhci-xenon.c
> > > > > > > > @@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sd=
hci_host *host,
> > > > > > > >         /* Disable tuning request and auto-retuning again *=
/
> > > > > > > >         xenon_retune_setup(host);
> > > > > > > >
> > > > > > > > -       xenon_set_acg(host, true);
> > > > > > > > +       /*
> > > > > > > > +        * The ACG should be turned off at the early init t=
ime, in order
> > > > > > > > +        * to solve a possile issues with the 1.8V regulato=
r stabilization.
> > > > > > > > +        * The feature is enabled in later stage.
> > > > > > > > +        */
> > > > > > > > +       xenon_set_acg(host, false);
> > > > > > > >
> > > > > > > >         xenon_set_sdclk_off_idle(host, sdhc_id, false);
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.29.0
> > > > > > > >
