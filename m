Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9BAC47247
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9BE2078C
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbmAUPvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEELdk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728869AbgEELdj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 07:33:39 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28913C0610D5
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 04:33:39 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id s5so282604uad.4
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=166ZI2PQYttk8mUuPjh9fJHZKXnQuSqSXt1RrZvFtpA=;
        b=SbmAUPviBr80iF1qScxhl5zJVFA3V7xs4iTOq1msRXtlVS5Z9A1FelEaA5QOQUWqSn
         Gciu/AaBzFBmE9zsnvklJwgF+se1u3nj/rAckeZ5e5cdWv6G/dnbkbVhbAILnHgR8ESS
         0RJNI/xujs7FxJsLMC8nNRkZLo0PDbWYVPfHWPg2m1CApz8MmMYfQf4zmiPiVH+2qRQS
         KpJhx0xg/64TubUQdiVtwLaCC/RxcIr8uKxVm8m4N4Lz4ee+Ce2Si7BmBh+ccTDUf2Ok
         cWulD+4LSCa2nf0nb8Ruoidn+kZRLzCVPbwfVcgMFxE3RM0EQsHaWeDgVB2/Rns/tTD9
         Y36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=166ZI2PQYttk8mUuPjh9fJHZKXnQuSqSXt1RrZvFtpA=;
        b=qFMCUw2Q343g3XGM2TDYlFg/YxQRaKeyj+IFrAH20BHlMwLrtX7lHileL/qHQ9eNk9
         /iLAWJjJ/iiIaslrqaQzrJ19U3uo8brXBZNBcV2WviNqC//BduqhEIwl6gAk3fkLJZWX
         raHix91IAvHC+LEhV9Mg/NdWiZicbkgS84LOSB9JPsnuS5M2bUMelsBgQKEWvAMtql25
         WAmKhLJDQuElbW4wrhsArBo+RTAEZIPdyLIyspFVFyk54X6yjhQ7C6+s7FgxYbJy7qk1
         /ZQ64v9tHOLaslvksRaKyVXnY6MiBxFPjD6Rmo5xS0mRZh2ltemPEyN9SB0WNXMYlCjZ
         MnTw==
X-Gm-Message-State: AGi0Pub1GIOs2D2YgTiBcwYe37YTYgZBseS71QhQp2sH43bQqN7Z76yi
        uEYIO+cHnlw7X5JkUKuQ6PN1OrNxUkhkCrSggE4CJQ==
X-Google-Smtp-Source: APiQypIVXSv4Xz1Q8pgiALwOrIbs+TbqKGJBWZAvFSYtSethZHtLnwLnQoOS0qNKX6URobh8SNfeXpV8uZemzz1NRmg=
X-Received: by 2002:ab0:3343:: with SMTP id h3mr1749214uap.19.1588678418386;
 Tue, 05 May 2020 04:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-10-git-send-email-rnayak@codeaurora.org> <CAPDyKFrGQvcCB1wfv=iqk66uja3faMRF1gGMSE2VhB8gJcO=sg@mail.gmail.com>
 <15efa375-cf1e-b793-1d3e-29ca0a547522@codeaurora.org>
In-Reply-To: <15efa375-cf1e-b793-1d3e-29ca0a547522@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:33:01 +0200
Message-ID: <CAPDyKFoaJTXq2qN+HXoSUovun9+4gzLeVJ-88FKbZCSCKjByLw@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] mmc: sdhci-msm: Fix error handling for dev_pm_opp_of_add_table()
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Apr 2020 at 16:09, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 4/28/2020 11:59 PM, Ulf Hansson wrote:
> > On Tue, 28 Apr 2020 at 15:39, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>
> >> Even though specifying OPP's in device tree is optional, ignoring all errors
> >> reported by dev_pm_opp_of_add_table() means we can't distinguish between a
> >> missing OPP table and a wrong/buggy OPP table. While missing OPP table
> >> (dev_pm_opp_of_add_table() returns a -ENODEV in such case) can be ignored,
> >> a wrong/buggy OPP table in device tree should make the driver error out.
> >>
> >> while we fix that, lets also fix the variable names for opp/opp_table to
> >> avoid confusion and name them opp_table/has_opp_table instead.
> >>
> >> Suggested-by: Matthias Kaehlcke <matthias@chromium.org>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Pradeep P V K <ppvk@codeaurora.org>
> >> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Cc: linux-mmc@vger.kernel.org
> >
> > Is this a standalone patch that I queue up via my mmc tree?
>
> Hi Ulf, yes, its a standalone patch which applies on top of the one
> you already have in your tree. No other dependencies.

Thanks for confirming! Perhaps next time you could add this
information as part of a description to the patch (where we usually
add patch version information).

Anyway, applied for next!

[...]

Kind regards
Uffe
