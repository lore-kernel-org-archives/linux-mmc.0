Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C9DC2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522F9206F9
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMq9OYF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441349AbgDPIXv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441360AbgDPIV6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 04:21:58 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C479C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 01:21:42 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id y129so1659461vkf.6
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/reHgPggcZhG4lK1Xu2pV+incftSYy8GHcr4ZbUooE=;
        b=rMq9OYF0LtRi5tqsKnHYSCyeulkSoKDcfn8p0e1GyLCQO7aQDmvujhuiuxSCotUJpO
         MgcpejIgcrWsQjIAGIT8xIndxMOBXakoo5hUr4I8RJdsvQhbSd02BeZBdOGXXZeOgv0/
         qbDUT6auHYmr5ilvgisBG0DiOK+tiMTN13fZpSiigctxIEAx4IRzpe/wHNiaiG6Ayv3K
         PDlwjZllsp/D1bsQudWLnPYb+6erNIRkvwNjdCAstp5CN71wUMAYTd6oLck9geVlwtti
         uMvymZ+MPmIxyHnnmQMMYo0nmwpt/R2lKoIMmyMBI5/M/m/Tx0fGeWscZNEUNDXY5pBN
         bjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/reHgPggcZhG4lK1Xu2pV+incftSYy8GHcr4ZbUooE=;
        b=geH6NwSwSmpdmkO/q2YRp2m2XS+yJ94sJFHhglyhEccOyQLq0alfJdBs8VM9mqBm/P
         P08EHFzsrBrclRcYxNQsWGG2EeZZVzShflIj81vw6xi79YlPqmkTGLE55PZ9oVPnPLqc
         vuahaDN0h5/NmbsCnHOukuxdXC9kM2Nu1jISocU4S+hxn0fJ4G9AO3rYaz/v28HJ6o1E
         RINj8/3FoivuGFNLSkKszox0cYTbsd3Oqj+DVi0zM5YY9hDE+DkV4sn6UfHSbuX7BXeM
         yzwDK3q7sP8xLhkJv02bEHZ0cd95Q4WcN0lLbYWXcZ2+R+sMlacNBljAFLlI+UbsUsmy
         Cdig==
X-Gm-Message-State: AGi0PubELyNREkQfQkNqX5dZAFtgViMrKkvirAe5sqlMxtwOqCHFRNUw
        yh67LujfRKR97P75XzNA9ubjURVWiJO0J3bkLpEjQg==
X-Google-Smtp-Source: APiQypJGh7LR9CvqbpYIu/kxAYhVc8j+KRUnh92CtaIwyLqGZX2FRTHmGeHZiBIo3KhwWW7YiQZDha0chu+g8V/k4fo=
X-Received: by 2002:a1f:aa48:: with SMTP id t69mr4609579vke.43.1587025301152;
 Thu, 16 Apr 2020 01:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-14-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrOFOLCWHu8nE4i5t=d+Ei-kcJ15_42Ft3ROSUDe5jkpw@mail.gmail.com>
 <3e5f8e78-7cd1-30fb-e005-78c1e7111794@codeaurora.org> <20200416033906.cl2v6wgbz3ch3clg@vireshk-i7>
In-Reply-To: <20200416033906.cl2v6wgbz3ch3clg@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 10:21:05 +0200
Message-ID: <CAPDyKFptzgZqzFJYM4_mtu4BsmfNmF=OoSfAwy7vv0j6=gmGeA@mail.gmail.com>
Subject: Re: [PATCH 13/21] mmc: sdhci-msm: Use OPP API to set clk/perf state
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Apr 2020 at 05:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-04-20, 22:13, Rajendra Nayak wrote:
> > As for the dependencies, its only PATCH 01/21 in this series and that's
> > already been queued by Viresh [2]
>
> It must be part of v5.7-rc2

Great, thanks!

KInd regards
Uffe
