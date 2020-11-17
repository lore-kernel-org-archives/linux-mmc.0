Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC1C56202
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA932222E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K36hufdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgKQL1j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQL1j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:27:39 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D2C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:27:37 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id z123so10864228vsb.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJ6od9McrPMmdAw4AV7uEvRIjejlQ+vKJRvVg9MI4ko=;
        b=K36hufdysbVWhCU4svS8Pc3+yb0iT4gKHBu5uOJokNvd6bDdJeWvsW7l33U1uIPh4a
         ZGRaGsmbSN0/iZvaDH57KJUchoU6Ii5WDoP6RzUMRq6cycTP5d/dFqU0T4Y74jH5vFMH
         EfvIpyeGcAVQjQcVXQ+Ci21MF962YwiYYRU88yn93KMHaw527KGXD0xEJfQ+1wKzi4ra
         Tlbu7mGyYhwTuQCcXwTcbGwOtOMNtkzcwgpPKrhIKMcxkw11n67HPt+DbynsXiC5oec3
         6l5sj2B571995pIrmsds6NzXl9sRSnkdEV1NqFW+k3eOavvkOBhjdbgkTw5/upeAlncd
         Slgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ6od9McrPMmdAw4AV7uEvRIjejlQ+vKJRvVg9MI4ko=;
        b=rMqnqlO6nTcZlGMbk9KOJc5teYkYOo4dLC0kf3GRH9adMQhuAnXV/Nl2XLlfMd3Z6I
         Yb3cKbSDHdKlZhV0Csqp6qYzx8BJdQHbd/cHcJM1H0b6O6Aie7hc8kKaXO50sb0Z0laT
         AboQOOFxsCXpXAX2n96CSuN7otXm7PbMpA95czRJx/Ef9WhHYttCOXYQxPTtPe5u3n63
         m/6pFteozEC9lfHJTdGCXC5kAQ5v7KdR00iqYPvTbaregSvNljAvgmQfZ6Bh1X8jW6v+
         BJT0lqT97XPfIfMSmi/fXcYidoadtTtWu8+b6oZ17broRfsFaXR07qKLMEs8aRUP1928
         nAVQ==
X-Gm-Message-State: AOAM533FBhAXcWLWfe00og7fiz5IT/3tTBuQy1WinY0ayo4j+wZVkcwh
        YQR/qq1g/jAoTHT/tblsiIPi+MWv78hW0kyKDQs1Ng==
X-Google-Smtp-Source: ABdhPJxkXnes2p6YHECDrKrrBG2GDdqrp5ut8s6gultvQTB+ovgHt1SMWFt+SHDNj4iDrRQdHuskHjfUkly50tbEFQY=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr3329095vsd.55.1605612456743;
 Tue, 17 Nov 2020 03:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com> <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:27:00 +0100
Message-ID: <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Nov 2020 at 15:22, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi Ulf,
>
> Thanks for your review comments. I replied inline
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Monday, November 16, 2020 7:41 PM
> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >Cc: linux-mmc@vger.kernel.org; Linux ARM <linux-arm-
> >kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Raja
> >Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan
> >Mohamad, Wan Ahmad Zainie
> ><wan.ahmad.zainie.wan.mohamad@intel.com>; David E. Box
> ><david.e.box@linux.intel.com>
> >Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
> >Bay SOC
> >
> >On Fri, 6 Nov 2020 at 05:10, <muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >>
> >> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations
> >> handling") introduces platform specific SDHCI clock operation.
> >>
> >> This patch declares the clock operation for Keem Bay.
> >> Add clk_ops for SD, EMMC and SDIO operations.
> >
> >The above commit message doesn't really tell why or what goes on here.
> >Can please try to clarify that.
>
> We missed out the clock operation handling patch (Commit 16ada730a759)
> and did not handle the clk_ops  for Keem Bay SOC devices.
> These 2 patches (Commit 16ada730a759) and (Commit 36c6aadaae86)  are merged at around the same time.
> We catch the issue later when trying to boot into v5.10-rc1 with Keem Bay EVM.
> That is why I created this patch to handle the clk_ops for Keem Bay devices.

Alright, so the previous changes were simply not sufficient to
complete the support.

>
> >
> >>
> >> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem
> >> Bay")
> >
> >Is $subject patch fixing a bug/regression?
>
> This is to fix issue on previous commit. It is a bug fix.

Has it ever worked?

Did the commit you point to with the fixes tag, break some other
existing functionality?

[...]

Kind regards
Uffe
