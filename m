Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED3C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AA261052
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhHZTCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbhHZTCt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2021 15:02:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6AC061757
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 12:02:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso4828227ota.8
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:jubject:from:user-agent:date
         :message-id:subject:to:cc;
        bh=+iVPuEHGBickynSlN/aspzgM+vCXS1pxLKvIBYzPHaY=;
        b=m1Qh8c1JI8bJtMbx2zXs3H9EO3V3B24CTfDZ0E0MweKP5VXvP8ajaNkOgqAv29OW/F
         xjby+KYB85j/qh0w1BGUe1u8LtcQThDspoEcg6Ho/K9SiquHynat2V84AQwXD9k8D+AX
         lUHCf/zIj2pOkXaqiiOBJBZ//d85EfeL9KDEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:jubject:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+iVPuEHGBickynSlN/aspzgM+vCXS1pxLKvIBYzPHaY=;
        b=Q+CtSmfVyWDDXB9DHZtccz4f8tk5Y/8NPEWK8ayEuRezdJKgW5xR5SMzToaERAjpr0
         a4C3+bIaVRapYpYa6Drp83xJC8seL2VR77WO030hqBgd2IWQSjZcHhYUPx2MDpEM/WYw
         RUHl/+LXpy03+G1LYo4FjTSTqtoD4A1cU0cWirXZLu8L3TrgFerHSgXRERZc0JQgat1D
         pWuoXKuxogmIlvK/UdUzxtJJ+K0BG25rRylpKKfClxaEUntZXmiSsUesqaLr+hqJnI6n
         D00TUkbPfHDHFSaLS28gJR14C9tgYb9jOZwl2nl1H3EtIn8QnBkZwxS+dWBTIMN8iong
         CgRg==
X-Gm-Message-State: AOAM532aUWj6w5X+hvaF6ufstpR3rbrMc5VfMstr25K918mHzfaw53KH
        OVkrbntlvvC0W0p7AiA2Crs68Ywh+tJiNgtIa+49L3mccRk=
X-Google-Smtp-Source: ABdhPJzdZYXAXrUOl9mGtjohncFB+oGrYX4mON9av982YMT3gjRIDsaw7nD/2scpYTZBlBNfwQfReCj7diwhE7RBlNg=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr4600325oto.233.1630004521512;
 Thu, 26 Aug 2021 12:02:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 19:02:00 +0000
MIME-Version: 1.0
In-Reply-To: <YSfioM5cEnvD3pGb@sashalap>
References: <20210824025754.658394-1-sashal@kernel.org> <CAE-0n53zk0ogf=TUknMoCAPDd97=jq3Czpp6b1c9E29ormuCSQ@mail.gmail.com>
 <YSfioM5cEnvD3pGb@sashalap>
jubject: Re: FAILED: Patch "mmc: sdhci-msm: Update the software timeout value
 for sdhc" failed to apply to 5.4-stable tree
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 19:02:00 +0000
Message-ID: <CAE-0n50brNnTASH8xR_jSCr0=OAQohcA4cG3HFAeDmt=4U-4Uw@mail.gmail.com>
Subject: 
To:     Sasha Levin <sashal@kernel.org>
Cc:     sbhanu@codeaurora.org, stable@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Sasha Levin (2021-08-26 11:51:12)
> On Thu, Aug 26, 2021 at 07:51:45AM +0000, Stephen Boyd wrote:
> >From cd5d41c802f7b3e20c0c0ebd6bf0cb335954fd89 Mon Sep 17 00:00:00 2001
> >From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> >Date: Fri, 16 Jul 2021 17:16:14 +0530
> >Subject: [PATCH] mmc: sdhci-msm: Update the software timeout value for sdhc
> >
> >commit 67b13f3e221ed81b46a657e2b499bf8b20162476 upstream.
> >
> >Whenever SDHC run at clock rate 50MHZ or below, the hardware data
> >timeout value will be 21.47secs, which is approx. 22secs and we have
> >a current software timeout value as 10secs. We have to set software
> >timeout value more than the hardware data timeout value to avioid seeing
> >the below register dumps.
> >
> >[  332.953670] mmc2: Timeout waiting for hardware interrupt.
> >[  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> >[  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
> >[  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> >[  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000027
> >[  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl: 0x0000001f
> >[  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> >[  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> >[  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> >[  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
> >[  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >[  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x0000808f
> >[  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr: 0x00000000
> >[  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> >[  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> >[  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
> >[  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> >0x0000000ffffff218
> >[  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
> >-----------
> >[  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> >0x6000642c | DLL cfg2: 0x0020a000
> >[  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> >0x00000000 | DDR cfg: 0x80040873
> >[  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
> >0xf88218a8 Vndr func3: 0x02626040
> >[  333.102371] mmc2: sdhci: ============================================
> >
> >So, set software timeout value more than hardware timeout value.
> >
> >Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> >Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >Cc: stable@vger.kernel.org
> >Link: https://lore.kernel.org/r/1626435974-14462-1-git-send-email-sbhanu@codeaurora.org
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >---
> > drivers/mmc/host/sdhci-msm.c | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >
> >diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >index 8bed81cf03ad..8ab963055238 100644
> >--- a/drivers/mmc/host/sdhci-msm.c
> >+++ b/drivers/mmc/host/sdhci-msm.c
> >@@ -1589,6 +1589,23 @@ static void sdhci_msm_set_clock(struct
> >sdhci_host *host, unsigned int clock)
>
> I've queued this up, thanks!

Thanks!

>
> Note that the patch was linewrapped (see above).

Indeed. Must be something wrong with my mailer setup. I'll look into
fixing it. Thanks.
