Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BFC2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5F21973
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUjM35XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502492AbgDPIhv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502481AbgDPIfW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 04:35:22 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D5C061A10
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 01:24:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so1853025vsl.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TaBcNBr0LmHmhCu1jIrvYkIUcv+feENwdQ/ZDbQJes=;
        b=YUjM35XZNkCke18ASEVQzu3oQOeQ67Z70V6beRoVND6LL9BBZ+3//1papRDqvwu0ET
         tQ4NufGIlbdwNCmPwdQqkrrAGiSSOTwPtFR2mLdFrRsMdTb/QsflO8TZ31VhqZvny3hN
         2PY6Cv1TAFkYPf9Nq55TNDQPdM4CZR5yFLfriuIVACuwdRMuBTL30ZcSh7fdpzH/kx9O
         RhlOJjOCIABO8hrrWqJxxEjlfDg6y8EUdm2J6ym3mBDh+tfwsoQsvgh9yO0sq1KeYq+5
         uyrbZ/Ek1LmsVDH01d/yEhBpQbbbwwR/FtG9PpLOjjaRQWuShfKBQmS3yqjb/oBDsOgf
         Vjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TaBcNBr0LmHmhCu1jIrvYkIUcv+feENwdQ/ZDbQJes=;
        b=NRIRBcLj6d1zBqQZZUScEIXU/Vp40VitvgMpwwyoa+6B54MoIxBtsLiCVqwdiNCkpN
         MTGL1zI2lA0NS83oE5q4/MoNUwPq93kaaVsleuMKih0TkwI8d6+sl+bj0Cvjfykd5zPn
         qFraAbEq5wdjybso2dnUZJRgyEVfQSYiQ2kr5zNNEg47FdbQWsmfGOgq+sFgLGIbxxnw
         gRO6dOk3Mk3kQDvof0v7EcuQfE/nkbPbcwvgBZVgSpzI40xpNXbFe2fRTa+as5K4PjP0
         iOGN6PsJJbEriWC4jwkZr5k9DH4Mu4+eyrOjcdphRClW+41wYqJ3L7VYQFmQ3HtAGpA8
         qbxg==
X-Gm-Message-State: AGi0PuZngx8z5+Z2Ggop8hly79qFCkTELVAhX9ktyZ1Cun9EdW+L4HwO
        bsoDx4/bs5rEDoeRw88A6lMZaMeCw1KAfstGRERfKA==
X-Google-Smtp-Source: APiQypLB3ByHxPcUtZOdM+rFhnnuQHeltCT3o4Wld28Z33lBkBrgQXNCizCw/78zmL5SElkXmD9y+IsRZr/CeHWIJLY=
X-Received: by 2002:a67:11c4:: with SMTP id 187mr8059654vsr.34.1587025465228;
 Thu, 16 Apr 2020 01:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-14-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrOFOLCWHu8nE4i5t=d+Ei-kcJ15_42Ft3ROSUDe5jkpw@mail.gmail.com> <3e5f8e78-7cd1-30fb-e005-78c1e7111794@codeaurora.org>
In-Reply-To: <3e5f8e78-7cd1-30fb-e005-78c1e7111794@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 10:23:49 +0200
Message-ID: <CAPDyKFrD7sh4gnbX8B2j22h18T=7ZRGCc_RYXd0ePm2fZwDcVA@mail.gmail.com>
Subject: Re: [PATCH 13/21] mmc: sdhci-msm: Use OPP API to set clk/perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Apr 2020 at 18:43, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
>
> On 4/15/2020 7:22 PM, Ulf Hansson wrote:
> > On Wed, 8 Apr 2020 at 15:48, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>
> >> On some qualcomm SoCs we need to vote on a performance state of a power
> >> domain depending on the clock rates. Hence move to using OPP api to set
> >> the clock rate and performance state specified in the OPP table.
> >> On platforms without an OPP table, dev_pm_opp_set_rate() is eqvivalent to
> >> clk_set_rate()
> >>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Pradeep P V K <ppvk@codeaurora.org>
> >> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Cc: Subhash Jadavani <subhashj@codeaurora.org>
> >> Cc: linux-mmc@vger.kernel.org
> >
> > This looks good to me!
> >
> > However, are there any of the other patches in the series that
> > $subject patch depends on - or can I apply this as a standalone mmc
> > patch?
>
> Hey Ulf, thanks for the review. I'll just need to respin these to make
> sure I do not do a dev_pm_opp_of_remove_table() if dev_pm_opp_of_add_table()
> isn;t successful as discussed with Viresh on another thread [1]
>
> As for the dependencies, its only PATCH 01/21 in this series and that's
> already been queued by Viresh [2]

I see, thanks!

Looks like Viresh is sending it to be included for v5.7-rc2, so I can
pick your new version of $subject patch next week.

[...]

Kind regards
Uffe
