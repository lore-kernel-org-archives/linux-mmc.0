Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4AEC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E40061181
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbhKILXL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245694AbhKILXK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:23:10 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825AC061764
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 03:20:24 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so19572088otk.13
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmTY6+vipDnry1BuH0kglrrDvK4I6FWJBnVtJAkEUJs=;
        b=kOUcHNJzK1AOTDH7aaitFTk5gIYZEuKw8lAzuSWEaZdIhI0OWuu/0eG1xszEsHXL1G
         OqZkN8xqPnsfptfvyviEfaaRu04Oj3BBE5SzFLJogpdGAXdPJvc+/38NHjwSCsKwaq2U
         naAz6SY23VmJO/PYz/d9+oLlpnZgJvtqfKX5s06PeTVz+zF1lgH0GAJHPcCeT4X5Hvoj
         3silbSjKh3Oh81uU+SFmOnA2iHxOanNEcpVhmZxKatNcn8B7N0a5wuiL6GjllIdXg/S9
         bMM+EGDucURBUmnsCqZ6FR3IMMJ72D4uXYzhxkPlhxybXW0eAYWslY67rwvitGQiIHEh
         bgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmTY6+vipDnry1BuH0kglrrDvK4I6FWJBnVtJAkEUJs=;
        b=JfytCPaWLJO7dr5BcTATMN+eMWnDWc/Yfp/LSBr3FMhBKifBNzk3pMJqr6cPlJQLm6
         vloR1UKi4a3nHXbLhLj5Hh27PtkZ3zF6CsHkJzpLZz1eCJkZm+QTUcWbhNdQUC6QIJsT
         KbUprWVLE3wLz9LxMWckKQl36KZahdYSp9L8/gX8UVyeDZ8GTrmJ03F7N0WjKhONfYwW
         d6NkVYGPqifErAmZKZjX5ozP7dSDcoV8/ZpMX6LHkpT15GTucNTCVU4ZJ16VsU3KQPON
         sekw5LSPz5bDQT91607HBMr4V9WF5FJyN3Su2EkspJMqCoke/CtGVrmJE90inesZDKqQ
         asZA==
X-Gm-Message-State: AOAM532hOEHm8rrLP04ExF2/6PzSrbCjYc/4mcTJE3bO1d9vJDTmJLwN
        LHIbn89RgvqInVCe85XVAuQMDnK2GxneTErEpOQPISJftFI=
X-Google-Smtp-Source: ABdhPJxDMEfupeGBt6AnxsEf4co6tdbxFLiopGcMNN4qGF3yJlxIr3ESSWb3FMmX6uWTdwaCxYJ7k3OdDFuJLVX0qwI=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5322632otk.179.1636456823276;
 Tue, 09 Nov 2021 03:20:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <71f77891793dc29bf9afecd6df45d66a66f73e56.1635944413.git.hns@goldelico.com>
In-Reply-To: <71f77891793dc29bf9afecd6df45d66a66f73e56.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:20:11 +0100
Message-ID: <CACRpkdZ_cUPmOpeGcgz9kVzucMHpPCsbPjSCP6zWsiy7_yX2sA@mail.gmail.com>
Subject: Re: [RFC v3 6/6] mmc: host: omap_hsmmc: revert special init for wl1251
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Replaces: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
> Requires: commit ("mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc")
>
> After moving the wl1251 quirks from omap_hsmmc_init_card() to wl1251_quirk()
> and sdio_card_init_methods[] we can remove omap_hsmmc_init_card() completely.
>
> This also removes the specialization on the combination of omap_hsmmc and wl1251.
>
> Related-to: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
> Related-to: commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251")
> Related-to: commit f9d50fef4b64 ("ARM: OMAP2+: omap3-pandora: add wifi support")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
