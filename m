Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E0C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Mar 2022 01:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiCPBFB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 21:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiCPBFB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 21:05:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB7BC0B
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 18:03:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o6so1200080ljp.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 18:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nhmwtf/VjoQV7F5h0NhBM6NJo4NB3/oDyqq5QgKUcBo=;
        b=XK6ukyJcvRudCRFreqwkI/ZibKG5OxRAZAZKt0vdZYPRwhihL8jVgAQutWBInC/+U8
         oN5bKJWIL9Czm3Hd68rOx+kHlXfrmAWFcSl8HeEkMtvg4YfWoz39R/zC2bhsip5jCXYb
         CauKoudJ/QFlP5RZAGpoVbY8Td6WINL6xtG5d6DKEI/nEeoCG7guBuT2VFRPFGT0DsKp
         MIJeksid/Uj8o84X19iL0UQQuhCnbMErWbUZP9TSWCNz0v3ob76iQku5az/2z2dtziZ6
         2d1gAahHloqs/pUJYO4C08f8gPodGcAhc8ZLxWqJ77MRVGwl0n9WMz+HQotsY9FEp7VG
         JHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nhmwtf/VjoQV7F5h0NhBM6NJo4NB3/oDyqq5QgKUcBo=;
        b=2HGGMcXmHUEehaNLWPc8bs6VX7jdk1N7ZUiOFVSUBIgm+j396JvvmdaQAhWfdeaQ/i
         MscWWvmPbkHprmNSbBE3+CFT5aZzb65qIeWNuGhrcg+vqK8lcnJt+eW2xp5DCiEdi0Gv
         RsfOjFfNUP0POHK7Z7RU7cq0o05TEBTZqV/2LI/C0TC9VW6cA8sa3Kvg108wnEg5ypJc
         0vRdIh9JclWnNAazIfBViUJeNKVCt5Weqw2OTp4WFRN+7DFrNu+KcqGuUKyGSR0ddONK
         XgZdVH+Vk5STRnn1t8TXCb56vSfkID/vEkNdzMGXZsdn+PsXVUD+J1Fd+pKdRon/v5/0
         HF4Q==
X-Gm-Message-State: AOAM532fVmCrRg3/XssSCDQyGbe0h+lGDX7irISE66uhpWG48w7RfdZB
        9kxMGKXEgdu6fqUZtrDT8OfGcd0cMPD/OsZia/D8eg==
X-Google-Smtp-Source: ABdhPJyCf73Ia/8zLvpmsufs/bjwOHOazg++Gw0hXDw/QV8/e2mFDrs+TGn7YwFIBM7OUFLVjACS3f2wdOxePnW6NlU=
X-Received: by 2002:a05:651c:a06:b0:246:71a3:556a with SMTP id
 k6-20020a05651c0a0600b0024671a3556amr18781599ljq.5.1647392625976; Tue, 15 Mar
 2022 18:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201211141656.24915-1-mw@semihalf.com> <CAPDyKFqsSO+f9iG8vccwXZXDDNHgLEg7bfUe-KfHn2C-ZnOU4A@mail.gmail.com>
 <20220314154033.4x74zscayee32rrj@pali> <CAPv3WKc4MFeLgnJMWx=YNT5Ta5yi6fVhb4f-Rf211FTEmkvyog@mail.gmail.com>
 <20220315230333.eyznbu5tuxneizbs@pali>
In-Reply-To: <20220315230333.eyznbu5tuxneizbs@pali>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 16 Mar 2022 02:03:35 +0100
Message-ID: <CAPv3WKc96vDsW_duXYMYbr3X05=-p28N5_cf2PHo-tiwDLjaWg@mail.gmail.com>
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

=C5=9Br., 16 mar 2022 o 00:03 Pali Roh=C3=A1r <pali@kernel.org> napisa=C5=
=82(a):
>
> Hello!
>
> On Monday 14 March 2022 16:51:25 Marcin Wojtas wrote:
> > Hi Pali,
> >
> >
> > pon., 14 mar 2022 o 16:40 Pali Roh=C3=A1r <pali@kernel.org> napisa=C5=
=82(a):
> > >
> > > On Monday 11 January 2021 19:06:24 Ulf Hansson wrote:
> > > > On Fri, 11 Dec 2020 at 15:17, Marcin Wojtas <mw@semihalf.com> wrote=
:
> > > > >
> > > > > From: Alex Leibovich <alexl@marvell.com>
> > > > >
> > > > > Automatic Clock Gating is a feature used for the power
> > > > > consumption optimisation. It turned out that
> > > > > during early init phase it may prevent the stable voltage
> > > > > switch to 1.8V - due to that on some platfroms an endless
> > > > > printout in dmesg can be observed:
> > > > > "mmc1: 1.8V regulator output did not became stable"
> > > > > Fix the problem by disabling the ACG at very beginning
> > > > > of the sdhci_init and let that be enabled later.
> > > > >
> > > > > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC co=
re functionality")
> > > > > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > > > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > Applied for fixes (by fixing the typos), thanks!
> > >
> > > Hello!
> > >
> > > Is not this patch address same issue which was fixed by patch which w=
as
> > > merged earlier?
> > >
> > > bb32e1987bc5 ("mmc: sdhci-xenon: fix annoying 1.8V regulator warning"=
)
> > > https://lore.kernel.org/linux-mmc/CAPDyKFqAsvgAjfL-c9ukFNWeGJmufQosR2=
Eg9SKjXMVpNitdkA@mail.gmail.com/
> > >
> >
> > This indeed look similar. This fix was originally developed for CN913x
> > platform without the mentioned patch (I'm wondering if it would also
> > suffice to fix A3k board's problem). Anyway, I don't think we have an
> > issue here, as everything seems to work fine on top of mainline Linux
> > with both changes.
>
> Yea, there should be no issue. Just question is if we need _both_ fixes.
>
> I could probably try to revert bb32e1987bc5 and check what happens on
> A3k board.
>

Yes, that would be interesting. Please let me know whenever you find
time to check.

Best regards,
Marcin

> > > >
> > > >
> > > > > ---
> > > > >  drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sd=
hci-xenon.c
> > > > > index c67611fdaa8a..4b05f6fdefb4 100644
> > > > > --- a/drivers/mmc/host/sdhci-xenon.c
> > > > > +++ b/drivers/mmc/host/sdhci-xenon.c
> > > > > @@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sdhci_ho=
st *host,
> > > > >         /* Disable tuning request and auto-retuning again */
> > > > >         xenon_retune_setup(host);
> > > > >
> > > > > -       xenon_set_acg(host, true);
> > > > > +       /*
> > > > > +        * The ACG should be turned off at the early init time, i=
n order
> > > > > +        * to solve a possile issues with the 1.8V regulator stab=
ilization.
> > > > > +        * The feature is enabled in later stage.
> > > > > +        */
> > > > > +       xenon_set_acg(host, false);
> > > > >
> > > > >         xenon_set_sdclk_off_idle(host, sdhc_id, false);
> > > > >
> > > > > --
> > > > > 2.29.0
> > > > >
