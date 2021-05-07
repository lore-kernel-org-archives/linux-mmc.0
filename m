Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA30C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79742613D9
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhEGHbp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEGHbp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 03:31:45 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A391C061761
        for <linux-mmc@vger.kernel.org>; Fri,  7 May 2021 00:30:46 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id j128so4250145vsc.5
        for <linux-mmc@vger.kernel.org>; Fri, 07 May 2021 00:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvrcjht1/ZDjZntlokA/5UTumpWo8GtiALSkNCm95ck=;
        b=sVmWM06agL2q7iV+PrscrJpJ4RWX2ZLaGuM8I7wLPWmsPbzWeJkUjZ4PuAnIGNRSjn
         7ZD/V+47EHcOW3Bu+ogYDAVJ1d3HMNTk5eaXMvB6LFoZJZZ4pPg+iyUQPHsdy2JPZE3K
         pHQj6+2bh5+OZTYYXIjbvhT0g9S64kKvTMKAmgMwV/sDyoivDcBY1YBixszkQbNEqaEi
         v+LWw62YydidKx67qtFimKSQqKYcLcttGDrbhp2nnW/4cmRiDeviCNza/zzCf3n8knA4
         lRzhjUUg112FDP062mmlNLrLUdqrdtgE2TvuuETGa48alWoWhN/O03p1JpLJot2JABf1
         pzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvrcjht1/ZDjZntlokA/5UTumpWo8GtiALSkNCm95ck=;
        b=V7E6Ks7JfN0VWRROylI0i01xDxQcwZTWNKZ7XCOuDDZWEjvfs9yZc6F2js+ei+4eaa
         B/IaVTP+bCl/ffP9jf15c3Ix9/R8H6aYtewfGWAuwEXfNPnu7h5pNFNo7FABIPmPiNpQ
         IiFdqg4vqV0/0PezTgOTww/EfG7k1Lq2JfTX4PFT09NoQj3mPEdJNgxstYH6XqIRwnQ+
         ym8NggUqiTe3wzMCXcsZRQ86d7dlgQ44K+xHkdhjsPiAhhjv6YTvCBpJ5KaZMt0WIS3U
         UyGb78Gn80gQdcoJF3bRZEyY6r02Bm+V4eY1UIcQYityMQ5RxOJQdxZOlZ6ORQ8SVS0X
         kMbw==
X-Gm-Message-State: AOAM532wb6eC1IfWZfileDOL+nOPiJSH8lC3LzjrChCRdKf0KTevN9OU
        zJL9eu5QvgnTKAaV6rE4WUJcTmhe7kmJAnWzjrGhi2y5ei3c7Q==
X-Google-Smtp-Source: ABdhPJzqsWTLzX8DpmPbA8dxO3PTs2XgbM4cmuBt0cLXfmbGhqm5calOMygFAWSLucTkM9uoqUlMCqZH+WMaZhtvxPQ=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr6598056vsb.19.1620372644882;
 Fri, 07 May 2021 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-7-ulf.hansson@linaro.org> <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
In-Reply-To: <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 09:30:08 +0200
Message-ID: <CAPDyKFqq7DZJA8KRhNR_b069ef0+4RCf3GVbsPFYB+kiTg+Log@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 May 2021 at 15:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> >   * NOTE: void *buf, caller for the buf is required to use DMA-capable
> >   * buffer or on-stack buffer (with some overhead in callee).
> >   */
> > -static int
> > -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> > -               u32 opcode, void *buf, unsigned len)
> > +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> > +                      u32 args, void *buf, unsigned len)
>
> Just a note here (the change is good)
>
> When applying please add some kerneldoc above mmc_send_adtc_data()
> and expand the ADTC acronym and add some info explaining what it
> is maybe a small protocol ref or so, so readers of the code get an
> intuitive feeling for what this function does and what ADTC is.

Thanks for the suggestion and the reviews, I look into this!

Kind  regards
Uffe
