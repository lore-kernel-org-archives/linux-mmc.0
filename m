Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD598C19437
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C097C22B43
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgLDRTm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbgLDRTm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 12:19:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BCC0613D1
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 09:19:26 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so6103048qkq.6
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZENXwp/mbOpuUA3VU+AmP56OfM+59cOFAKz/i16yr8=;
        b=s7DUSXf2UKfa6WF51SGm1zhLe8D7zIAH5N41VtmJRjT6eEvHVrAX5z1XVx377vgJo8
         I3zvwLqKiLYmKPyhI0miSfBYqJwRVRmNgHX9gBeae2hE5z2KOFJXZVSTcn51bBq8Sd2h
         6rhRkO443QYxsJgVfx+SpU+YYcux3PWflF06UB9xGbiupDJe/1LwutMDepTD7q/0H+5g
         sKQmfYJQxKwTIwIN37LT+IBpglx3KloSydK0ZjVckQpDUVgYzBENeN8gB5huZQSAeXMM
         K7GaHP3h1L9l7KsVra/IfpfuIkbcV4GC+5AjJ2o0Dc80OLr5AmC2YCcqq4PQe46K3D0O
         tjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZENXwp/mbOpuUA3VU+AmP56OfM+59cOFAKz/i16yr8=;
        b=jKXS6uP+xk+oXxcA8g8SK43G8a7lU/szySOo4Zj5RuKuV7KbEZY86uvwpyXwAt7hzW
         5JG0Z9S0UXatjMEIfob/yUTSwpgT8v9E5yz6vrU+3WdiGFfW0jaYVmK75EBYBKJx48kB
         NmVejWdGY+ay9BPvkppRPgm+fo9b5UtX2RCwa9QM5WVvLniUzxAu9MQUrobN9+8gkxVe
         scdr+G0glF3heyYVuiEgmtfmnJ6mKIsWNphory95n//cBCJ/cXyBB8LvQRDBCtxficeU
         8o/UNktvZ01VpJYpgenB/wiSdgfibIVZro3HsF5x3kavHKEj59eKnijEw2tHOBpAImg7
         f68w==
X-Gm-Message-State: AOAM53100cfF5M9+S8M9TLEuCM4qFEa94FmpB576RY1wBhX/8XM2M3/Q
        HKhuw0JZdmJ1tnI2ELaCzBeJf0wAC2oYU3YGFJG/Gw==
X-Google-Smtp-Source: ABdhPJwNRwo4xiaTnJlMuUspZ487ZdEjv0BDXLIQfzZG/FxEqfW/NsqpeaT8x/40CXaOGdzcnZQ1IMX9/YdZXL1w1bk=
X-Received: by 2002:a37:f509:: with SMTP id l9mr1849305qkk.155.1607102366002;
 Fri, 04 Dec 2020 09:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20201202185118.29076-1-mw@semihalf.com> <20201202185118.29076-4-mw@semihalf.com>
 <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
In-Reply-To: <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 4 Dec 2020 18:19:14 +0100
Message-ID: <CAPv3WKfX8coEcTAR9gdt=Pg=V_UHZ0tMzRfOdGz6jemYsV3UqQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: sdhci-xenon: use clk only with DT
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pt., 4 gru 2020 o 14:51 Ulf Hansson <ulf.hansson@linaro.org> napisa=C5=82(a=
):
>
> On Wed, 2 Dec 2020 at 19:51, Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > As a preparation for supporting ACPI, modify the driver
> > to use the clk framework only when booting with DT -
> > otherwise rely on the configuration done by firmware.
> > For that purpose introduce also a custom SDHCI get_max_clock
> > callback.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 61 ++++++++++++--------
> >  1 file changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xe=
non.c
>
> [...]
>
> > @@ -637,10 +650,12 @@ static int xenon_runtime_resume(struct device *de=
v)
> >         struct xenon_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >         int ret;
> >
> > -       ret =3D clk_prepare_enable(pltfm_host->clk);
> > -       if (ret) {
> > -               dev_err(dev, "can't enable mainck\n");
> > -               return ret;
> > +       if (dev->of_node) {
>
> I didn't notice this in the earlier version, my apologies, but there
> is no need for this check.
>
> clk_prepare_enable() should cope fine with a NULL argument - and you
> only reach this path, if the clock was successfully fetched during the
> probe or that it was left to stay NULL for non-DT case.

You are right, thanks! I applied the change and resent v4.

Best regards,
Marcin

>
> > +               ret =3D clk_prepare_enable(pltfm_host->clk);
> > +               if (ret) {
> > +                       dev_err(dev, "can't enable mainck\n");
> > +                       return ret;
> > +               }
> >         }
> >
> >         if (priv->restore_needed) {
> > --
> > 2.29.0
> >
>
> Kind regards
> Uffe
