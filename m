Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF153C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EBB208FE
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itNWfjEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgJLKmP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbgJLKmO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 06:42:14 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB8C0613CE;
        Mon, 12 Oct 2020 03:42:14 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h6so13026785ybi.11;
        Mon, 12 Oct 2020 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76yOKpDkY6SohdWqBReb2Fv42/fYarjNUXw7oodg76M=;
        b=itNWfjEqO/BaS0tjo/KOv/XHvKupudt+e6o9uDHN1CoX8wfgGNuW4yrLPwddstExTP
         Fjw14JJiin/Ua5oMYhjg4zNYWfNkfcWsdb6BHdg01RVLmlJaxYg/5riS+tf3KY8NDS5h
         2k8wH+kmn5xNROrBmfMJ49HkQFjodFjnDW9Fgz0TSfa6VadewYIcLsdFH8ZAj1N50bdd
         sCB6jUh3BjaWizWoi8AEWaZ6VqpDaox5FY1V3YqU1G9pJmmnsh3VuFeNCv8A39HcuUQZ
         M1k98lFJKgFWGPC+tiTetB/qseqns7CMkcI4B7G2yt7CIDyv1NFZc7ZX5VAHxlQqVMR8
         b9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76yOKpDkY6SohdWqBReb2Fv42/fYarjNUXw7oodg76M=;
        b=n5yHKF8UdUMX6P7S4zOnar7w0KMXOa4PAWG+ybeFJ5nOJNu07LQPR/CAxFEWNomOHV
         SlfHWstKJZOfdM1ACbf7X2vxsiaHy3j+vwiWGp5EmBXN+SOLg+mzUBNbJA+c8kfKs5E1
         YQ80z0AKTaWFaFL45ByAGfC87c/esfSwKT5tfgqDKByyzM38YzrjQ4IVBNmQCSdhN/h0
         3gSX8EJIIRsWYCmS6xULLEzJLxl25r/hKTMv5ais+UymTlQjHAzXsCPT9Kkz+c9DisSS
         g6LZoJAER6df0lxMBKS1SVDNLLdR9GZYlKCbF5tE+BbLWvjtWNTn+uPKo8wmHrQ0lUiL
         h1Zw==
X-Gm-Message-State: AOAM533YfDgyzHdU7ke3R31eb9zPkoG80ZuT7X9tRMTDravDJN0L2nyR
        rkezOguKtYRjRBDiaKx7A2gnUB3YrkdGDI0hDyrSp5ZCu5f6/g==
X-Google-Smtp-Source: ABdhPJx6yMMXbEmNmhY5yrzcuCxsT22YJ4xZVrkRDDG7gfnR/4ouIkkBHZjYadL8Yqx0pIaUdJPI+davp1VqKCnCGTM=
X-Received: by 2002:a25:3cc4:: with SMTP id j187mr29096132yba.48.1602499333899;
 Mon, 12 Oct 2020 03:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200717033350.13006-1-benchuanggli@gmail.com>
 <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com>
 <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com> <CAPDyKFrWO_x2wBjKRaoS9ypEszuQ+RWMr5Vej0uBOVV3=AAD-w@mail.gmail.com>
In-Reply-To: <CAPDyKFrWO_x2wBjKRaoS9ypEszuQ+RWMr5Vej0uBOVV3=AAD-w@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 12 Oct 2020 18:42:03 +0800
Message-ID: <CACT4zj-TxNAFKzPoBE8C3702qz1=Pg2tboMwUHd+nd2BuTF5WA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and
 enable SSC for GL975x
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, Oct 12, 2020 at 6:25 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 12 Oct 2020 at 10:41, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > Regarding this patch, we also want to fix the EMI of one hardware
> > using the old version(such as v5.4).
> > Is there a chance to append a Fixes tag on this patch ?
>
> Unfortunately no. $subject patch is a part of the pull request with
> mmc updates for v5.10, that I just sent to Linus.
>
> > Or what should I do ?
>
> If you think that $subject patch should be included into an LTS
> kernel, please send a manual backport to stable@vger.kernel.org. For
> more information about the process, please have a look at
> Documentation/process/stable-kernel-rules.rst
>
> [...]

I got it. Thanks for your answer.

Best regards,
Ben

>
> Kind regards
> Uffe
