Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A94C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A500060F9C
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 09:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1JyM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Oct 2021 05:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhJ1JyL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2021 05:54:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB1C061767
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 02:51:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id i26so7771889ljg.7
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCpmUIi4CdbkIKY1b/j8ncQVr9EMyQgSlpp/uwcjT8I=;
        b=jUDMWyajK0l2lhY4KRjDzD3/OTMk+bkhq3AnRUjLSCXhsitnZHNtNagE85/1smHyJ1
         EBU5SlSD1fhxXVkks2c21QXXeYbjcEsp5G/c0ZJdr4YFC14ua1yF4pfLQz+rRMYipwyM
         usWTyEXNOymtogNGR5Oot/6TGJ8ndkZtxC1cIKCnWtrHNzPZDLqBDbs/hbeoX2vYc3Ww
         5lgIayuiYkYjP1N0UtAnbVfK1jFiq6NgJTKMd5byY2RaIqaGUjyc39XlROSsRRp+SsLB
         3QsvBor/LEIt+BOdimnZcXP2mVVcsoBmiFmZ72DRmcbUktNgWuvxvaPh3oz0l1Wm+yqA
         cjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCpmUIi4CdbkIKY1b/j8ncQVr9EMyQgSlpp/uwcjT8I=;
        b=uNNqhBEAK2tg2G9B3VhSMGrpa0YSuVrdGo/6iSmX/FHLgnUq6D1EWWfrrlbUyvONcu
         Qnjntr1UK7ffeqlBxvZtMQ8tAQhsI3oYnWsCgxNe17wm3TQDYiCsaoNov688G1m/G66s
         vRn7cl2dI+DRb3a2Wj2t1cUzeEfxcMB2ROEMBGks9szDt3ZaZxXLRgbgAh2Uf+xAYNMl
         BRejCifHqt7dNY2iOQjQxtz8LIaavsjszbtEUXbeTc/5IBvhQ0pueAE33F4bAhGXO+4h
         3zRdnONKp7TQ98c+ZjgRwPuhSwkteu31d28eDSFqCtrAB+vpfJPo2FUSIR7RhhNALQYq
         GdXw==
X-Gm-Message-State: AOAM530s/n1H6eXdcOLmsnXKRrLOz6x1yROummQmcTjG6bFdKPvQPouq
        ZKBR/5w8rktpLw0ZtZ4THHwTNiLFzyNDgyLg0UPamA==
X-Google-Smtp-Source: ABdhPJzxsTQcVifTPlqxGObEpVIwRC4S2wZKtsuhIX12A13sgEwHMtX3PW6IDKgOaVu1YD8T3f+H+azigKVR3HZZ6S0=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr3728516ljq.300.1635414702972;
 Thu, 28 Oct 2021 02:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <8ecc5c79c1dd0627d570ede31e18c860786cacca.1633519499.git.hns@goldelico.com>
 <CAPDyKFp47sAXhM2s5HOqV2wLf-kYRhdqSdzcn7a62ZW23SSPdg@mail.gmail.com>
 <470A96FD-DB24-4C32-BC9F-AE2F617FBF2D@goldelico.com> <2013308.OSlt1BDEiP@pc-42>
 <1EF25CD6-7801-4C15-AB4C-5F499948A653@goldelico.com> <920CFF1F-475C-4403-B563-DDD144F7E52D@goldelico.com>
In-Reply-To: <920CFF1F-475C-4403-B563-DDD144F7E52D@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Oct 2021 11:51:06 +0200
Message-ID: <CAPDyKFp9EEHX1nooBUd7oXCfyaRwFhcikLdxrfcmnoG=2tjEww@mail.gmail.com>
Subject: Re: [RFC] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> >>>
> >>> Combining your suggestions we could do roughly:
> >>>
> >>> in mmc_sdio_init_card():
> >>>
> >>>       if (host->ops->init_card)
> >>>               host->ops->init_card(host, card);
> >>>       else
> >>>               mmc_fixup_device(host, sdio_prepare_fixups_methods);
> >>
> >> I think I mostly agree, but why you don't call mmc_fixup_device() if
> >> init_card is defined? (BTW, mmc_fixup_device() takes a card as
> >> first parameter)
> >
> > Because I want to get rid of init_card. It is host specific and not client
> > specific.
>
> Ah, on a second though we can do that independently. Either there is
> some init_card - or something in the fixup tables. Why not both...
> So the else clause is not needed.

I agree, I definitely want to get rid of ->init_card() as well, but
let's deal with that from changes on top.

[...]

Kind regards
Uffe
