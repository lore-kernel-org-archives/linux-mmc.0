Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D37C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA032086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rL15LOzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgH1Io3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgH1IoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 04:44:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB836C06121B
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:21 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y15so137807uan.9
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTWUI5230ITwP2yP66ukJ+wNHyXX/sqNoITAtXVuFps=;
        b=rL15LOzCdw6xdKRCWQazp27CLIKDRF/eM575VOML6XSrlwujYfvPyV6ZMwSTNFGTfh
         Qpu3kZC+zFXQc4Whiw7JUr8liH2f/OoYv09CShh+CTJ5h2dGykBurLwF78MFoVXR6yeF
         T7xZ/LQaxVsDNgatt2q5xb9u5YecVoHTiCi39TdNtztkzpxEmaAYdbBzrdRrwfO2E/hb
         t0kn0QS02+/hRdKWze5VgjUdHqtvxAFwdrY5fSV8njnzbNX0Ynr0JGOzoyFuHCetJ8RT
         o2CnKaWNcV+3FC1snIr4weAmUJNZv1pBtczTVxnWfMVeBrfuzGV0aFWACzwXUg+rOvCA
         DuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTWUI5230ITwP2yP66ukJ+wNHyXX/sqNoITAtXVuFps=;
        b=nctl4ciZLVXepKHTA2PxNt7JKxJO/Ci6zTq8R1OIUO36Adl+yY/EttbCvfwjJAcVT9
         oZo4oPwOxS6JqDUNGeNTUjSRaCZIZSlFWMr3QorK6taOVRb3L9i6VQB2iRBA9vKA4UOg
         H6fn33fGFj5ckhLYQMGbiEpAETQiJc+eHSvP3QzjSXXC2pVZP/xW2Hd476HTFGNjPw1G
         dV5k+/FYbyntEeM4Lr9Q5L3Ss6QDmsruQMmyI2n2STTd92rWMBh83AZwaO3udiuhJrwg
         BJNq1uYD7LFG99l229BN2xKmZxINb4wXgnYhR1gZiPK1pBIv3W5/dyMnTJCNvEn+nxzd
         TwnA==
X-Gm-Message-State: AOAM531HWWlzKC8fR3nlSvWKtG1KY7VUVhmkcV4/3OIvu7ufELitbWJB
        L2UN7tXDXx4+gC3KDqrT4oDyJ6k2Dhf4NkKOcl64sQ==
X-Google-Smtp-Source: ABdhPJxhkzPvcP1szr4uYROolGFNyCKo7d2OSli8XptERldHHbNbbnIX/77d3DD7+J1vhaw5c7yvGuz/6wyAIsvU17o=
X-Received: by 2002:a9f:2190:: with SMTP id 16mr283460uac.19.1598604260956;
 Fri, 28 Aug 2020 01:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
 <20200828050935.m32njmxdrgbudw4r@vireshk-i7>
In-Reply-To: <20200828050935.m32njmxdrgbudw4r@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:44 +0200
Message-ID: <CAPDyKFpt+8GF9K1evMJwPQ-hwsSOiC2GQkNTFER2axw5AF+fHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0
 it's not an error
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Aug 2020 at 07:09, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-08-20, 08:33, Douglas Anderson wrote:
> > The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
> > dev_pm_opp_of_remove_table()") works fine in the case where there is
> > no OPP table.  However, if there is an OPP table then
> > dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
> > "if (ret != -ENODEV)" will evaluate to true and we'll fall into the
> > error case.  Oops.
> >
> > Let's fix this.
> >
> > Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/mmc/host/sdhci-msm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index b7e47107a31a..55101dba42bd 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -2284,7 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >
> >       /* OPP table is optional */
> >       ret = dev_pm_opp_of_add_table(&pdev->dev);
> > -     if (ret != -ENODEV) {
> > +     if (ret && ret != -ENODEV) {
> >               dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> >               goto opp_cleanup;
> >       }
>
> Wow!
>
> How many bugs did I introduce with a simple patch :(
>
> @Ulf, since this is material for 5.10 I was planning to resend the
> original patch itself with all the things fixed. Will you be able to
> rebase your tree? Or do you want to apply fixes separately ?

I have rebased my tree, to get rid of the problems completely.

Thanks everybody for helping out!

Kind regards
Uffe
