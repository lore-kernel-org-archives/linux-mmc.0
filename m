Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A57C56202
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90372087C
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 11:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="rNs4PcJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgKYLuz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgKYLuz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 06:50:55 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F4C0613D6
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 03:50:54 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so1368657qtp.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWHXtnJL034sJMBqF5IThyvUi6rUF8wK25sO02Hq/Os=;
        b=rNs4PcJMRniaGD1WnzKPfAGaoXgGxgKO20ODWcgst/UCbSgFSSRMGD/ugUXJaVQ5uh
         GNv5e7GzUF4XJY+7KWFFy86b/uY4iV4MFuRfPAAcpnr32XA3tpeDnTOkLTa8OGQT7jeW
         k/3GG060WaNR+ef5MXv4M1eZY1+Adx+6f7gnKY0FBwFNgLM5Pv61nc+VfsUjq+NF6NG4
         4tWYoItmkOH6rSe18r13V7sDlc1CoS44m0dNNeJ8GuUrzEZkvSXe5QdYxf8SnVsDSTDy
         gxQaTyefQi4rVz4obkU6RwsLDjB/B99/c8Vlr+9oEYMShQM6BCyggAz8pBqjeAddp2ul
         pYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWHXtnJL034sJMBqF5IThyvUi6rUF8wK25sO02Hq/Os=;
        b=qCtKLbWf1DLHYK5AnZySGutvHsz7n/jvSi9UCK0uMFtDhJuJCIPvg7sGV5psKnDKjf
         vnNHXsukedU5lyR+1x9eEuvAW6TiptyzjBhJtt3/KEY6QK19SsXnPi3/A1SpFT1rVJ/z
         gVuaVlVN9wmRYZYJfgXwYSLG0UvFYifVUtR9TRDmvmQ0WC5q34XaEy+As6SxxFtdW5UH
         UGjHdj0VXJDKeJz3kRmFFQx5ZWGxv8cdRTaJg1F+7K+OZaa9gA+kDBslMOTziNbZUieL
         UWMknrCwvA0UAZMCBfICWessXBhSUwJnowVUUxpHzUnbfUu6vJbBlns6iAkWlf/5pTjE
         VBrQ==
X-Gm-Message-State: AOAM531mJppq/79uejjpjasZUhrqGprsEhih4wdM1BHHRAVfsJEfPAH6
        mKDdFakKgQGHgmrvYd0rP++l9wFs7NE07nHuzL8D1Q==
X-Google-Smtp-Source: ABdhPJzNJepk0uWGJye3IAxT9og+sVbEj2x2nX+/VOosx8KV4Vb1t2g/cNpHgU/+qLvXQhbCJtLkNdHY7Znhdxo7SrY=
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr2654424qtw.306.1606305054002;
 Wed, 25 Nov 2020 03:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20201120032639.24386-1-mw@semihalf.com> <20201120032639.24386-4-mw@semihalf.com>
 <CAPDyKFoXX_uOkes6JW5thTe5rqjCCrB_pYvLkTzHncfcxvMD_w@mail.gmail.com>
In-Reply-To: <CAPDyKFoXX_uOkes6JW5thTe5rqjCCrB_pYvLkTzHncfcxvMD_w@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 25 Nov 2020 12:50:43 +0100
Message-ID: <CAPv3WKcF9ZihAtzO3UekaP76UFhPvbHTtg0S+Eu=UbKtb4+ocw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-xenon: use clk only with DT
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

Hi Ulf


wt., 24 lis 2020 o 12:31 Ulf Hansson <ulf.hansson@linaro.org> napisa=C5=82(=
a):
>
> On Fri, 20 Nov 2020 at 04:27, Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > As a preparation for supporting ACPI, modify the driver
> > to use the clk framework only when booting with DT -
> > otherwise rely on the configuration done by firmware.
> > For that purpose introduce also a custom SDHCI get_max_clock
> > callback.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> [...]
>
> > @@ -561,9 +574,11 @@ static int xenon_probe(struct platform_device *pde=
v)
> >         pm_runtime_put_noidle(&pdev->dev);
> >         xenon_sdhc_unprepare(host);
> >  err_clk_axi:
> > -       clk_disable_unprepare(priv->axi_clk);
> > +       if (dev->of_node)
> > +               clk_disable_unprepare(priv->axi_clk);
> >  err_clk:
> > -       clk_disable_unprepare(pltfm_host->clk);
> > +       if (dev->of_node)
> > +               clk_disable_unprepare(pltfm_host->clk);
>
> There's no need to check the dev->of_node, I believe. The
> clk_disable_unprepare() is capable of managing a NULL pointer as
> in-parameter.
>

Indeed, clk_disable_unprepare() can handle the NULL pointers. I will
wait a couple of days for other comments/remarks and will update this
patch in v3.

Best regards,
Marcin
