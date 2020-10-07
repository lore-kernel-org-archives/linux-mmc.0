Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92012C4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5098A206A1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQymMPgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgJGMH3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2020 08:07:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0918C061755;
        Wed,  7 Oct 2020 05:07:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so1228830pff.3;
        Wed, 07 Oct 2020 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KW0s2ht39Ouu/EB2GbcDuZjBFkLGYtcCptax/qWkCLc=;
        b=nQymMPgRr17/POg6P2dCDWlNSrFMA+32njoVcM0KFT3OME1q/en7ene0pP6B/dme5X
         9u6zhdxqAljnU2d4fmyjB1sRi7/ZjLpNoq5v5a7F3m70egF5CijcaZ5uynB512vx0V+7
         kkJQiPouZUuFDcKZeCgcAOYDar5aHSePk3NfrOs7UGmAq9xW33ZmlylqsR2h67zaxwx/
         gj8r7JWiw/Bcn9oN10NHmzVMDSq5CDaAIDqtar7/GuVBNQJafaiUIavAtTp0lSXD6LUk
         8XoQcg77zkHaRLkoBWBqz30ej76U4xn0jTeI4SKTv4jfN1TX9alte/Y3UIY5BN4C37fh
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KW0s2ht39Ouu/EB2GbcDuZjBFkLGYtcCptax/qWkCLc=;
        b=rc+yki5WvUAK6/jgd1eZM3FRFaUAWs2WXVdrF8jiajPocwbRNnKwrJQdwQb2pTTA+T
         Chy6cNM74ctu6aK5UQk4BMKgEoSLyIuU2V3hMs2BHh2UmguT9bsQLxgrx9QM34x2stYd
         yt9xAS/NZMU5yKKA8gBi0XXyTdPQJ2s6uRTxLwJ32SH3EAubdHNCzckM5gH8MOHt3yNC
         N5HIayW1aA/+JfejQ7POxY9U1jyrLd7dPmR+KzjHoZV3b7bCOZXflWYE3lKxb5ITsfFD
         1maeDaL4B3yay2qGN3+sI5x/WRYURyJzYHKCo3qwp27eoe2+3/HbESuSfo6kWp5KRUrE
         AvCA==
X-Gm-Message-State: AOAM531KpiZF/1CuUZ5+mKkfR6giLwGfxqBzMO7CIivsFjIcR4jshCu5
        pRgSnXcdurB5hoCWU+59VSmnnivFhSXCnUX67ug=
X-Google-Smtp-Source: ABdhPJx3b2WAOIDMMlFj4CegpL5YCD6ZriVHJ8fOMMlceUXxCCHYdYteVAeqNackK3KMUJVf21vqFK0wO2n4s7zVn+k=
X-Received: by 2002:a62:5e81:0:b029:152:2f99:d9e3 with SMTP id
 s123-20020a625e810000b02901522f99d9e3mr2546264pfb.7.1602072447154; Wed, 07
 Oct 2020 05:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
 <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com> <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
 <f81384ff-1f7b-28ea-1ec1-2568e9f669ee@xilinx.com>
In-Reply-To: <f81384ff-1f7b-28ea-1ec1-2568e9f669ee@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 15:08:16 +0300
Message-ID: <CAHp75Vf4eh540P7C=ez05n0eyeVk1_yUmT2TJFbKbH1ZUtw+qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     muhammad.husaini.zulkifli@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lakshmi.bai.raja.subramanian@intel.com,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 7, 2020 at 12:10 PM Michal Simek <michal.simek@xilinx.com> wrote:
> On 07. 10. 20 10:55, Andy Shevchenko wrote:
> > On Wed, Oct 7, 2020 at 11:38 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:

...

> >>> +     if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
> >>> +             struct gpio_desc *uhs;
> >>> +
> >>> +             uhs = devm_gpiod_get_optional(dev, "uhs", GPIOD_OUT_HIGH);
> >>
> >> I can't see change in dt binding to record uhs gpio.
> >>
> >>
> >> Better
> >> sdhci_arasan->uhs_gpio = devm_gpiod_get_optional(dev, "uhs",
> >> GPIOD_OUT_HIGH);
> >>
> >> then you can avoid uhs variable.
> >
> > Actually it's readability vs. additional variable. It was my
> > suggestion to have a variable to make readability better.
> > Are you insisting on this change?
>
> I understand that it is just about preference.

Correct.

> I would use it directly
> not to deal with it. If your preference is via variable I am fine with
> it too.

Yes, I suggested that and I still have the same opinion (It seems the
original code tries to follow 80 character rules that's why I
suggested the change).
Thanks!

-- 
With Best Regards,
Andy Shevchenko
