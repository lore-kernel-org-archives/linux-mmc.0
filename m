Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C82C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D5920671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyVQsNfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETLfw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETLfw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 07:35:52 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D967C061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:51 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y13so1599347vsk.8
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zK8dEPln8n7z8M+Cdh5s9Lm+Ph7WLhAQpVv+WCxsE9Y=;
        b=IyVQsNfwcgVUvFsLRjdWpCVIwZvzrlx/QHP15TwdH7reHfSJ5yI/ZzG7ae0BW+Vsg8
         LxspdU/IPW2xygn2FVE3+dXxD2bx9ugUITgPkesVufvnlkSmiLv0B9Fc6A4C+NO5qkbz
         6q/TihPgupDb+HeKVVb7rAuN+HH9tktMko+vcTV/21g5vwVbcVdzgcj1gxdSGcS0PTSY
         PC9Q5mSEY9UpxDL3aWE2B2ReIw+sZWLCrFABhFRKSDBX2d3v1NiZyXsIeIYsZ1Iibf5m
         pYybVoY8Mo2zLf7Hs5miWkQqVRBmjQMvjD6HstLZ+euVrSLtEY5/yTCBsqhSJGclwytv
         9N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zK8dEPln8n7z8M+Cdh5s9Lm+Ph7WLhAQpVv+WCxsE9Y=;
        b=g0cMC1d2+crQ8GRUF1mVl8EIPK1u2B6Kgg+BjbLSDUWPMrKicQ92eRzooXAUmfIztA
         sRfFlqX04bHU1y/3KSgqb/LNtBtvqhVGjEQfXBLrYbtjXHKwig6I4+qu7YsV0KFVME5h
         o+IET8X0GaWVU53E2nSpwB7Gok4mE82r8NTsPn+Jh5dSO7PepWrZPNSky7SppgLbirAk
         xege3RwfNurkDm7l/lsR78QsLTof6ZvIf5UZFzA/EQd01uNJj1GH3AtDX8Ip3sW7D61C
         MVmDqPKFiB3C+pZZdoEE5YUchvor22CBIm9a/VL/+jNeXSNgYl1DdhwRVlrYE45VvuC8
         Uo+A==
X-Gm-Message-State: AOAM533VcME6MIziK7vN/xBrs9QIO5zmHSPSSQxi0oJBa16uaVg3W6pz
        06wORFMVfXN0+SfhKgTDCtFxr6yP1kr6XfXX62zEMA==
X-Google-Smtp-Source: ABdhPJwgbzx+yVnSY7OiiW3JsNWXg0FI9gTEscJuT3BPaJUwjfuF0M958cKljPf4MjVA26NBSvFgJAfPxRk5rF5V1Ls=
X-Received: by 2002:a67:690e:: with SMTP id e14mr2913056vsc.34.1589974550485;
 Wed, 20 May 2020 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152445.6922-1-ulf.hansson@linaro.org> <20200519163837.GA20235@ninjato>
In-Reply-To: <20200519163837.GA20235@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 13:35:13 +0200
Message-ID: <CAPDyKFq9Wb2_2DfuenMTMou=6yxJ+ZyyEPCvhTqJmpKyZTCOew@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 18:38, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, May 19, 2020 at 05:24:45PM +0200, Ulf Hansson wrote:
> > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > ->start|stop() callback assigned to it. To make sure the device is
> > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > which is currently managed by tmio_mmc_host_probe(). However, it's likely
> > that may be too late for some cases, as registers may be read and written
> > way before that point.
> >
> > To fix the behaviour, let's move the call to dev_pm_domain_start() from
> > tmio_mmc_host_probe() into those clients that needs it. From discussions at
> > linux-mmc mailing list, it turned out that it should be sufficient to do
> > this for the SDHI renesas variants, hence the call is move to
> > renesas_sdhi_probe().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rebind works on my Salvator-XS board (M3-N) and my Lager board (H2). No
> other issues found when booting and accessing SD cards or eMMC.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks, Ulf!
>

Applied for next!

Kind regards
Uffe
