Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D23C6FD1F
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCIPFJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCIPEh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 10:04:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119FA337A
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 07:02:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h31so1219060pgl.6
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1UuKoyGa/qt1kM3jTrB1CNRJu1kNzDKksmWvUwV+P/A=;
        b=Zzqnwhpg4tw7w750sAZLKYEw0E9PcI1zwKDNTHYtYRVoeEZGRVsU2mLBkSL7AqO9rs
         ChTsDnZ1lDxM/JsAWdu6LyJ0FwD5duVhYoLdmq49489riMftNINZenMvTfxMDAAosK7y
         QackZSS5/L74/o3gfOQkkaXSkKEBYuPALAyO8tKKEjsVykYeTjOI5wYH1F6bdnAKn8Nd
         QU0wMFzFC5c1ol2a2qyPp0SqPxu/cDKon3VCtyjN/5ylB1JQj7+UFpvhSv1aVj870AYI
         pC+R/JdSzQAbeL1s3yV76na79XnMXL077p/Y/0v97GKIII17GGcZSE0bkPH+HN5HNNIE
         ObWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UuKoyGa/qt1kM3jTrB1CNRJu1kNzDKksmWvUwV+P/A=;
        b=V75bzq5UKg10IQDGlj61CRtG0Qq4Sa3i38K15Rk/XtroeEnIWp3YPPMbFcGyQjtnWx
         DgS1N0EHptX6wOswfDK226Pu5KCyqVPDMMM3V+ZtwMdlygvZ1pir9eDGQUFj7Pr/C41C
         tKLxIqMQtbx3W5OVOrkOVRZFNWcpR0jTu2xua+Oj+KIGhHmdkpwq1HjnIkC7lanF21wa
         jUgQxpDeTq2wcE4Bz+yCRp93UX63pZIgxCR7kX9HauMafLjNPXA7uh7dG4j1eQ3UiOSO
         m8bP5/7O7JPeYwsXOFMuT5SV3kXYxG7t/Wpv6dmvmPMGIyYex+pqMrHZEn0n4At0C+4C
         bBYA==
X-Gm-Message-State: AO0yUKXct1yY+wkZ8rZSzmn/I5ODHOWLTYis0UEGNrgR13gBHAz1ysFT
        pAOoPfGWjBnBladTBar9wwjv1tAJjMHyC1IZ8P33cg==
X-Google-Smtp-Source: AK7set+lo6zdvzScY98/uSXtHDj0DSNkjEIQjljB5eFKl0JoNA2NQIuovdW//0PP7VsuI8rp+IfYWZsaKFCtlXTcufA=
X-Received: by 2002:a05:6a00:2253:b0:603:51de:c0dd with SMTP id
 i19-20020a056a00225300b0060351dec0ddmr9217346pfu.6.1678374163837; Thu, 09 Mar
 2023 07:02:43 -0800 (PST)
MIME-Version: 1.0
References: <0c1e7440-f4bc-b48a-137f-58b75ac98550@gmail.com>
In-Reply-To: <0c1e7440-f4bc-b48a-137f-58b75ac98550@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:07 +0100
Message-ID: <CAPDyKFpscmx62XR6Dy4-sLBR8CB-zr7tvmuji4R_uG67eE88Xw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: allow errptr supply argument in, mmc_regulator_set_ocr
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Feb 2023 at 22:02, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Basically all host drivers use code like this:
>
> if (!IS_ERR(mmc->supply.vmmc))
>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0)
>
> Move the IS_ERR() check to mmc_regulator_set_ocr() to simplify
> host driver code.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/regulator.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 609201a46..4fad81cd5 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -110,6 +110,9 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>         int                     result = 0;
>         int                     min_uV, max_uV;
>
> +       if (IS_ERR(supply))
> +               return 0;
> +
>         if (vdd_bit) {
>                 mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
>
> --
> 2.39.2
>
