Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF656C3F2D7
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B6208CD
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LydZnWZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCEPSg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:18:36 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43455 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEPSf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 10:18:35 -0500
Received: by mail-vs1-f65.google.com with SMTP id 7so3790419vsr.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phO1fjFkXHP5aJjwLHsIxyYf9QWL4a+ZWZL5UkWICQE=;
        b=LydZnWZIWOS4wpTtuLtiaYTY/40HZEDPw/0VNCexamYkwKWR5oZWCAAClj/qdG7USz
         PHIXMsf2PAjSDYO+Msw7jMTytfHZVJhbOV0awiORGVrrBFMlDru1xy6umOiB4UN6lAvJ
         extns31knyFdUjRiXZQ9LOCDK1BJKtneAcCXwOnDbaVgtayOBeOod4uuEcknP9PTsMx4
         6ct7acLNOVCVZSL2mGoen6qeqE+TS48cr7/IQQqwKK7YbfuGqqG5PHJc/VgzpESHk7DF
         Vmx2TB09ECyaG4+DFTToAITpKV19qFGGY2m4DUUvTA33jvhBitnbm4/rBbSvmwpPE6P0
         AHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phO1fjFkXHP5aJjwLHsIxyYf9QWL4a+ZWZL5UkWICQE=;
        b=WiZij3gSCfFebZ5iX4urEgXHLx9ZTNFxySBLgGA/Pr4aCSjf8LqeDnd1Ln0JQCo3pg
         BysLe8Dz5dQxsCRTTC42h2tr6LMJQ4xVlNqGQEz5aeHkMomhKGMXe/GeOaMAvzzLwsZD
         n87AMr+i7uU8Fph9KCOr2/WCQadzc7tFpR3/EKVy0IawnY5XbiSVuxaQdaWWt0hn06dc
         c+bwTG9l6aQwWMOWM+Hi83tU1OVjQ4rCKDu6aPgwzktHZbVc8v9NjCZz29JjpE9qkA0l
         taw6444DKRfgd26vWM8iRhB5EwJpj+C1z6EIS5tTcZ7paO9+rHDODeFV/GBLR7vMP+KE
         R7nA==
X-Gm-Message-State: ANhLgQ0HndgHYbygtkRW2lO/lkQ+AbYekjYdQPHfJ9VF1D/czZQan/zi
        YOafzMM6GvGiAr2xGZvIatSWYRVuoU1BJAvU5HoKkQ==
X-Google-Smtp-Source: ADFU+vvp1nUMnGB1rMTb5fKqa4fTspuLvjSjBhaseJ0iawjaPufKTvj5uW5Ajlu8u7x64uJVnuSdHUa+JVCrdDe1c9Y=
X-Received: by 2002:a67:f4cf:: with SMTP id s15mr5356964vsn.165.1583421513606;
 Thu, 05 Mar 2020 07:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20200212024220.GA32111@seokyung-mobl1> <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Mar 2020 16:17:57 +0100
Message-ID: <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     "Seo, Kyungmin" <kyungmin.seo@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian, Chaotian

On Thu, 5 Mar 2020 at 09:57, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
>
> The mmc_hs400_to_hs200 function is called only in HS400 mode.
> I saw the clock change from 200MHz to 52MHz via oscilloscope on real platform.
>
> I think CMD6 is sent in HS400 mode with 200MHz clock, but it's not.
> First CMD6 in mmc_hs400_to_hs200 function is sent with 52MHz clock.

I had a vague memory that we have discussed a similar problem as your
are pointing out on the mailing list already. And I was right.

Please read up on the below references, [1], [2] for the earlier
discussions. I suggested a solution for Chaotian to try, but it seems
like he never managed to give it a go, as I don't recall new patch
being posted.

Perhaps you can pick up were Chaotian left and see if you can
implement the suggested solution(s). My main concern is breaking other
host drivers, as that seems quite likely to happen, if we aren't
careful about this.

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-mmc/1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com/
[2]
https://lore.kernel.org/linux-mmc/CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com/



>
> Thanks
> KM
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, March 4, 2020 8:09 PM
> To: Seo, Kyungmin <kyungmin.seo@intel.com>
> Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
>
> On Wed, 12 Feb 2020 at 03:40, Kyungmin Seo <kyungmin.seo@intel.com> wrote:
> >
> > The clock has to be changed after sending CMD6 for HS mode selection
> > in
> > mmc_hs400_to_hs200() function.
> >
> > The JEDEC 5.0 and 5.1 said that "High-speed" mode selection has to
> > enable the the high speed mode timing in the Device, before chaning
> > the clock frequency to a frequency between 26MHz and 52MHz.
>
> I think that is based upon the assumption that you are using a lower frequency to start with.
>
> For example, assume that you are running with 400KHz during card initialization, then you want to send the CMD6 to switch to HS mode and that should be done, before updating the clock rate.
>
> mmc_hs400_to_hs200() goes the opposite direction, so I think the current code looks correct to me.
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Kyungmin Seo <kyungmin.seo@intel.com>
> > ---
> >  drivers/mmc/core/mmc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > 3486bc7fbb64..98640b51c73e 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1196,10 +1196,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >         int err;
> >         u8 val;
> >
> > -       /* Reduce frequency to HS */
> > -       max_dtr = card->ext_csd.hs_max_dtr;
> > -       mmc_set_clock(host, max_dtr);
> > -
> >         /* Switch HS400 to HS DDR */
> >         val = EXT_CSD_TIMING_HS;
> >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > EXT_CSD_HS_TIMING, @@ -1210,6 +1206,10 @@ int
> > mmc_hs400_to_hs200(struct mmc_card *card)
> >
> >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >
> > +       /* Reduce frequency to HS */
> > +       max_dtr = card->ext_csd.hs_max_dtr;
> > +       mmc_set_clock(host, max_dtr);
> > +
> >         err = mmc_switch_status(card);
> >         if (err)
> >                 goto out_err;
> > --
> > 2.17.1
> >
