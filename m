Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B3C18E5A
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036924649
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 09:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUIzwQPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgCJJFs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:05:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33925 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJJFs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 05:05:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id y204so7920429vsy.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDHNp0kW8UZ5wVwRVY7Vrr/1bl/yMtFsFyxPULVhd4I=;
        b=FUIzwQPCeu8dBEpHx+yYi9CrbOu7d822Ma/8XKSFj5B1UjoSmkI6kkIPNbTsw5ATUy
         A3ncpVnV0xTpdQIRlM3pKOmrUbSZfWjQTW8DPstw6sBqsP3U+somaNvfQUGfWcilrWGv
         7VA9VtR5rjQYbWAfv2Kkp+jvj2/O/DU/e9w4H8TqadcsLJ/RhSWa20K5+UMEnqH9v/Sk
         ss8FcDFWhI3F0IlztcY49V9LDuTk9vCT19bwgu7J2DeOh4WTyAEczlXch7IML4rWOFdh
         FFgT9DBjaZ7sxNABFHIueqhOskdDNIuA62V9opzil0t8a14f09dyupylcYjUCAiaLMjk
         7G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDHNp0kW8UZ5wVwRVY7Vrr/1bl/yMtFsFyxPULVhd4I=;
        b=eYpUaKrvChCRmGG/bcmsnJU57pfQek9cAmT4pkbnHnqT9srpwGRRVVCsaNSglVlpan
         tMHzMOyv8T81EEXgGStySlyCA4gMFc49nmZUj6V1h4HLB118wMunLQCue/2fU0B+DHSw
         tXlqKJ/7PeBrBOn1JX0BzqeDv/oxGpMSxzEGifRZ7iDBhylNRK1jMmQr0ElzNTs1x6Fv
         wUJcn42AlJFTQ8imhrte5nqYOFnLhzgeJtI8elZOgHU7KjHnUiMeORYIDQfYc2weX4Ye
         LhYPxB9EjdF9onOay70LZLmrnZgxDbzzAblBkP1bZ0azoiyDJ5NJ+nBrsBbfJitzr44B
         24Kg==
X-Gm-Message-State: ANhLgQ07V/VtPj3jA6m3gS/wbK3Gy2AexK9gnBHqBMh2mXoUjg/97+1R
        65Dn+zgxw/+FoBvH4KINjbAtBBBV6/V3Sp0UH8tHlA==
X-Google-Smtp-Source: ADFU+vunNCxQSZEaoMl1wWz/zElJ7FMTKAkFt/FhteIaiycncpEItDFDrvaw1TyPvKFRON8mBab1sfe67lriT6kHLIg=
X-Received: by 2002:a67:646:: with SMTP id 67mr12004425vsg.34.1583831144529;
 Tue, 10 Mar 2020 02:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200212024220.GA32111@seokyung-mobl1> <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com> <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Mar 2020 10:05:07 +0100
Message-ID: <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     "Seo, Kyungmin" <kyungmin.seo@intel.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Mar 2020 at 05:28, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
>
> I read the link and patch of Chaotian Jing.
> I also point out what Chaotian said.
> Most host controllers have DLL tuning values for each mode. When host controller is set as HS400 mode with 50MHz clock, host controller uses DLL value which is tuned with 200MHz clock.
>
> If DLL value in HS400 mode doesn't have the pass range in HS mode, command transfer failing may fail.
> In order to make robust sdhci driver, I think the patch needs to be considered.

I have, but I am not picking it up in its current form.

> Of course, CMD6 with HS400 mode and 200MHz clock should not cause any problem because it's correct configuration.

Yes, but not for all cases, as I said in my reply in those email-threads.

What I had in mind, is that I I think we should inform
mmc_hs400_to_hs200() about under what situation it's getting called.
Depending on that, we should either decrease the clock rate before or
after we send the CMD6.

Would that work for your case?

Kind regards
Uffe

>
> Thanks
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Friday, March 6, 2020 12:18 AM
> To: Seo, Kyungmin <kyungmin.seo@intel.com>; Hunter, Adrian <adrian.hunter@intel.com>; Chaotian Jing <chaotian.jing@mediatek.com>
> Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
>
> + Adrian, Chaotian
>
> On Thu, 5 Mar 2020 at 09:57, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
> >
> > The mmc_hs400_to_hs200 function is called only in HS400 mode.
> > I saw the clock change from 200MHz to 52MHz via oscilloscope on real platform.
> >
> > I think CMD6 is sent in HS400 mode with 200MHz clock, but it's not.
> > First CMD6 in mmc_hs400_to_hs200 function is sent with 52MHz clock.
>
> I had a vague memory that we have discussed a similar problem as your are pointing out on the mailing list already. And I was right.
>
> Please read up on the below references, [1], [2] for the earlier discussions. I suggested a solution for Chaotian to try, but it seems like he never managed to give it a go, as I don't recall new patch being posted.
>
> Perhaps you can pick up were Chaotian left and see if you can implement the suggested solution(s). My main concern is breaking other host drivers, as that seems quite likely to happen, if we aren't careful about this.
>
> Kind regards
> Uffe
>
> [1]
> https://lore.kernel.org/linux-mmc/1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com/
> [2]
> https://lore.kernel.org/linux-mmc/CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com/
>
>
>
> >
> > Thanks
> > KM
> >
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, March 4, 2020 8:09 PM
> > To: Seo, Kyungmin <kyungmin.seo@intel.com>
> > Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in
> > mmc
> >
> > On Wed, 12 Feb 2020 at 03:40, Kyungmin Seo <kyungmin.seo@intel.com> wrote:
> > >
> > > The clock has to be changed after sending CMD6 for HS mode selection
> > > in
> > > mmc_hs400_to_hs200() function.
> > >
> > > The JEDEC 5.0 and 5.1 said that "High-speed" mode selection has to
> > > enable the the high speed mode timing in the Device, before chaning
> > > the clock frequency to a frequency between 26MHz and 52MHz.
> >
> > I think that is based upon the assumption that you are using a lower frequency to start with.
> >
> > For example, assume that you are running with 400KHz during card initialization, then you want to send the CMD6 to switch to HS mode and that should be done, before updating the clock rate.
> >
> > mmc_hs400_to_hs200() goes the opposite direction, so I think the current code looks correct to me.
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: Kyungmin Seo <kyungmin.seo@intel.com>
> > > ---
> > >  drivers/mmc/core/mmc.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > > 3486bc7fbb64..98640b51c73e 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1196,10 +1196,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >         int err;
> > >         u8 val;
> > >
> > > -       /* Reduce frequency to HS */
> > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > -       mmc_set_clock(host, max_dtr);
> > > -
> > >         /* Switch HS400 to HS DDR */
> > >         val = EXT_CSD_TIMING_HS;
> > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > > EXT_CSD_HS_TIMING, @@ -1210,6 +1206,10 @@ int
> > > mmc_hs400_to_hs200(struct mmc_card *card)
> > >
> > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > >
> > > +       /* Reduce frequency to HS */
> > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > +       mmc_set_clock(host, max_dtr);
> > > +
> > >         err = mmc_switch_status(card);
> > >         if (err)
> > >                 goto out_err;
> > > --
> > > 2.17.1
> > >
