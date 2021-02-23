Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A740C4332B
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4D64E5C
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhBWL7U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhBWL4m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2021 06:56:42 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD143C06178A
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 03:55:13 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id l192so8228985vsd.5
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erpoxt/N8VLTwjM6ywjdkvCo/NylfVFJGSI55p5H7cA=;
        b=t2zDtRhs72R/64YsS1S0F+lO8QvY2L6EqKAu4z1l2c2Xvmg6FZMyfPwSfDL60Yn1Sl
         8/LhjMzAaF1wU+T3WbEIgDRoBWQPyNGt7UO19/jB/+sxEO5prJOTb+LXH1b6f+khGf0o
         aYyx52zmDKN3qzhBY3iuxbwyHeb7xdY35Ur+MY+RoEG3Rz3f7bYOo23/LNCMdBzc25Fi
         RwAoivhsL85TCevIg0zAs8QZswS2FSJD8IVZvHtO9+dPiXsHETpLvZfq02fpjcPtWrNS
         eyoQDhITc2yASHIiZXhtMJRl2JtLKpeCtDgcA3krlvA6pU4QA55S8PMTAvdHKhJqGCQ4
         xs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erpoxt/N8VLTwjM6ywjdkvCo/NylfVFJGSI55p5H7cA=;
        b=Y7n79wYbUsv05VLaLPKJga0jcntaHZh3gtGMXMIPS/wprBItjgxezEEPae8lmu0TbB
         l69iJJBhLXkYt3NyGCUjTqe7tpVaSz261dcrMFe/FLlEtfmoQzfu9b6ogG1GipxSflok
         SVr5caVUao92tdxOjw/lqxo7Bka8USBol7g/WbpWG9PH4lNAJbSDYuEM7SVkyd6qhKPZ
         no+su0FpRYlDYO2w9hyuIIm4QykmodSizKj0QalUbn+IeIDp4CDYIjbRpOLF8XKCXHH0
         1NqsTs36n+6dzXBGIHJgQaYXLktIts6zSwu4S9+c1FSXGGvIf+5dahldKE884EvpKAlQ
         II1g==
X-Gm-Message-State: AOAM533J+1dS1ZhcHY9F1XZb7nyRrWRqu7UgupNaBE3r+r3JPLlmHgi0
        shCAB7/LaWEod59laJ9YWCodKbgI1XeSzt2ocMb7UQ==
X-Google-Smtp-Source: ABdhPJwdgcBcBIshSS3Fk/swpgHKjrlF+devEc5BY3f4tBfhbPV+kc1mHbjazfkQdr16nrq04gSOWW0mInGGwoT/Ejc=
X-Received: by 2002:a67:8c6:: with SMTP id 189mr15664012vsi.55.1614081313079;
 Tue, 23 Feb 2021 03:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org> <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp> <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp> <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
 <20210223111926.GC2059@home.paul.comp>
In-Reply-To: <20210223111926.GC2059@home.paul.comp>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Feb 2021 12:54:36 +0100
Message-ID: <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Feb 2021 at 12:19, Paul Fertser <fercerpav@gmail.com> wrote:
>
> Hello Adrian,
>
> On Tue, Feb 23, 2021 at 01:01:09PM +0200, Adrian Hunter wrote:
> > On 23/02/21 11:32 am, Paul Fertser wrote:
> > > Hello Ulf,
> > >
> > > On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
> > >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > >>> index f5dedb7f9b27..9adf735391fa 100644
> > >>> --- a/drivers/mmc/core/mmc.c
> > >>> +++ b/drivers/mmc/core/mmc.c
> > >>> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
> > >>>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
> > >>>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> > >>>                 /* Some eMMC set the value too low so set a minimum */
> > >>> -               if (card->ext_csd.part_time &&
> > >>> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> > >>> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> > >>>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> > >>>
> > >>>                 /* Sleep / awake timeout in 100ns units */
> > >>>
> > >>> I do not see any more warnings on my system.
> > >>
> > >> That looks like the correct fix to the problem. Do you want to send a
> > >> proper patch that I can pick up or do you prefer if help to do it?
> > >
> > > I've sent this as a diff precisely because 1c447116d017 was so
> > > explicit about special-casing zero ext_csd timeout value, so I thought
> > > probably Adrian can provide the rationale for that. I'd prefer to wait
> > > for his feedback before sending a formal patch. Does this make sense?
> >
> > Zero means indefinite.  Might be safer to use a higher value than
> > MMC_MIN_PART_SWITCH_TIME for that case.  The maximum GENERIC_CMD6_TIME is
> > 2550 ms.
>
> Thanks for the clarification! I would guess that most likely than not
> when whoever defines that value to be zero it means "I do not
> care/know" rather than "the timeout must be set to more than 2550 ms,
> too bad 8 bits are not enough to represent that". I'd say setting it
> to DEFAULT_CMD6_TIMEOUT_MS should be safe enough since it worked
> before.

Hmm.

The DEFAULT_CMD6_TIMEOUT_MS is intended to override the
ext_csd->generic_cmd6_time, in case it's not defined in the register.

Perhaps it's reasonable to think that eMMC vendors specify the
GENERIC_CMD6_TIME, but may skip to specify other timeouts, like the
PARTITION_SWITCH_TIME. In that case, should we use the specified
GENERIC_CMD6_TIME, rather than always default to
DEFAULT_CMD6_TIMEOUT_MS?

Kind regards
Uffe
