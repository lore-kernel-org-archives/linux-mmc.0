Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C658C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 10:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4623764DF5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 10:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBWKpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 05:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBWKpf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2021 05:45:35 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867BC061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 02:44:46 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id t23so8146708vsk.2
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 02:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ew/CjbPxDhXvMNQc9zjNYPmranzoReyyh9dt68RhsFM=;
        b=Zjhja1KMeiwWWFY/rnM5Ayb0VSIQhcm7nOPrXSA4ms59aBP9CUnM8jN4gqmG9iU21C
         TS/nEBR/rqHJo4TjldDo5ljyXFPBmRxRva81XRFgB1ShXik4bj9PZJDT3N7nQOOXhM6a
         xQltRO0IKL35Zw+C4Qpdp2SxmeohokDfkm8uy3pZhykXdGKkg8T8z42SKx47qbzIQKKB
         9dYL6UaI5GjWBNcFmyXtAs/8+qz3+6+dSGYJSyqhvz35AvcSZ5DV2OFINZM+otfIODO+
         oKDqyB7cx8cYNGYGd/lLPSzvyz+oIwWCpsEXexNr3988hBoN5jbsygjGQa9VvuFnB7FJ
         qGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ew/CjbPxDhXvMNQc9zjNYPmranzoReyyh9dt68RhsFM=;
        b=lV3BjV8NVRfXakBXRWqECmQtr30i0eq7cX0X0ppDwNhBidCeu+sKfroCA6w+xWg8oa
         JgseUofpJyYgzB5nfT51duBBeoDlnVqWnk1P4g9vNu6yM+ARafznbsLM4NNsc7SpjRne
         +QeE6BxTFW7efWE+DgSMsQJtHV9siRlgeYz4sPcf1qQVnP8HPDfP+l7bGXXSuPc6A2yR
         +zvj5DrHVooHl6JAy1RHixUf5AGSFi93+X4y40JXVQn+g3cSm4yvW8oqHfztGJddaOgM
         VZDfksfVChq2XfQQmq/Yvg7Qnt2uprYoACZ2vrlDHOMrRawpjq5YIh9NrU+jirzZJtw/
         yCDg==
X-Gm-Message-State: AOAM533Kgzb10SXfiwFooQCGFhGtixI0+Y488Gh8O73Xtf+K3JbSmnRT
        PK+mBbeHhqWvPDxjI/x6wdne99eHNP9Pl2s70eY01MxiS/5awGld
X-Google-Smtp-Source: ABdhPJymygqG/qfC6Q8zLh9iwOoMw/SPikG30FXFVnyHUwYlXlyo5j71e9FqmuusWMVHX7L+AwjRELxMRWWNEJOZa64=
X-Received: by 2002:a67:3091:: with SMTP id w139mr15911727vsw.42.1614077085290;
 Tue, 23 Feb 2021 02:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org> <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp> <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com> <20210223093247.GA2059@home.paul.comp>
In-Reply-To: <20210223093247.GA2059@home.paul.comp>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Feb 2021 11:44:09 +0100
Message-ID: <CAPDyKFqawp2iAOsimAS1if0=OPeoXbYJS5o_KnAis9cnsGG7+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Feb 2021 at 10:32, Paul Fertser <fercerpav@gmail.com> wrote:
>
> Hello Ulf,
>
> On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index f5dedb7f9b27..9adf735391fa 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
> > >                 /* EXT_CSD value is in units of 10ms, but we store in ms */
> > >                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> > >                 /* Some eMMC set the value too low so set a minimum */
> > > -               if (card->ext_csd.part_time &&
> > > -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> > > +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> > >                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> > >
> > >                 /* Sleep / awake timeout in 100ns units */
> > >
> > > I do not see any more warnings on my system.
> >
> > That looks like the correct fix to the problem. Do you want to send a
> > proper patch that I can pick up or do you prefer if help to do it?
>
> I've sent this as a diff precisely because 1c447116d017 was so
> explicit about special-casing zero ext_csd timeout value, so I thought
> probably Adrian can provide the rationale for that. I'd prefer to wait
> for his feedback before sending a formal patch. Does this make sense?

I think the rationale was not to set a default timeout if the value
from the register is zero (because there is a fallback in
__mmc_switch() for this case). The problem with the fallback is that
it's one timeout value for all types of commands. It's better to
specify a default value, based upon what command it's for - along the
line of what your diff suggests.

Kind regards
Uffe
