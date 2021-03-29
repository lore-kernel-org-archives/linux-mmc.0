Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C7C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C97C61981
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 14:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2O5T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhC2O5E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Mar 2021 10:57:04 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315AC061574
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 07:57:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x189so14060030ybg.5
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKi8HN+bpgIonbipayQY6bUaqDWQRM56PWjQCa1XcVc=;
        b=QHeXTIE0ojKJtQ0VDW1civaMMSYxCTYIxgjq32eR6dbldNbJ7h34t8c01oC8YDfRcV
         +VfX7+582QTTxV7FU2T+0vinC8y9SAnTAPI2oyf4H2fJoytHlIUn/HU1KebfH/VjGAOA
         gUDS5T0FIs1S8Hyvg6Iw76337LbQmKY4tI39R/AtDZoGCVkZy+8FqZDzE0eArbRy39Ua
         DPUVqWL1FDXXwDvhxpJZ8HpSprI9KioF7qtuh+GGsZ09Gst3MBl6CyJigBzZRWpk4aF7
         /ExD1o3GqUcKDji/hVdsgRgXcEjq/aY3FAb/1WNU6JDHKh4f6xlC3SviRJ/gTj51od+O
         juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKi8HN+bpgIonbipayQY6bUaqDWQRM56PWjQCa1XcVc=;
        b=um64gatC6F3vBqMW2quMQN5RKz7Y0QQyO70j0vVeIZuE6boA6BrNHh680vJYIjuhRM
         Hc6kgv2falkuwZ+pfIzw47vXnHmtsNCi5PKxDg0vU1mynkqLSSA9wKMqSSbt3CNCijXS
         jn+inLHB81R6w8QvVPVFrJf+vlNP09sRSsVVWnHkTqPVP5IORg/2yeE/0VI6lqYU8n+O
         UruF+YgdQGDjAsBmmwiR/rX9CnLjph/iZfokfkM80GLi54Eq4RimEMrGUTc8hPNhG6tL
         sCT77pfX1XknEB6VSpEOczBS2zFP0MRp/+cetXsNsAp/FkzIVIcyox2hB2hzMy+K+gqr
         rgmQ==
X-Gm-Message-State: AOAM533ziz3NX5kLW3MF8e+pTSOivL7dj21QZygMbJqWUgLvKegcj15P
        eRMId9dsGo+FKd14Tx4BKJup/t5thzfZvjFw3xtAgA==
X-Google-Smtp-Source: ABdhPJzu5ULT+omARvahbH1jKInTaaNAdmdNq4fRz3u1JYVIeDwdMailkmG8CbM4ZA/xaEU/YPrnxVrzakIRb4bNgp0=
X-Received: by 2002:a25:69c1:: with SMTP id e184mr38733388ybc.345.1617029823530;
 Mon, 29 Mar 2021 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org> <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
In-Reply-To: <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 29 Mar 2021 07:56:52 -0700
Message-ID: <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 25, 2021 at 11:57 PM <sbhanu@codeaurora.org> wrote:
>
> >>> +                       max-frequency = <192000000>;
> >> Why do you need to specify this?
> This helps to avoid lower speed modes running in high clock rate,
> and As Veerabhadrarao Badiganti mentioned

Just to be clear, both Stephen and I agree that you should remove
"max-frequency" here (see previous discussion). Bjorn is, of course,
the file decision maker. However, unless he says "yeah, totally keep
it in" I'd suggest dropping it from the next version.


> >>> +                                       required-opps =
> >>> <&rpmhpd_opp_low_svs>;
> >>> +                                       opp-peak-kBps = <1200000
> >>> 76000>;
> >>> +                                       opp-avg-kBps = <1200000
> >>> 50000>;
> >> Why are the kBps numbers so vastly different than the ones on sc7180
> >> for the same OPP point. That implies:
> >>
> >> a) sc7180 is wrong.
> >>
> >> b) This patch is wrong.
> >>
> >> c) The numbers are essentially random and don't really matter.
> >>
> >> Can you identify which of a), b), or c) is correct, or propose an
> >> alternate explanation of the difference?
> >>
>
> We calculated bus votes values for both sc7180 and sc7280 with ICB tool,
> above mentioned values we got for sc7280.

I don't know what an ICB tool is. Please clarify.

Also: just because a tool spits out numbers that doesn't mean it's
correct. Presumably the tool could be wrong or incorrectly configured.
We need to understand why these numbers are different.

-Doug
