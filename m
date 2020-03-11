Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F37C10F27
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA9021655
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 08:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGiA0ZAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCKI6g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:58:36 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:42194 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgCKI6g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 04:58:36 -0400
Received: by mail-ua1-f53.google.com with SMTP id p2so428410uao.9
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLNxk8O6Gh8TsCWdxPFKykWAzp8mOJGuS0q7kCK4jy0=;
        b=fGiA0ZAktSjoWl9DDT85ZeYkJ/uEVjJpeb9D+ohfkIR+yM76gHK2IpxSSIwpuF2uM2
         f2KVUbuOiRqkDOo+27dpkmhtlKA8GVE7nLmTUaOrTtsS3Vg5TtujomGQ2OB+nDzSn0Eu
         jP7Gn/B2Nf+N4OyS4QKWwxRYqyWMgNgMff8ZQ181MSjcvYeNjOxr0Lm9MWarNKssfHFj
         aiGjMskNZhn5mY6RZodwxcRSfIaO8vcIeGJXTUccmJWaJAw1VHj5sJ/YiEG+CcqCqZo6
         1r54TV302rzRYwz8muKtxckcsEPENmI/kg+QWD5YvScsB1RsdsEY78Ha3Gkw8jf0kf+5
         NybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLNxk8O6Gh8TsCWdxPFKykWAzp8mOJGuS0q7kCK4jy0=;
        b=m9tZTe3Y5pcj5v+sUtTmpjfygJEQxpoxjS6aXeKKtc/Aep9PzK802gkPRC+Db4Z+qd
         O7hjO0qyu4mtk6XgxW0MtRBKJpWZWYAlEhWrO9iRJ+jJ61Hk7saRviDbA6H45UWx2/Xm
         qBhhEXZ4Y1ipf6FcsAAEJKBtUi2zArAK5PmzR3o5knci+NrwW6Jg/QaFVCyp+OJKPTqM
         3/61szJeE1XhEnajHx1t5kJ8ZUUJvZjuvsKFfxfwn4HRd06shsLq+sqd2mU0yPG8sp4M
         SUIcOYgTXnbyOFlsEgQta5r83hoxPSTHJol2Uw4VVgHuFFek+wncn7slUAo3jwTDs2Vq
         jiRQ==
X-Gm-Message-State: ANhLgQ1FgOYGRAq6meVAcTJIF7SK3vIx88YjTIG5X4Q+GYDOFiSnDA/g
        3zxpX6Zo3GdeUoHb4GBbiW9CEPB+iqWa6HOs5g2ioQ==
X-Google-Smtp-Source: ADFU+vvAY1hloT57HCPzA8/FbRSet7fJZ0ZjIpEDUNDE3WhJyVBOXTHiqYoQ7JQeBWuQaOvXqocGgd1G1twm2cIJlf8=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr1058363uaq.100.1583917104040;
 Wed, 11 Mar 2020 01:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200212024220.GA32111@seokyung-mobl1> <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
 <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
 <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com> <CAPDyKFosrju6y5mOKePsNwqgDr=QeBozFTrWKz4MNpsMmeZdCA@mail.gmail.com>
 <1583892806.24941.7.camel@mhfsdcap03>
In-Reply-To: <1583892806.24941.7.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 09:57:47 +0100
Message-ID: <CAPDyKFrdiiVUrCKR2N=Xbtfy3NhXSaq4m_ziXScdJU3x8G2F+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Seo, Kyungmin" <kyungmin.seo@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 11 Mar 2020 at 03:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Tue, 2020-03-10 at 16:41 +0100, Ulf Hansson wrote:
> > On Tue, 10 Mar 2020 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > On 10/03/20 11:05 am, Ulf Hansson wrote:
> > > > On Tue, 10 Mar 2020 at 05:28, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
> > > >>
> > > >> I read the link and patch of Chaotian Jing.
> > > >> I also point out what Chaotian said.
> > > >> Most host controllers have DLL tuning values for each mode. When host controller is set as HS400 mode with 50MHz clock, host controller uses DLL value which is tuned with 200MHz clock.
> > > >>
> > > >> If DLL value in HS400 mode doesn't have the pass range in HS mode, command transfer failing may fail.
> > > >> In order to make robust sdhci driver, I think the patch needs to be considered.
> > > >
> > > > I have, but I am not picking it up in its current form.
> > > >
> > > >> Of course, CMD6 with HS400 mode and 200MHz clock should not cause any problem because it's correct configuration.
> > > >
> > > > Yes, but not for all cases, as I said in my reply in those email-threads.
> > > >
> > > > What I had in mind, is that I I think we should inform
> > > > mmc_hs400_to_hs200() about under what situation it's getting called.
> > > > Depending on that, we should either decrease the clock rate before or
> > > > after we send the CMD6.
> > > >
> > > > Would that work for your case?
> > >
> > > Ulf, would you consider a new call back e.g.
> >
> > That could work, but I am not sure what's best, honestly.
> >
> > The problem may be generic or it could be specific to some host
> > controller? I think we need to answer that question first.
> >
> > What do you think?
> >
> > Br
> > Uffe
> >
> When start to send CMD6 to switch to HS mode, both Host & eMMC device
> are working on HS400 mode, so the timing used is MUST at HS400 mode and
> the clock MUST keep at current clock(usually 200Mhz). after received the
> response of CMD6, Never use CMD13 to polling card status for timing
> switch. if host has ops->card_busy() or caps WAIT_WHILE_BUSY, then use
> it, if not,just do mmc_delay() for specific time.

The CMD13 is currently not used when polling, because we set the
send_status parameter to false in the calls to __mmc_switch(). So this
should already be covered, according to your suggestions. Right?

When it comes to keeping the clock rate as is, before sending the CMD6
- I fully agree that it's a good idea when doing a periodic retuning.
As you would expect things to work as they are.

The problem is, when you have received a CRC error and the re-tuning
is being triggered because of that. In that case it may be a better
option to decrease the clock rate, at least that is what I recall
Adrian needs for his cases. Adrian?

What will happen when you receive a CRC error and there is re-tuning
triggered, is that something you have seen happening on you boards?

>
> the next step is that call mmc_set_ios() to set current timing to HS
> mode and clock to 50Mhz to let Host driver that eMMC device has been
> switched to HS mode and Host can switch to HS mode at 50Mhz(may apply
> parameters for this low speed).

Yep, makes sense.

> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index c2abd417a84a..1bc18fe2632f 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1237,7 +1237,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >
> > >         /* Reduce frequency to HS */
> > >         max_dtr = card->ext_csd.hs_max_dtr;
> > > -       mmc_set_clock(host, max_dtr);
> > > +       if (host->ops->hs400_to_hs200_prep)
> > > +               host->ops->hs400_to_hs200_prep(host, max_dtr);
> > > +       else
> > > +               mmc_set_clock(host, max_dtr);
> > >
> > >         /* Switch HS400 to HS DDR */
> > >         val = EXT_CSD_TIMING_HS;
> > >
> > >
> >
> > [...]
> >
> > Kind regards
> > Uffe
>

Kind regards
Uffe
