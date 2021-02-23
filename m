Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D2C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834CC64E21
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Feb 2021 09:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBWJYs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Feb 2021 04:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBWJYr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2021 04:24:47 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0281C061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 01:24:06 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id a62so8025633vsa.10
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2021 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nC3/SZXY0BFKnlWPr9cqk3PFaHR1HZv7S1zADN2Xf8=;
        b=WmmJXMbM0cORGdhpgj2FrFNvd6PCM42hEzI4FTaINaZWbg8Nh47xEbSTEOT3ga2lln
         VnXY5hfPYw2rCglQxiiUV9eNNuY0SYtEg1OaFYwaoAqKnuH1mZIKi/PkLQiqpuUbJWdd
         tc/5MsHaZ2GlcBr8oSrvoqrSw7G5EhBRMfRLcI6Tf0w84Bn3QeW4zfPixJfpbWu/ZAZr
         UKTUHVsUIVd1NEGdUW6SKTau+rTojulSMV0rrRTegmuI/B+DI+QdCqHDlr/IldiylIR9
         urf+VkBzbvQEgpKG1zbPo2sq7O2PwdrvF+a2jN8z4Nd7q42NEbIiWQsGLO3TwfMIcv4i
         btyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nC3/SZXY0BFKnlWPr9cqk3PFaHR1HZv7S1zADN2Xf8=;
        b=ZAiAg8q/XTThqwCwXRO66PvNBIML3ED4JjO5XKWViIr+/I8lt/PoNFrH6sfdjYK6kT
         2vaAJIx3j47xSA+MvXrkwYhV/fq/Rf9mWJJt8WhyC3PU6XSIHyAOgrEDhjIOnQ9lmyFo
         VqFjW9XX9PQhNYAlosdmPvvQksaQ4LAxtA7WAWalJODYm8FTM6xRM8MeNHs/Gwu6AQul
         kjKU1nF13azfNPZUC51FPnEac902AkJMoK2v/7lXqUCaJp1OYn8MdfXyxzJuTwyy37xW
         00UZo4KlHR7fuoMpurmEBeofJJVK7dyznw+QCYBfWRVhMKNEOvEReJztkfyuPPy9Muqn
         qrpQ==
X-Gm-Message-State: AOAM5319JK438+QexVkG1IgB6ITq/ozb4AFODyTmwjA9hKmUDGgO4NbT
        PH7z8kQr2I+CGmUPzrwvR0jMSQOlwbyI7znAwDPjTNENY89FpdbF
X-Google-Smtp-Source: ABdhPJxipOo6t16uzNiI5OJ+1fjUrjneldDcdjRdPXKOhIDpAXGeD4yuHJuvBBtb+1vh8eGCPdnpJi9p0gGeaO6bDcE=
X-Received: by 2002:a67:f290:: with SMTP id m16mr13081907vsk.34.1614072245731;
 Tue, 23 Feb 2021 01:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org> <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp> <20210222201245.GW2059@home.paul.comp>
In-Reply-To: <20210222201245.GW2059@home.paul.comp>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Feb 2021 10:23:28 +0100
Message-ID: <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
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

On Mon, 22 Feb 2021 at 21:12, Paul Fertser <fercerpav@gmail.com> wrote:
>
> On Mon, Feb 22, 2021 at 07:24:06PM +0300, Paul Fertser wrote:
> > On Wed, Jan 22, 2020 at 03:27:47PM +0100, Ulf Hansson wrote:
> > > All callers of __mmc_switch() should now be specifying a valid timeout for
> > > the CMD6 command.
> >
> > I'm running a kernel based on linux-next on a Tegra2 system (Toshiba
> > ac100 aka paz00, on-board eMMC) and seeing plenty of these warnings on
> > boot. I added WARN_ON_ONCE to see the backtrace and here's what I get:
> ...
> > [    3.338454] [<c063d8a4>] (mmc_switch) from [<c0648f48>] (mmc_blk_mq_issue_rq+0x22c/0x900)
> > [    3.396728] [<c0648f48>] (mmc_blk_mq_issue_rq) from [<c064998c>] (mmc_mq_queue_rq+0x124/0x258)
> > [    3.409215] [<c064998c>] (mmc_mq_queue_rq) from [<c039a9e8>] (__blk_mq_try_issue_directly+0x140/0x1cc)
>
> FWIW, with
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f5dedb7f9b27..9adf735391fa 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
>                 /* Some eMMC set the value too low so set a minimum */
> -               if (card->ext_csd.part_time &&
> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> +               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
>                         card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>
>                 /* Sleep / awake timeout in 100ns units */
>
> I do not see any more warnings on my system.

That looks like the correct fix to the problem. Do you want to send a
proper patch that I can pick up or do you prefer if help to do it?

Seems like we should add the following fixes tag as well.
Fixes: 1c447116d017 ("mmc: mmc: Fix partition switch timeout for some eMMCs")

Kind regards
Uffe
