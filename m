Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C0C433E7
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010C52078A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZyvI4mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgH1KJA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgH1KIs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 06:08:48 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E399C061232
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 03:08:48 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g11so204117ual.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuUZC5yykdxlzV9TZ9jygIZUaAZV3AvDbw/Md6MDSbk=;
        b=CZyvI4mE5e6GC31FhNtjJu4hgn/6iN7+1V4C5ulyqQvdp/AkkHHa9duZvoDIUje0iQ
         13aWi+vlxmpSwceKGI1Anf3Byyh4SWXLKs3jeJ2nnbUFWCEYFRbhuGFkEsY9mwkVfh5g
         XQ1as2Rl9K2S8AjjSi9TqOjxKgqyQC4RAPaNlfnpEL5bV9hKEXDYJ9bVe+7JTBdTWyOH
         YeBAr+lgKzo7JflY+R63AZ8Y8c1qTk6XxDXT+WH/ksJYiC7WjqC5dszMUwfVwr4JFqG8
         b6B/uhfMQaV9bmR25nehSmrMuQzH5bpZNHzGyUS68pJ+ypT42I9akYEysVHy4sbJqEc8
         Fv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuUZC5yykdxlzV9TZ9jygIZUaAZV3AvDbw/Md6MDSbk=;
        b=QzGdKlRnZmw8U/77IHb4ZFnWtYrr85lBpEI6wCXwyS9unY5upAmWEpYb8KEadqPgP0
         ARG9tgDFwXf4s0laFvzL6VlYYb4mukv+Uh0tq/pbKHs2vvRcZ9ksq6pwFM6KeQsMBZP1
         GSLjRmehA1en0lvzsBohH02iiDQo86sQc/A1QLF26ixWi7Nvybpng99ujff5EsVlbWcL
         YNhqZJKyxxrCgTO8v+pUym4DZp5XSQRaW2G5NUMtgEwJ0gtx2L66s0xI97eTfyUhS/vm
         AiD9bHEXtpfW3yM7K927qWvjpqHYlv06h1A/BkWkuKAFxFAyM8v2C6H3DZaMERotrMQ1
         buAw==
X-Gm-Message-State: AOAM5334bapFsp0m44kXJtAtn77B+DGPFp7CYOPCrniBMZSR/2yhfXFJ
        ZzY9W3M12RCsst9W0++6L1TLUdoQcRCcjnfAK93iRQ==
X-Google-Smtp-Source: ABdhPJyMI1UajVVYge2yCsL28v/NmQmEpJ4WfUVdXK+0KPWRsZ+SNiSYd8hwXxBo8btg1zi6xsg31YVKtF3Ev5GX/6U=
X-Received: by 2002:a9f:35d0:: with SMTP id u16mr384896uad.113.1598609327689;
 Fri, 28 Aug 2020 03:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvUwH2FA9GOeA_7GYpLA31uOmEpg32VKnJ8-d5QSK4PdQ@mail.gmail.com>
 <20200827090813.fjugeqbb47fachy7@vireshk-i7> <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
 <20200827101231.smqrhqu5da6jlz6i@vireshk-i7> <CA+G9fYv=XLtsuD=tVR1HHotwpKLkbwZVyPr4UhY-jD+6-duTmw@mail.gmail.com>
 <CA+G9fYvSEHua0EpW64rASucWuS-U2STAZxufrfN75UDspGt2cA@mail.gmail.com> <CAPDyKFrpOqpBiSvkvO7sXHiQDOwdXYmx-80Ji5wW79QF-MrOuQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrpOqpBiSvkvO7sXHiQDOwdXYmx-80Ji5wW79QF-MrOuQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Aug 2020 15:38:36 +0530
Message-ID: <CA+G9fYtg=CYucGhtZNig7AoXjSSQDokddhERZH5SfEJBsRBZYg@mail.gmail.com>
Subject: Re: Kernel panic : Unable to handle kernel paging request at virtual
 address - dead address between user and kernel address ranges
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Aug 2020 at 15:05, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 28 Aug 2020 at 11:22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 27 Aug 2020 at 17:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 27 Aug 2020 at 15:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 27-08-20, 11:48, Arnd Bergmann wrote:
> > > > > > > [    3.680477]  dev_pm_opp_put_clkname+0x30/0x58
> > > > > > > [    3.683431]  sdhci_msm_probe+0x284/0x9a0
> > > > >
> > > > > dev_pm_opp_put_clkname() is part of the error handling in the
> > > > > probe function, so I would deduct there are two problems:
> > > > >
> > > > > - something failed during the probe and the driver is trying
> > > > >   to unwind
> > > > > - the error handling it self is buggy and tries to undo something
> > > > >   again that has already been undone.
> > > >
> > > > Right.
> > > >
> > > > > This points to Viresh's
> > > > > d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> > > >
> > > > I completely forgot that Ulf already pushed this patch and I was
> > > > wondering on which of the OPP core changes I wrote have done this :(
> > > >
> > > > > Most likely this is not the entire problem but it uncovered a preexisting
> > > > > bug.
> > > >
> > > > I think this is.
> > > >
> > > > Naresh: Can you please test with this diff ?
> > >
> > > I have applied your patch and tested but still see the reported problem.
> >
> > The git bisect shows that the first bad commit is,
> > d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>
> I am not sure what version of the patch you tested.

I have applied The v2 patch series on top of linux next-20200824.
and tested again the reported kernel panic still there on db410c [1]

https://lkft.validation.linaro.org/scheduler/job/1717611#L1874

- Naresh
