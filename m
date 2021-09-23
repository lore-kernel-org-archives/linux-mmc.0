Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF384C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 20:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BB761029
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhIWUVW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbhIWUVV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 16:21:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CEEC06175F
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 13:19:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q205so9740216iod.8
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epEYiPa1v2yRHB56PEurnTlU6IObtXpXTtcKNyJNW0k=;
        b=tDVlkBZlYy8Pu0FssYMC5ZtYowrWslch1iEi0XyjJMi7g5iPMlEDpeD2XIkRv6C8qT
         D3xWy1Bzih5e2F7G73DT2kHQyoRx3G/HJRGhmRa0wA64lWXZ3XzFwkwN5Ad7HSVc1wwY
         CZwrzY0QzjvSvtfbbYjwJrmRt1jGyHk8b7b+bGaPbKIQFMlRlMqMOdljr1LJb0pkjjf6
         ue6OE4Nzs/BoYVY7r2sBOOOdKpSWJvmWTdd2xt8Y04u5k+G/pbLnGoq/2E56rAtCPTaq
         SxMfKLuoOJSO3JXPjZLbV7o42ad7UyjvnkJlCTsqB+3DbiYBJbOlKk7NXFHipVT94CBN
         zmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epEYiPa1v2yRHB56PEurnTlU6IObtXpXTtcKNyJNW0k=;
        b=arGDS0pySz+sz6DoU9xZJ2uIB4HFnCAdn4neAi4scFs2lGMkXCOrqnSOv88aYNnadi
         yrJK+i/VQIEnqb5Jg2rsuSILxx0OympHANtho5kZtop4dCUx4QYL2r3Jqk/7wMv1zWLV
         ndNP7EPKv3ki0QIV+u/8be6qeV04d7luXz4TmgR3lig6PP+GNy9J6Msc4fR8Or6mFZhg
         GBz0oBMRQrQX6UyVDE+PRJWXu3qy6hdypW9Y2pPLzf6FkpvLkdLZgIEZ+NCyV5ENaHIF
         MNI+xPoU741wsN54qiahcRMZjqFP1ODqMMAQY/2ydrwtyZMC0mIyTjkC4y6noOZt9z6x
         nG4w==
X-Gm-Message-State: AOAM530UHVmhDu4NwKR2M2ptrC0Mwb1sBPCVJ6k0DPv/VHZoOS9yBx79
        yRBZ+y6D6OHeLupLBP6ZUZFi1vS5rOv1Clce7D/J8Q==
X-Google-Smtp-Source: ABdhPJz+gcCCHfXf0lb9RZkxDyHjhi0DCzaHu2HoZSgw62nCzOWOY2X4g/UKzmg3nqnoE2zT0sUgh34o2VmXH55Dv8c=
X-Received: by 2002:a02:711e:: with SMTP id n30mr5847277jac.3.1632428388978;
 Thu, 23 Sep 2021 13:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=UqFczZ6tLzVuXhgKG9teSNTGt_RdqAxP4eXBN_eDDAtQ@mail.gmail.com> <CAD=FV=Wq-+Xzjc-o9p49pvf4A_q7L-THHp_wUQce47E+yMEgvA@mail.gmail.com>
In-Reply-To: <CAD=FV=Wq-+Xzjc-o9p49pvf4A_q7L-THHp_wUQce47E+yMEgvA@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 23 Sep 2021 13:19:37 -0700
Message-ID: <CAD=FV=WFM2APGy-_wbcW_cX8_UNDyLQo3Q2QUgiyYM28Lj64wA@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Use maximum drive strength
 values for eMMC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, cang@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Bjorn,

On Thu, Aug 19, 2021 at 6:44 AM Doug Anderson <dianders@google.com> wrote:
>
> Hi,
>
> On Tue, Aug 17, 2021 at 6:58 AM Doug Anderson <dianders@google.com> wrote:
> >
> > >                 pinconf-data {
> > >                         pins = "sdc1_data";
> > >                         bias-pull-up;
> > > -                       drive-strength = <10>;
> > > +                       drive-strength = <16>;
> >
> > I could be convinced that this is the right thing to do, but I want to
> > really make sure that it has had sufficient testing. Specifically as
> > this patch is written we'll be updating the drive strength for all
> > boards. Increasing the drive strength can sometimes introduce new
> > problems (reflections, noise, ...) so we have to be confident that
> > we're not breaking someone that used to work by increasing the drive
> > strength here. How much has this been tested?
>
> From further discussion internally, it sounds as if this should be
> fine and fixes more than just this one eMMC part. Thus:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

We've been running with this patch in the Chrome OS kernel. If it
looks OK to you, it'd be great for it to land in your tree. Thanks!

-Doug
