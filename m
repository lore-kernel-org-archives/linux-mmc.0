Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240DC433E3
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CE3208CA
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 20:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cW9R1YXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgH0U1n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgH0U1l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 16:27:41 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5EFC06121B
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 13:27:40 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id y2so2089674uaq.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZ//jLyEGc9rQ/5ywgZs9AFGiQ4M3Jn6N3wi0W6fLTk=;
        b=cW9R1YXaVzPIgb19g8eHR8EByOO083Db4fVQIjH2ZM5PSNpYKloAXezTr/CP2u/mQA
         fvI9or4iuYtkKnYTQoORu5kv3YBwvSNmt9ZZYuPrUupI2TegHbXdJTPo5YypvYmxp8hx
         rJiqqxwpyyyZkCI0eAxr5m+KSQX1SjZBLpCz35ERVmRV7XMyrHFdzaY/PyiEvIVAq5X9
         hHQWjx4uhvCQ09u5QjwypG+jFOEFmJfRes61/kzhSe4xTo/Jk9QDPScuRoskWUDeWlXC
         2rn4iNmGYiWNVazbSXBBgM/hv6Lc0RAc09bPUmSAdDsk4LD33n2Castf2l92TfPyELj5
         77Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZ//jLyEGc9rQ/5ywgZs9AFGiQ4M3Jn6N3wi0W6fLTk=;
        b=flDztjeVu9mZHsxkc3+5NBBXDxHkiQ/kSXrQ+zuFoKB+CB+wjN8YyArb8jJmRoXKa0
         S/KDH3t1IJpxZnIAhpsAoys+p7pyIkSsxH13u+LIDswIJV1I/nRVahmu9T5Vtx5CAK6n
         oZ58UFLfF/apt2tAYyqIdazjCyjYdjCTKw7VPathgPBdLGWlgEdYhnGv31F1SQFMrD2F
         MgAG+jFA/CW5K9SfqwJSkXUXd72HReY8jdZmMs6lB4AHBQzR5tKs5Bh2kBeM+HcgDQA2
         au8WOO+vRJ0vIEBF8R9t1yrELOJMg2Qyfhs48bFbEH8NBMY5dQl0sMl3ZsBN95wFY4Rg
         tiLQ==
X-Gm-Message-State: AOAM531FhtU04OSCWCXaWjvF2X390epOp9CmrLebtNwLsBWJkOFo+qzK
        Aeac9PH141j9mEQJvK9RdwkCQda8sIS1FAfqJM9NLg==
X-Google-Smtp-Source: ABdhPJxzBjdIjLP+fic8QVRqI7i2HXnTm0gMDDu/fk4wtDvJw2bF8nvr92kZ7hQ/2QAwAvkj2Lc4HmeA0C6LORz2ceA=
X-Received: by 2002:ab0:142e:: with SMTP id b43mr14014891uae.7.1598560057400;
 Thu, 27 Aug 2020 13:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
In-Reply-To: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Aug 2020 01:57:25 +0530
Message-ID: <CA+G9fYtWpBQb8Ew_G=bjcR7wBHMgKm=EXV7vuk6FE9m0-4Ef3A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0
 it's not an error
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, vbadigan@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 Aug 2020 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
> dev_pm_opp_of_remove_table()") works fine in the case where there is
> no OPP table.  However, if there is an OPP table then
> dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
> "if (ret != -ENODEV)" will evaluate to true and we'll fall into the
> error case.  Oops.
>
> Let's fix this.
>
> Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I will test this patch and report again on this email thread.

> ---
>
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b7e47107a31a..55101dba42bd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2284,7 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         /* OPP table is optional */
>         ret = dev_pm_opp_of_add_table(&pdev->dev);
> -       if (ret != -ENODEV) {
> +       if (ret && ret != -ENODEV) {
>                 dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
>                 goto opp_cleanup;
>         }
> --
> 2.28.0.297.g1956fa8f8d-goog
>

- Naresh
