Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39580C388F7
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B0F21527
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 00:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/y2SWWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgKEAj0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgKEAjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Nov 2020 19:39:22 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3DC0613CF
        for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2020 16:39:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so110600ejb.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2020 16:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/71ABBKcrmuk1YYEeoWw8BppObhxvcb+S+aM7wq/fSU=;
        b=c/y2SWWhKYhSpwtv78mNH7n9jPMelncrQF0Hh/x8KoJM3fTZ5oALzNi312/6weAp0I
         O4vwhGwcnmBQBtJps6OHUHsn+DysFEyhvN5WaQJXA2+xWVwb9fokuhNNzwidv1jLQKNW
         rWtGdl5+74SEJLp7e0gsEJl8GyR0ThN4IUxD1D+jSUpwlhF8wOMIZ3g5hB7DrS7R4AnF
         6m5SvcCJloOWgHuDPXotcidoxAvA9IjnP8hrnatHk47SvgXnYEmrZqd5YIodh3buwOxB
         y+pclkog9PWo/yLJDiBVXNUmQqKI1CtAZ5/A6UEVQ2XuOEy1kJMv2s0tO0tuTKyvzr/8
         q+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/71ABBKcrmuk1YYEeoWw8BppObhxvcb+S+aM7wq/fSU=;
        b=R3okEyYFA5c4oGmuzLXHP4/ha0k7PYcKxagl+Iic1SVOkFtf763cHwuriyLsre9V9H
         ipQJwEFj4r75JmWfxHBlaQA3gVumYEQask4BccjpV7vZZbd6uklSXd3Wt+9EexANpxAJ
         e3lbA/Qvzjvu3HdFddeeNnZvhTpaVdJKFRQnQ2ZGodYRf30zLCdcUu0HdPDKJj3mDGB8
         6Qbm8Y07wgwMth8gYs0ApSRGmXeNLA06NrBzi6N2GSiR1rJm4W9klTISijnmuaswbDlu
         SjQRljS1yw0nJAHDz5ZL5vbSfIJBC9o40RQM6O1HQw6Pj1OSNRyBEuwM9fDfrgJVMF+E
         vc8g==
X-Gm-Message-State: AOAM531oyPXl1CzjmX5FVMbvA9+yutkFl/NcZcgf09Lusur3GlOmJfXp
        Cn6Y2BjIaW8YceQMJahk2KtYd/vpzUBRLR86yDI=
X-Google-Smtp-Source: ABdhPJzfPbpIYbLPWBMieCv7JNMFd9IjwR7oyst2heYkJBDFs00UU26HtUP/RTz8PRGfd/ojLJXK/7H9H9sSC7TGy1I=
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr653766ejb.311.1604536759559;
 Wed, 04 Nov 2020 16:39:19 -0800 (PST)
MIME-Version: 1.0
References: <fa7f3fc5-c37a-ac49-e14a-45a1d2e0a942@gmail.com>
 <CAPDyKFq9vKOODDQEEE2W+Gsx69_R3XV_Hb-owMU-=qAMbv39kg@mail.gmail.com> <2ebdcb5c-1c52-08af-9233-16366c20820e@intel.com>
In-Reply-To: <2ebdcb5c-1c52-08af-9233-16366c20820e@intel.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 4 Nov 2020 19:39:08 -0500
Message-ID: <CAMdYzYoFCfVkz7zwbfQ=ZoirNTymRrRyg8FCabVVEQSKRnoOEA@mail.gmail.com>
Subject: Re: [BUG] cqe unable to handle buggy cards
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        nuumiofi@gmail.com, Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Nov 2, 2020 at 11:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 2/11/20 4:54 pm, Ulf Hansson wrote:
> > + cqhci maintainers
> >
> > On Sat, 31 Oct 2020 at 13:54, Peter Geis <pgwipeout@gmail.com> wrote:
> >>
> >> Good Morning,
> >>
> >> We are seeing an issue on the rk3399 with certain Foresee emmc modules
> >> where the module reports it supports command queuing but fails in actual
> >> implementation.
> >>
> >> Unfortunately there doesn't seem to be any method for the mmc core code
> >> to detect this situation and disable command queue automatically.
> >> There also appears to be no way to disable it at runtime.
>
> Since v5.5, if you know how to use SDHCI debug quirks there is
> SDHCI_QUIRK_BROKEN_CQE
> e.g. kernel command line option sdhci.debug_quirks=0x0x2020000

