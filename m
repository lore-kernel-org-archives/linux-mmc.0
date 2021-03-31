Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4153C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE661920
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhCaJ6H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhCaJ5z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:57:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2CC061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:57:55 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id h34so5955272uah.5
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/4w0xGXQr4V8hv1TMOj1rdT2uYQ2Zn3yahGktko5LI=;
        b=vD3f51suI/hibKgnCzDplaC1Wvjkiv5pk95Q9OkjBAaHm6iC+YfDF75mnhUauRatMQ
         WCjT8JWpjTeJnFmVWCVWsP473ipIJesrrJsJkdfasTxn9LelBGG7oCxQ+nx0ZD4frr1J
         8zJ2PYVfPc9xnj6iLip+AzAifdgxJek0WZTAvZ9/4bwhF0GAl1qE4UXCcxssTkqepRa4
         eNK9EZOrUqoOrvqL3h65gpcbthp1NrH+jXAa3hkcF/rNCEvdFhWPf4BxCWectRABbEVg
         kUf06pB489TJ7WbwvtQGdXt32+n05V7CDyVsK60RMpFJtvyWE4xFJZDgatbsJ+Ul4sGo
         igmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/4w0xGXQr4V8hv1TMOj1rdT2uYQ2Zn3yahGktko5LI=;
        b=XsohtNkEyHljMGVpBBgOHuj4OG3F3XDo+nUc4iD51IDM9qR+tTW1iLLMDLaBVZrzn4
         yWRguSvYejtSUdGZ3SZd63N/U9eL2ZCca8A/tlp7GOLamVF9LhR1CIeL77Umzw7gZsEi
         1crxi7J/1XfcPJ3eqMiqNobnL+mjFdO2XbglTz/th4rHzJTpOBatTxFPiOWrD79jWHTd
         LFYbA+e5slqzkEPMkTD2mNjHabxqMx3KGi7Yecf3MWbY7REMVuoTWpoIE4Y54ZY1AuW7
         U7Eqzgu9dAszJdfIkn8SeDl2+k97rCSz85jJT3q69jw7cOjSBBQC/YOndQ9kxhrcy05G
         9iEw==
X-Gm-Message-State: AOAM531pMCSJItpnPNTsa7IHEixrMACwvqTXzEq3uaon8+6B1QL2dbkh
        +FWbE0MxS/04WbQmY4XLoDlX5GXjGYMNhxcKRwmD9A==
X-Google-Smtp-Source: ABdhPJw8gZ+V1rBvQ6SEQxKGUiFOg2MD21AiJcNu0AmvI9RthPJOKf7uTIaGd0U0J2P909HggPn33jJHoaA5yNa+r3k=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr832849uar.100.1617184674669;
 Wed, 31 Mar 2021 02:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
In-Reply-To: <20210225170352.76872-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:57:18 +0200
Message-ID: <CAPDyKFp0+jBDcJnxbvdkZWo6jmSa-CdT6RNbH2hmrWnXEqU0=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
To:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Renius Chen <reniuschengl@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ben, Renius,

On Thu, 25 Feb 2021 at 18:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> A series [1] that has been collaborative worked upon by Takahiro Akashi
> (Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II support
> to the mmc subsystem.
>
> Throughout the reviews, we realized that the changes affecting the mmc core to
> support the UHS-II interface/protocol might not be entirely straightforward to
> implement. Especially, I expressed some concerns about the code that manages
> power on/off, initialization and power management of a SD UHS-II card.
>
> Therefore, I have posted this small series to try to help to put some of the
> foundation in the mmc core in place. Hopefully this can provide some guidance
> and an overall structure, of how I think the code could evolve.
>
> More details are available in the commit messages and through comments in the
> code, for each path.
>
> Kind regards
> Uffe

I just wanted to get an update from your side. Did $subject series
help to move things forward?

If there is anything else I can help with, then please ping me.

Kind regards
Uffe

>
> [1]
> https://lkml.org/lkml/2020/11/5/1472
>
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |   2 +-
>  drivers/mmc/core/bus.c       |  38 +++--
>  drivers/mmc/core/core.c      |  17 ++-
>  drivers/mmc/core/core.h      |   1 +
>  drivers/mmc/core/host.h      |   5 +
>  drivers/mmc/core/regulator.c |  34 +++++
>  drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   6 +
>  include/linux/mmc/host.h     |  30 ++++
>  9 files changed, 404 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> --
> 2.25.1
>
