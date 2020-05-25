Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C6C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBA2071A
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="A4sFV2hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgEYIqG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbgEYIqE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:46:04 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7FC05BD43
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:46:04 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e7so9546792vsm.6
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdvbHZ/U0eSo/nSE6jZG36yYG5hVVzqJpLZgsZ5Atlk=;
        b=A4sFV2hcMddZibVAH4cxdEwT2ipYq4DbCca452hKDfjeokN9RzgtZhnSPmFQQ0slQU
         K/IuDehNmqbJ841UKfIzBdfkbh0umMQ5ElYDOmNj16ZYFEQ3xjqS9hCL7X2HQpy5S9Js
         ryTVWdqQDs0EKGVvobQ4BM+8qCpud+e2B8YHV5qIXDsMb0Deaw89YE2NIm6YgT8PGRlZ
         QiGWK7qll06Io0tcTz65dtPAP5ZJoJa4e2BzFujUNP7ETo5SrDHWHkS7zFeH17mGVbdr
         KsEyg+6FyeFN7mvPZEt1LgpE55gDHcMtLuz6nQGTXePBbaJqTbdWfJcFxV6rSoqngz9W
         Tx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdvbHZ/U0eSo/nSE6jZG36yYG5hVVzqJpLZgsZ5Atlk=;
        b=YWAK6ORTITGGXEBsJlwveokRMY0H1XUN4W0Is2DaIqyzkkva30CEm8o7TjRqO9tavJ
         /ZD0K6QHNvoFNl2OL8k+zJ/MVxJl69a8tUosH01ObfewS/2qJej29CnVZO3CL5rEYiqk
         1vl+9i1KHObZ2KuHjuNGWWoHDNgsxCXWg9guzukp3XXDZ3RwCnFrkNr0kf3vtGe3Z7Pd
         yONF4nOZaYJy0CO7hFzq8Y4gZOqtygXxY90zRvfuXtAN0oCsmxl8NVfr2bWsVL+NnPbu
         BUBnUfo4jyPgv5DmnjRJ58lLGt0dG1omKrUAjXAVkZCRuN/ObODKxBOAZ9d8klk+YokC
         jfBg==
X-Gm-Message-State: AOAM530R1TcoAxlfv77BgL3A9gv0+V/VNOGbMeVN8DVvx1mzANlYxlTd
        gzY4ccz2sTeQ04Lyz+e2Aay9Fm7S3Fk5vyHhinUf9w==
X-Google-Smtp-Source: ABdhPJyserwYHX0S0X7xx4bNhPaJ66+YF2aJlyKso6boQW6YJWewEmZJ+ybPGjhTFf7v9yMbyIl9gIQNPEc4KhFZ15g=
X-Received: by 2002:a67:310e:: with SMTP id x14mr17151480vsx.237.1590396363418;
 Mon, 25 May 2020 01:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518191742.1251440-1-angelo.dureghello@timesys.com> <fdfe557a-49fe-410a-cb05-5bff5e04fdd0@linux-m68k.org>
In-Reply-To: <fdfe557a-49fe-410a-cb05-5bff5e04fdd0@linux-m68k.org>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Mon, 25 May 2020 10:51:15 +0200
Message-ID: <CALJHbkAsiFGUD3hWzgd1WqnoMekcC60i6Sn66SZS4nde4ksSdg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] m68k: mcf5441x: add support for esdhc mmc controller
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Greg,

On Mon, May 25, 2020 at 8:02 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Hi Angelo,
>
> Have you seen this breakage being reported in linux-next?
>
>      arch/m68k/coldfire/clk.c:78:60: error: 'MCFSDHC_CLK' undeclared (first
>      use in this function); did you mean 'MCF_CLK'?
>      arch/m68k/coldfire/clk.c:83:61: error: 'MCFSDHC_CLK' undeclared (first
>      use in this function); did you mean 'MCF_CLK'?
>      make[2]: *** [scripts/Makefile.build:272: arch/m68k/coldfire/clk.o]
>      Error 1
>      make[1]: *** [Makefile:1736: arch/m68k/coldfire] Error 2
>      make: *** [Makefile:185: __sub-make] Error 2
>
> This is when compiling for pretty much anything other than an mcf5441x
> target.


>
>
> MCFSDHC_CLK will not be defiend for anything other than mcf5441x targets.
>
> This mechanism looks a little out of place here, given how specific
> it is to the sdhc hardware module of the 5441x. Can you move this
> to the m5441x specific code resolving this?
>

i apologize. Couldn't catch that since building for this target.
Fixing, re-testing and sending patch in short.


>
> Regards
> Greg
>
>

Regards,
Angelo