Thank you, we will test this.

>
> >>
> >> Certain modified kernels have added a patch to enable runtime disable of
> >> command queue entirely, but this will affect mmc core as a whole and not
> >> just the buggy card.
> >>
> >> Does anyone have any insight into this issue?
> >> Thank you for your time.
> >
> > Unfortunate, not me personally. I assume the issue is either be card
> > specific or host specific. Before looking at a disable option, we need
> > to know more about what goes wrong, I think.
> >
> > Kind regards
> > Uffe
> >
> >>
> >> Very Respectfully,
> >> Peter Geis
> >>
> >> [   64.472882] mmc2: cqhci: timeout for tag 2
> >> [   64.473349] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
> >> [   64.474057] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
> >> [   64.474763] mmc2: cqhci: Config:    0x00000000 | Control:  0x00000000
> >> [   64.475468] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
> >> [   64.476172] mmc2: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
> >> [   64.476875] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
>
> TDL base cannot be zero, so the register values have been lost.
> Could be a reset issue like this one but for sdhci-of-arasan.c :
>
> https://lore.kernel.org/linux-mmc/20200819121848.16967-1-adrian.hunter@intel.com/

Excellent, we will see if a similar implementation makes a difference
here for us as well.

>
>
> >> [   64.477578] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
> >> [   64.478281] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> >> [   64.478984] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> >> [   64.479687] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> >> [   64.489785] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> >> [   64.499774] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> >> [   64.509687] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> >> [   64.519597] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> >> [   64.529521] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> >> [   64.539440] mmc2: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
> >> [   64.549352] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
> >> [   64.559277] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> >> [   64.569214] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> >> [   64.579061] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> >> [   64.588842] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> >> [   64.598671] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >> [   64.608446] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
> >> [   64.618161] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
> >> [   64.627801] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x642017d7
> >> [   64.637376] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
> >> [   64.646855] mmc2: sdhci: Host ctl2: 0x00000083
> >> [   64.656080] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
> >> [   64.665445] mmc2: sdhci: ============================================
> >> [   64.674998] mmc2: running CQE recovery
> >>
> >> [  125.912941] mmc2: cqhci: timeout for tag 3
> >> [  125.921978] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
> >> [  125.931200] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
> >> [  125.940389] mmc2: cqhci: Config:    0x00000001 | Control:  0x00000000
> >> [  125.949499] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> >> [  125.958527] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> >> [  125.967486] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> >> [  125.976260] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
> >> [  125.985065] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> >> [  125.993698] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> >> [  126.002244] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> >> [  126.010716] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> >> [  126.019159] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> >> [  126.027525] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> >> [  126.035955] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> >> [  126.044258] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> >> [  126.052396] mmc2: sdhci: Argument:  0x00000001 | Trn mode: 0x00000010
> >> [  126.060370] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
> >> [  126.068241] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> >> [  126.075978] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> >> [  126.083552] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> >> [  126.090937] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> >> [  126.098219] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >> [  126.105403] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
> >> [  126.112649] mmc2: sdhci: Cmd:       0x00003013 | Max curr: 0x00000000
> >> [  126.119700] mmc2: sdhci: Resp[0]:   0x00400800 | Resp[1]:  0x642017d7
> >> [  126.126594] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
> >> [  126.133334] mmc2: sdhci: Host ctl2: 0x00000083
> >> [  126.139652] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
> >> [  126.146008] mmc2: sdhci: ============================================
> >> [  126.152361] mmc2: running CQE recovery
> >>
> >>
>
