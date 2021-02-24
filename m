Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED60EC433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Feb 2021 11:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BA164E83
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Feb 2021 11:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhBXLNH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhBXLLC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 06:11:02 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148FC06174A
        for <linux-mmc@vger.kernel.org>; Wed, 24 Feb 2021 03:10:21 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id f145so300945vka.8
        for <linux-mmc@vger.kernel.org>; Wed, 24 Feb 2021 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txkNSeLKdJc4A/HFV0EIcYQzv1SDtoALla8sa3Zs300=;
        b=hmAYQEeBuHTWj+pSNmxGALWZhzOB3HZupxTcOQpX4Th09YPh+Igvh9xuDY26+PfsqC
         zoQ2VGQ6ZDYOEdxwj+DqDv9NXwbq5zUHZf0Dm7SvqEF9jbUAutihmgnjexF/8tSZldIq
         4dXyUD3X3gj3i/Y5pcIl6G3bCClzlVPDBX2oibkqvconVlhMeJkS0zR4abCSl8YvvSaR
         lYFnCL8TwUjFdtI0/XFdFakg6Op3n6e8p8fp9Zd9ZBeq2GjWKQ71iIxwpMbQNhnVPHWa
         L8i2hqiznEx6uoiSoNKcYcw1pQ4EmjU5Bz7gh/HeEdvZtw0x96SWIQ4fhNscIFqur8im
         XKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txkNSeLKdJc4A/HFV0EIcYQzv1SDtoALla8sa3Zs300=;
        b=K1QFLzxU/VMOqosl0dgmUoUgM+tvZwORNBxSvEdw46AFvvSvh/a15LReblSmjuP7Ew
         OZ/1/SYvv77plHsO7TjfFlDytGZHjjWTeTaaTNyLxJeBNtSi5psMALh/Mo3TJC8s5Hpu
         a+BQCoKB+lm/b3H7PjtY3b7FZ3p5qIXRbQTRSBTN1/NUIvRYnWwd561g7cUF8oQBZiTJ
         IRT5ngfWNKAGTpAmqt7soDAsQJTjYYpQbb0tHkQAbzFbsi3/YfnQQwy0GJFn1fUBZK51
         00xADopwX/3IqJGd/3HVhu6IImQg6kaELQvesJkfIUsw/T9ZJ0peHPkL4FOjxE6C4fk4
         5M6Q==
X-Gm-Message-State: AOAM530wNm1CBkZ1u7j/7KtYsvSpNLClJtMhuPIMrk4XAdkXrivltGVk
        2j+9htGUoWAutCjInSCAdJNxyp6wwgXeSrvz/FvNBQ==
X-Google-Smtp-Source: ABdhPJwy+O1BLefPHmQluv603pH+Dce8Q+ALO/XD+B02smBHOMb582R82R+DjMLXBixxdDAnwR82pRvUXTmo+K08QxA=
X-Received: by 2002:a1f:b408:: with SMTP id d8mr3930360vkf.8.1614165021057;
 Wed, 24 Feb 2021 03:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org> <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp> <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp> <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
 <20210223111926.GC2059@home.paul.comp> <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
 <c9adeaa3-8833-fe2b-cea8-50b645db0a9d@intel.com>
In-Reply-To: <c9adeaa3-8833-fe2b-cea8-50b645db0a9d@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Feb 2021 12:09:44 +0100
Message-ID: <CAPDyKFrWOs7xO1f+miz4cQznHcYQL+sunpzOW3Jg6P0rFOSS1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Paul Fertser <fercerpav@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Feb 2021 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23/02/21 1:54 pm, Ulf Hansson wrote:
> > On Tue, 23 Feb 2021 at 12:19, Paul Fertser <fercerpav@gmail.com> wrote:
> >>
> >> Hello Adrian,
> >>
> >> On Tue, Feb 23, 2021 at 01:01:09PM +0200, Adrian Hunter wrote:
> >>> On 23/02/21 11:32 am, Paul Fertser wrote:
> >>>> Hello Ulf,
> >>>>
> >>>> On Tue, Feb 23, 2021 at 10:23:28AM +0100, Ulf Hansson wrote:
> >>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>>>>> index f5dedb7f9b27..9adf735391fa 100644
> >>>>>> --- a/drivers/mmc/core/mmc.c
> >>>>>> +++ b/drivers/mmc/core/mmc.c
> >>>>>> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
> >>>>>>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
> >>>>>>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> >>>>>>                 /* Some eMMC set the value too low so set a minimum */
> >>>>>> -               if (card->ext_csd.part_time &&
> >>>>>> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> >>>>>> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> >>>>>>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> >>>>>>
> >>>>>>                 /* Sleep / awake timeout in 100ns units */
> >>>>>>
> >>>>>> I do not see any more warnings on my system.
> >>>>>
> >>>>> That looks like the correct fix to the problem. Do you want to send a
> >>>>> proper patch that I can pick up or do you prefer if help to do it?
> >>>>
> >>>> I've sent this as a diff precisely because 1c447116d017 was so
> >>>> explicit about special-casing zero ext_csd timeout value, so I thought
> >>>> probably Adrian can provide the rationale for that. I'd prefer to wait
> >>>> for his feedback before sending a formal patch. Does this make sense?
> >>>
> >>> Zero means indefinite.  Might be safer to use a higher value than
> >>> MMC_MIN_PART_SWITCH_TIME for that case.  The maximum GENERIC_CMD6_TIME is
> >>> 2550 ms.
> >>
> >> Thanks for the clarification! I would guess that most likely than not
> >> when whoever defines that value to be zero it means "I do not
> >> care/know" rather than "the timeout must be set to more than 2550 ms,
> >> too bad 8 bits are not enough to represent that". I'd say setting it
> >> to DEFAULT_CMD6_TIMEOUT_MS should be safe enough since it worked
> >> before.
> >
> > Hmm.
> >
> > The DEFAULT_CMD6_TIMEOUT_MS is intended to override the
> > ext_csd->generic_cmd6_time, in case it's not defined in the register.
> >
> > Perhaps it's reasonable to think that eMMC vendors specify the
> > GENERIC_CMD6_TIME, but may skip to specify other timeouts, like the
> > PARTITION_SWITCH_TIME. In that case, should we use the specified
> > GENERIC_CMD6_TIME, rather than always default to
> > DEFAULT_CMD6_TIMEOUT_MS?
>
> Sounds reasonable, but perhaps still enforce a minimum, for some of the same
> reasons as commit 1c447116d017 ?
> e.g.
>
>         if (!card->ext_csd.part_time)
>                 card->ext_csd.part_time = card->ext_csd.generic_cmd6_time;
>         if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>                 card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>

Makes perfect sense to me!

Kind regards
Uffe
