Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CAC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D15320671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2x2bqvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETPTR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETPTQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 11:19:16 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D160C061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 08:19:16 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v192so853226vkd.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZhWN6I6XN3S+vN7D0jyVBdq6EMQB2ZmjklvT4cPhK0=;
        b=z2x2bqvtbeKnNLbyGJ6Hbe2qY4tcWK7XRW7mTDNFtNUW+IiCrAkie1TNORgJOGZcuN
         Ep6cqrjjOWPNLnLmZDqbGX7hzxfH0G++ujD8n+xJMgpSOlt3nB1OR2y49N1vRi/kc4eh
         kJ4IvVLvctu++hz9MZUEMfidQe0ZyQom1BfpPJBi5uDXiFs1ugT4cU6SHMiCczui80D1
         VNvd7lkKT8pHHhw1vJxoQG3ALQS2foMgp50XJHFAFr/KMSOMo1NlJZYdwQ7ilt3YfwbR
         bpQTc7kjga4lcPotUF0GVkpcBV9kHI5aTs/XWP1RWxbv8jhofMkUBSIHftZUYfXgR9lh
         Hhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZhWN6I6XN3S+vN7D0jyVBdq6EMQB2ZmjklvT4cPhK0=;
        b=P8WQKf4bFRUws9Ks0mhd7mw4hEQZKEmF6jsMXfeavLYmXGksU/Dc3npoQydxSFeW++
         V6C/2qO6qv+uYTrYfVWlS8dfokbCFl6054C4pD4mUkZJs76fLWrircrsiLwIKVG5Cj9n
         Zhv+onaJt89Dowiv0mjwekUQgBsQVp84+GLcoEKMPJQ/Z1YOjf9EJZEMzFfJrA7dyuNL
         cRU/coA/SXmIkfWqkbf9Cg30BQ6BLZwHSj7MK7NYoUdvgVmMXaUExRq8lVaDfWiQqfIw
         dhiJtROst8dSMY33GECQwhpfhuI2XFj5HIlkEn/FAKOQ0CJLQY/N0GF0MtGnRTToUy1o
         blhw==
X-Gm-Message-State: AOAM530BxyRfsY8Wd+lqThjE6z/cIuyZH/vNCekPwt3/gpEWVNU9UuA/
        TdugZ4A/paa2i+cQ9zwnBsXflVeIxNfw74ujIfvd7VyC64w=
X-Google-Smtp-Source: ABdhPJzXlBY+dkaAQ2IyFuugQ/A2QO+WwVY8T/pTFfVjJa6Q1P1MH7WtNgStG4M//iHMksyMZWP8LAlik4JHh60rmYE=
X-Received: by 2002:ac5:cded:: with SMTP id v13mr4191661vkn.59.1589987955751;
 Wed, 20 May 2020 08:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152434.6867-1-ulf.hansson@linaro.org> <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
In-Reply-To: <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 17:18:38 +0200
Message-ID: <CAPDyKFpHTXkgukTJ5zLu4qBBqv0XDg12cMy2AtfDKDhFuahzXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 May 2020 at 16:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Before calling tmio_mmc_host_probe(), the caller is required to enable
> > clocks for its device, as to make it accessible when reading/writing
> > registers during probe.
> >
> > Therefore, the responsibility to disable these clocks, in the error path of
> > ->probe() and during ->remove(), is better managed outside
> > tmio_mmc_host_remove(). As a matter of fact, callers of
> > tmio_mmc_host_remove() already expects this to be the behaviour.
> >
> > However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> > option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> > disable the clock via runtime PM, which leads to clock enable/disable
> > imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
> > disable the same clocks.
> >
> > To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> > device with clocks enabled, but also make sure to disable the IRQs, as we
> > normally do at ->runtime_suspend().
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> (on R-Car Gen2, various Gen3, SH-Mobile AG5, R-Mobile A1, R-Mobile APE6,
>  RZ/A1, and RZ/A2)
>
> Gr{oetje,eeting}s,
>
>                         Geert

Thanks, patch amended!

Kind regards
Uffe
