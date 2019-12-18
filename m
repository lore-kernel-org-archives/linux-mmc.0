Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB5C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352EA227BF
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqB4PQ9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLRNkX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:40:23 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34426 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLRNkX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 08:40:23 -0500
Received: by mail-vk1-f193.google.com with SMTP id w67so642912vkf.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA+0ZiE1F9CfUA5UmwpQRbHMZnZG6IHai1OCgcpKS2E=;
        b=CqB4PQ9bdXL0xkWjPTFOba/rEMuq85dzEGpPOEds7N7QBocl12Jk0e5uvmJYLwHAqM
         DrczYhAFQlysINL5D7mfEqDY7VgtnkauNm76VbGzMkKkpQoVIlstHEA8IrmfLzUl6dZi
         EWf/7CSdWqd544LY/k/Vkkl3ZTRHCvauki+2V8cxxeiluLB2x888e1169uYBm7lDSrN+
         bJotvoSPbKgJVL6wFxAbHf2T2eEdEAX0FilzCFqu7SXnAF2+fhKZh+CfbnfCBpDyeC1n
         X7p1X+5IutSi/eC8H112TTaDAHvdCK4RIMouBORG9ax2i3weqWbRAKmIH00By5zgE+Ls
         jVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA+0ZiE1F9CfUA5UmwpQRbHMZnZG6IHai1OCgcpKS2E=;
        b=dLfeTpuQZENSldXB7zvc6KZlbbC8L74VunykM22ztZFh17g4BenmMfOoZTsOtXatwK
         ZhtM6Hq9lPFrQO9ViK9XIkQRWggly5lZVHnw8qrbMRAq3Xv1wKjWnZtTLH0VJb+Fi8DB
         WBEwKuGyAeVco1JSgfC0jMnRXsct4ZujTNiTYMKNMDFf/8IqMuZwa23z9aDq0TEf0J9A
         HjukyyF317dsqW5/zNPfkfXbGZ4GxPp3vtJlse/zua/FOQYOP4CcIyQf2sMWYcB9odsZ
         J4f96ncnG6TCq75SSTS4PDN9O5m24afX5vmdMLnuT6N3LC5mDVhIlcN3UR6TbHfT92uI
         aS7w==
X-Gm-Message-State: APjAAAXXmdkk4yBlhI/IhrY54BdHLu+zL0tAldkUFK5QmObtgWStPKKq
        hE3uGuLr8XXD6afK5j78g+6y4d+T1AStN5dRvzJbyg==
X-Google-Smtp-Source: APXvYqyo4d9QhAj/DLghd2pgv8DMRocWvvsqMOMPEuai2T3hwUuMm7rMXGGG6cQXwtD3l0HTLK3lTF+83bNcLDiFwbM=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr1764918vkm.25.1576676422383;
 Wed, 18 Dec 2019 05:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20191204085447.27491-1-linux@rasmusvillemoes.dk> <CAPDyKFqyU1nyVUsuAPC8ZDCm88JOq45aywDM7AqR9vfr0k90jw@mail.gmail.com>
In-Reply-To: <CAPDyKFqyU1nyVUsuAPC8ZDCm88JOq45aywDM7AqR9vfr0k90jw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 14:39:46 +0100
Message-ID: <CAPDyKFq4fGTek1Y0rgbdrBsvVjUFAVPh=7VLrb-yDFZOh6RuSw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
To:     Yinbo Zhu <yinbo.zhu@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Yinbo, Yangbo

On Tue, 10 Dec 2019 at 10:51, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 4 Dec 2019 at 09:54, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >
> > This reverts commit 5dd195522562542bc6ebe6e7bd47890d8b7ca93c.
> >
> > First, the fix seems to be plain wrong, since the erratum suggests
> > waiting 5ms before setting setting SYSCTL[RSTD], but this msleep()
> > happens after the call of sdhci_reset() which is where that bit gets
> > set (if SDHCI_RESET_DATA is in mask).
> >
> > Second, walking the whole device tree to figure out if some node has a
> > "fsl,p2020-esdhc" compatible string is hugely expensive - about 70 to
> > 100 us on our mpc8309 board. Walking the device tree is done under a
> > raw_spin_lock, so this is obviously really bad on an -rt system, and a
> > waste of time on all.
> >
> > In fact, since esdhc_reset() seems to get called around 100 times per
> > second, that mpc8309 now spends 0.8% of its time determining that
> > it is not a p2020. Whether those 100 calls/s are normal or due to some
> > other bug or misconfiguration, regularly hitting a 100 us
> > non-preemptible window is unacceptable.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> Applied for fixes and by adding a stable tag, thanks!

Just wanted to highlight, that $subject patch has been applied for
fixes, which means we need a new fix the errata A-009204.

Rasmus kind of already hinted on how this could be fixed in a better
way, hope this helps.

Kind regards
Uffe

> > ---
> >
> > The errata sheet for mpc8309 also mentions A-009204, so I'm not at all
> > opposed to having a fix for that. But it needs to be done properly
> > without causing a huge performance or latency impact. We should
> > probably just add a bit to struct sdhci_esdhc which gets initialized
> > in esdhc_init.
> >
> >  drivers/mmc/host/sdhci-of-esdhc.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 5cca3fa4610b..7f87a90bf56a 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -764,9 +764,6 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
> >         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> >         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> >
> > -       if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
> > -               mdelay(5);
> > -
> >         if (mask & SDHCI_RESET_ALL) {
> >                 val = sdhci_readl(host, ESDHC_TBCTL);
> >                 val &= ~ESDHC_TB_EN;
> > --
> > 2.23.0
> >
