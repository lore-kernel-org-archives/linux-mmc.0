Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD39C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F0961158
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhHSNpR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhHSNpR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 09:45:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61537C061756
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 06:44:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h18so6009899ilc.5
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug1OSGTt9qLTp56AgUL2RfL1TSKASvvRSNzqRc2tcqw=;
        b=XfvaZ7ZW98kSfzUdcrLY4dFpOgBvtifT09w0hvXSRHNg0WtGEFaTODfTsIuOxZs7zi
         vBeZ1DlAaHqzXB/EpOMgzPWPDgODvbSMzvLb0HVSicDgzWNojNr3tDeMY2HFyZQoBt9O
         XlrMazdrCg8Kz5EAqXZnxUn0g5BwvYEoLQZNDIR1/Xk/QlFSSfW8DBmCoxaigl6MIkdQ
         ICPu0Z4JFoIuVPMd/RrJomE9SqGH/B5eWSHbxytuM2S/n0XS9TvtgmJ0hT4KPqnD5ACp
         HHjXeUW7AByGw8JQZYmzTv10iV96woEDRmibQiowyvtN15cK34kkiVx4u6b7ZiNtrm/C
         Y1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug1OSGTt9qLTp56AgUL2RfL1TSKASvvRSNzqRc2tcqw=;
        b=Pgv/lEGc0zjuM/NQlBcswepIrtCZtsnncY1TxCff/GPrYugjX3Wr6193eatgyBuziL
         i7UP3iYoSMT6M84VD5QPaCPDHjexYL3D0ilJYzxhZHJpKyYEN6HQqbdpj9t7vDuOkjEQ
         gY9atO1+bz0emDv5DwuZKWvqfTUzST8Rcw6ga0IG2RxY9JezgipkAsN7od2lR7kHbbP3
         uHNcQZHmmPzLimUnVL2MRkswk+6rGGIyfvakrEhucTJm8A62qrixJCDsJcFDD0+rCVWM
         57qd1qIeW+Gnivvj1JUOnEwMv1IlJrgSp4S7+qrzkDZWn3jf2zVkFsSQtTS6FhCb2zxD
         TqhQ==
X-Gm-Message-State: AOAM531sYkgjpbj0rmBqVf49t3/AF7PdYq5DrVqwJ/lXI755CwZYqF03
        Vhp0vOBk8xdKUgK7iqyxGlxUXgHJrz02m9gv0aw7Dg==
X-Google-Smtp-Source: ABdhPJwmtqmWXSprK1vhwc2gg4x6OTwPqzsJkVqyF5yv9RgHlIUTV7TV6oYqT3ZY2f6S/bmRmGGnAfG82XXx36knYQw=
X-Received: by 2002:a92:d304:: with SMTP id x4mr9982073ila.82.1629380680491;
 Thu, 19 Aug 2021 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org> <CAD=FV=UqFczZ6tLzVuXhgKG9teSNTGt_RdqAxP4eXBN_eDDAtQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UqFczZ6tLzVuXhgKG9teSNTGt_RdqAxP4eXBN_eDDAtQ@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 19 Aug 2021 06:44:27 -0700
Message-ID: <CAD=FV=Wq-+Xzjc-o9p49pvf4A_q7L-THHp_wUQce47E+yMEgvA@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Use maximum drive strength
 values for eMMC
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 17, 2021 at 6:58 AM Doug Anderson <dianders@google.com> wrote:
>
> >                 pinconf-data {
> >                         pins = "sdc1_data";
> >                         bias-pull-up;
> > -                       drive-strength = <10>;
> > +                       drive-strength = <16>;
>
> I could be convinced that this is the right thing to do, but I want to
> really make sure that it has had sufficient testing. Specifically as
> this patch is written we'll be updating the drive strength for all
> boards. Increasing the drive strength can sometimes introduce new
> problems (reflections, noise, ...) so we have to be confident that
> we're not breaking someone that used to work by increasing the drive
> strength here. How much has this been tested?

From further discussion internally, it sounds as if this should be
fine and fixes more than just this one eMMC part. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
